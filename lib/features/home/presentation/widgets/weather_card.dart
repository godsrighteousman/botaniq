import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:botaniq/l10n/app_localizations.dart';

/// Hava durumu bilgisi kartı. Konum, sıcaklık ve bakım ipucu gösterir.
/// Botanik konsepte uygun glassmorphism tarzı tasarım.
class WeatherCard extends StatelessWidget {
  final String locationName;
  final double temperature;
  final String condition;
  final String tip;

  const WeatherCard({
    super.key,
    required this.locationName,
    required this.temperature,
    required this.condition,
    required this.tip,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final weatherInfo = _resolveWeatherVisuals(condition);
    final localizedTip = _localizedTip(l10n, condition);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: const Color(0xFFE8F5EE)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // İkon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: weatherInfo.bgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              weatherInfo.icon,
              color: weatherInfo.iconColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),

          // Konum + ipucu
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  locationName.isEmpty ? l10n.weatherTitle : locationName,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF1B3A2A),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (localizedTip.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    localizedTip,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF7A8F82),
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Sıcaklık
          Text(
            '${temperature.round()}°',
            style: GoogleFonts.outfit(
              color: const Color(0xFF1B3A2A),
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  String _localizedTip(AppLocalizations l10n, String condition) {
    final normalized = condition.toLowerCase();
    if (normalized.contains('rain') || normalized.contains('shower')) {
      return l10n.weatherRainyTip;
    }
    if (normalized.contains('storm') || normalized.contains('thunder')) {
      return l10n.weatherStormTip;
    }
    if (normalized.contains('snow')) return l10n.weatherSnowTip;
    if (normalized.contains('cloud') ||
        normalized.contains('fog') ||
        normalized.contains('mist')) {
      return l10n.weatherCloudyTip;
    }
    return l10n.weatherSunnyTip;
  }

  _WeatherVisuals _resolveWeatherVisuals(String condition) {
    final cond = condition.toLowerCase();
    if (cond.contains('cloud') || cond.contains('mist')) {
      return _WeatherVisuals(
        icon: Icons.cloud_queue_rounded,
        iconColor: Colors.blueGrey,
        bgColor: Colors.blueGrey.withOpacity(0.1),
      );
    } else if (cond.contains('rain') || cond.contains('shower')) {
      return _WeatherVisuals(
        icon: Icons.umbrella_rounded,
        iconColor: Colors.blue,
        bgColor: Colors.blue.withOpacity(0.1),
      );
    } else if (cond.contains('snow')) {
      return _WeatherVisuals(
        icon: Icons.ac_unit_rounded,
        iconColor: Colors.lightBlueAccent,
        bgColor: Colors.lightBlueAccent.withOpacity(0.1),
      );
    } else if (cond.contains('storm') || cond.contains('thunder')) {
      return _WeatherVisuals(
        icon: Icons.thunderstorm_rounded,
        iconColor: Colors.amber,
        bgColor: Colors.amber.withOpacity(0.1),
      );
    }
    return _WeatherVisuals(
      icon: Icons.wb_sunny_rounded,
      iconColor: const Color(0xFFFFB347),
      bgColor: const Color(0xFFFFF3D4),
    );
  }
}

class _WeatherVisuals {
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  const _WeatherVisuals({
    required this.icon,
    required this.iconColor,
    required this.bgColor,
  });
}
