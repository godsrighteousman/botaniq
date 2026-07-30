import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:botaniq/l10n/app_localizations.dart';

import 'notification_access_page.dart';

class LocationAccessPage extends StatelessWidget {
  const LocationAccessPage({super.key});

  final Color _accentGreen = const Color(0xFF86D5A6);
  final Color _lightBg = const Color(0xFFF9FAF9);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: _lightBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              // Top Navigation Bar
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Color(0xFF2C3E35),
                    size: 20,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
              const SizedBox(height: 48),

              // Location Icon with animated ripples (simulated via decoration)
              Container(
                width: 140,
                height: 140,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(
                    0xFFE8F3EE,
                  ), // Soft background tint instead of border
                ),
                child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFD6EAE1), // Slightly deeper soft tint
                    ),
                    child: Center(
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFCBD5E1).withOpacity(0.05 * 4),
                        ),
                        child: Icon(
                          Icons.location_on,
                          color: _accentGreen.withOpacity(0.8),
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              Text(
                l10n.locationAccessTitle,
                style: GoogleFonts.outfit(
                  color: const Color(0xFF2C3E35),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.locationAccessSubtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: const Color(0xFF6E6E73),
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 40),

              // Feature List
              _buildFeatureRow(
                icon: Icons.eco_rounded,
                title: l10n.locationRecommendation,
                subtitle: l10n.locationRecommendationSubtitle,
              ),
              const SizedBox(height: 16),
              _buildFeatureRow(
                icon: Icons.wb_sunny_rounded,
                title: l10n.locationWeather,
                subtitle: l10n.locationWeatherSubtitle,
              ),
              const SizedBox(height: 16),
              _buildFeatureRow(
                icon: Icons.notifications_active_rounded,
                title: l10n.locationAlerts,
                subtitle: l10n.locationAlertsSubtitle,
              ),

              const Spacer(),

              // Bottom Actions
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: _accentGreen.withOpacity(0.15),
                      blurRadius: 80,
                      spreadRadius: 10,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationAccessPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _accentGreen,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                    child: Text(
                      l10n.locationEnable,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationAccessPage(),
                    ),
                  );
                },
                child: Text(
                  l10n.maybeLater,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF6E6E73),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFCBD5E1).withOpacity(0.05 * 4),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF2C3E35), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF2C3E35),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF6E6E73),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
