import 'dart:convert';
import 'package:http/http.dart' as http;

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
      cityName: city.isEmpty ? 'San Francisco' : city,
      temperature: 72.0,
      condition: 'Sunny',
      tip: 'Sunny, perfect for watering',
    );
  }
}

class WeatherService {
  static Future<WeatherData> getWeather(String city) async {
    final cleanCity = city.trim();
    if (cleanCity.isEmpty) {
      return WeatherData.defaultData('San Francisco');
    }

    try {
      // 1. Geocode city name to lat/long using open-meteo geocoding api (no keys required)
      final geoUrl = Uri.parse(
        'https://geocoding-api.open-meteo.com/v1/search?name=${Uri.encodeComponent(cleanCity)}&count=1&language=en&format=json',
      );
      final geoResponse = await http.get(geoUrl);
      if (geoResponse.statusCode != 200) {
        return WeatherData.defaultData(cleanCity);
      }

      final geoData = jsonDecode(geoResponse.body);
      final results = geoData['results'];
      if (results == null || results.isEmpty) {
        return WeatherData.defaultData(cleanCity);
      }

      final double lat = results[0]['latitude'];
      final double lon = results[0]['longitude'];
      final String resolvedCity = results[0]['name'] ?? cleanCity;

      // 2. Fetch current weather
      final weatherUrl = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true',
      );
      final weatherResponse = await http.get(weatherUrl);
      if (weatherResponse.statusCode != 200) {
        return WeatherData.defaultData(resolvedCity);
      }

      final weatherData = jsonDecode(weatherResponse.body);
      final current = weatherData['current_weather'];
      if (current == null) {
        return WeatherData.defaultData(resolvedCity);
      }

      final double tempCelsius = current['temperature']?.toDouble() ?? 22.0;
      // Convert to Fahrenheit for premium UI match (72° in mock data was likely Fahrenheit)
      final double tempFahrenheit = (tempCelsius * 9 / 5) + 32;

      final int code = current['weathercode']?.toInt() ?? 0;
      final String condition = _getConditionFromCode(code);
      final String tip = _getTipFromCondition(condition);

      return WeatherData(
        cityName: resolvedCity,
        temperature: tempFahrenheit,
        condition: condition,
        tip: tip,
      );
    } catch (_) {
      return WeatherData.defaultData(cleanCity);
    }
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
        return 'Sunny, perfect day to water your plants!';
      case 'Partly Cloudy':
        return 'Milder sunlight. Check soil humidity.';
      case 'Rainy':
      case 'Showers':
      case 'Thunderstorm':
        return 'High humidity outside. Avoid overwatering.';
      case 'Foggy':
      case 'Cloudy':
        return 'Lower evaporation rate. Adjust scheduled tasks.';
      case 'Snowy':
        return 'Cold waves. Keep sensitive plants inside!';
      default:
        return 'Perfect atmosphere for your green garden.';
    }
  }
}
