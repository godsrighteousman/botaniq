import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:botaniq/l10n/app_localizations.dart';

import 'notification_access_page.dart';

class LocationAccessPage extends StatefulWidget {
  const LocationAccessPage({super.key});

  @override
  State<LocationAccessPage> createState() => _LocationAccessPageState();
}

class _LocationAccessPageState extends State<LocationAccessPage> {
  static const Color _accentGreen = Color(0xFF86D5A6);
  static const Color _lightBg = Color(0xFFF9FAF9);

  bool _isRequestingPermission = false;

  void _openNotificationAccess() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => const NotificationAccessPage(),
      ),
    );
  }

  Future<void> _requestLocationAndContinue() async {
    if (_isRequestingPermission) return;

    setState(() => _isRequestingPermission = true);
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      }
    } catch (_) {
      // Permission APIs can be unavailable on an unsupported platform. Do not
      // leave the user trapped in onboarding when that happens.
    }

    if (!mounted) return;
    setState(() => _isRequestingPermission = false);
    _openNotificationAccess();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: _lightBg,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      24,
                      8,
                      24,
                      16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: IconButton(
                            onPressed: () => Navigator.maybePop(context),
                            tooltip: l10n.commonBack,
                            color: const Color(0xFF2C3E35),
                            iconSize: 20,
                            icon: const BackButtonIcon(),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Semantics(
                          image: true,
                          label: l10n.locationAccessTitle,
                          child: ExcludeSemantics(
                            child: Container(
                              width: 140,
                              height: 140,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFE8F3EE),
                              ),
                              child: Center(
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFD6EAE1),
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: const Color(
                                          0xFFCBD5E1,
                                        ).withValues(alpha: 0.2),
                                      ),
                                      child: Icon(
                                        Icons.location_on,
                                        color: _accentGreen.withValues(
                                          alpha: 0.8,
                                        ),
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          l10n.locationAccessTitle,
                          textAlign: TextAlign.center,
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
                        const SizedBox(height: 32),
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
                        const SizedBox(height: 32),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: _accentGreen.withValues(alpha: 0.15),
                                blurRadius: 80,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: _isRequestingPermission
                                ? null
                                : _requestLocationAndContinue,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _accentGreen,
                              disabledBackgroundColor: _accentGreen.withValues(
                                alpha: 0.6,
                              ),
                              elevation: 0,
                              minimumSize: const Size.fromHeight(56),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(26),
                              ),
                            ),
                            child: Text(
                              l10n.locationEnable,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: _isRequestingPermission
                              ? null
                              : _openNotificationAccess,
                          style: TextButton.styleFrom(
                            minimumSize: const Size.fromHeight(48),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            l10n.maybeLater,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              color: const Color(0xFF6E6E73),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFeatureRow({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return MergeSemantics(
      child: Container(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Row(
          children: [
            ExcludeSemantics(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFCBD5E1).withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: const Color(0xFF2C3E35), size: 24),
              ),
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
      ),
    );
  }
}
