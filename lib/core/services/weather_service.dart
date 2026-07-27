import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';

class WeatherData {
  final String cityName;
  final double temperature;
  final String condition;
  final String tip;

  WeatherData({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.tip,
  });

  factory WeatherData.defaultData(String city) {
    return WeatherData(
      cityName: city.isEmpty ? 'İstanbul' : city,
      temperature: 22.0,
      condition: 'Sunny',
      tip: 'Güneşli, bitkilerinizi sulamak için harika bir gün!',
    );
  }
}

class WeatherService {
  /// Tüm çağrılar timeout'lu. Worst-case toplam ~5s (eskiden 16s+).
  static Future<WeatherData> getWeather(String preferredCity) async {
    double? lat;
    double? lon;
    String resolvedCityName = preferredCity.trim();

    // 1) GPS konumu al — toplam 5s timeout
    try {
      final hasGps = await _checkLocationPermission().timeout(
        const Duration(seconds: 2),
        onTimeout: () => false,
      );
      if (hasGps) {
        final position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.low,
            timeLimit: Duration(seconds: 3),
          ),
        );
        lat = position.latitude;
        lon = position.longitude;

        // Reverse geocode — arka planda, başarısız olursa sorun yok
        resolvedCityName = await _reverseGeocode(lat, lon) ?? 'Mevcut Konum';
      }
    } catch (e) {
      debugPrint('GPS fetch failed or timed out: $e');
    }

    // 2) GPS başarısızsa, tercih edilen şehir ile geocode et
    if ((lat == null || lon == null) && resolvedCityName.isNotEmpty) {
      try {
        final geoData = await _geocodeCity(
          resolvedCityName,
        ).timeout(const Duration(seconds: 3));
        if (geoData != null) {
          lat = geoData['latitude'];
          lon = geoData['longitude'];
          resolvedCityName = geoData['city'];
        }
      } catch (e) {
        debugPrint('Geocoding failed for $resolvedCityName: $e');
      }
    }

    // 3) Hâlâ null ise IP-based konum
    if (lat == null || lon == null) {
      try {
        final ipData = await _getIPBasedLocation().timeout(
          const Duration(seconds: 3),
        );
        if (ipData != null) {
          lat = ipData['latitude'];
          lon = ipData['longitude'];
          resolvedCityName = ipData['city'];
        }
      } catch (e) {
        debugPrint('IP check fallback failed: $e');
      }
    }

    // 4) Absolute fallback — İstanbul
    if (lat == null || lon == null) {
      lat = 41.0136;
      lon = 28.955;
      resolvedCityName = resolvedCityName.isEmpty
          ? 'İstanbul'
          : resolvedCityName;
    }

    // 5) Hava durumu API — 4s timeout
    try {
      final weatherUrl = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true',
      );
      final response = await http
          .get(weatherUrl)
          .timeout(const Duration(seconds: 4));
      if (response.statusCode == 200) {
        final weatherData = jsonDecode(response.body);
        final current = weatherData['current_weather'];
        if (current != null) {
          final double tempCelsius = current['temperature']?.toDouble() ?? 22.0;
          final int code = current['weathercode']?.toInt() ?? 0;
          final String condition = _getConditionFromCode(code);
          final String tip = _getTipFromCondition(condition);

          return WeatherData(
            cityName: resolvedCityName,
            temperature: tempCelsius,
            condition: condition,
            tip: tip,
          );
        }
      }
    } catch (e) {
      debugPrint('Open-meteo call error: $e');
    }

    return WeatherData.defaultData(resolvedCityName);
  }

  static Future<String?> _reverseGeocode(double lat, double lon) async {
    try {
      final reverseUrl = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?lat=$lat&lon=$lon&format=json&accept-language=tr',
      );
      final response = await http
          .get(reverseUrl, headers: {'User-Agent': 'BotaniqApp'})
          .timeout(const Duration(seconds: 3));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final address = data['address'];
        if (address != null) {
          return address['city'] ??
              address['town'] ??
              address['village'] ??
              address['province'] ??
              'Mevcut Konum';
        }
      }
    } catch (_) {}
    return null;
  }

  static Future<bool> _checkLocationPermission() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return false;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return false;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return false;
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<Map<String, dynamic>?> _getIPBasedLocation() async {
    try {
      final response = await http
          .get(Uri.parse('https://ipapi.co/json/'))
          .timeout(const Duration(seconds: 3));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'city': data['city'] ?? 'İstanbul',
          'latitude': data['latitude']?.toDouble() ?? 41.0136,
          'longitude': data['longitude']?.toDouble() ?? 28.955,
        };
      }
    } catch (_) {}
    return null;
  }

  static Future<Map<String, dynamic>?> _geocodeCity(String city) async {
    try {
      final geoUrl = Uri.parse(
        'https://geocoding-api.open-meteo.com/v1/search?name=${Uri.encodeComponent(city)}&count=1&language=tr&format=json',
      );
      final response = await http
          .get(geoUrl)
          .timeout(const Duration(seconds: 3));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = data['results'];
        if (results != null && results.isNotEmpty) {
          return {
            'city': results[0]['name'] ?? city,
            'latitude': results[0]['latitude']?.toDouble(),
            'longitude': results[0]['longitude']?.toDouble(),
          };
        }
      }
    } catch (_) {}
    return null;
  }

  static String _getConditionFromCode(int code) {
    if (code == 0) return 'Sunny';
    if (code >= 1 && code <= 3) return 'Partly Cloudy';
    if (code >= 45 && code <= 48) return 'Foggy';
    if (code >= 51 && code <= 67) return 'Rainy';
    if (code >= 71 && code <= 77) return 'Snowy';
    if (code >= 80 && code <= 82) return 'Showers';
    if (code >= 95 && code <= 99) return 'Thunderstorm';
    return 'Cloudy';
  }

  static String _getTipFromCondition(String condition) {
    switch (condition) {
      case 'Sunny':
        return 'Güneşli, bitkilerinizi sulamak için harika bir gün!';
      case 'Partly Cloudy':
        return 'Yarı bulutlu. Toprak nemini kontrol edip sulayabilirsiniz.';
      case 'Rainy':
      case 'Showers':
        return 'Yağmurlu ve nemli hava. Ev dışı bitkileri fazla sulamayın.';
      case 'Thunderstorm':
        return 'Fırtınalı. Hassas saksı bitkilerinizi korunaklı yere alın.';
      case 'Foggy':
      case 'Cloudy':
        return 'Kapalı hava. Buharlaşma az olacağından sulamayı azaltın.';
      case 'Snowy':
        return 'Kar yağışlı ve soğuk. Bitkileri soğuk şokundan koruyun!';
      default:
        return 'Bitkileriniz için dengeli bir gün.';
    }
  }
}
