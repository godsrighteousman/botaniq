import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:botaniq/l10n/app_localizations.dart';

import 'creating_sanctuary_page.dart';
import '../../../../core/services/care_notification_service.dart';

class NotificationAccessPage extends StatefulWidget {
  const NotificationAccessPage({super.key});

  @override
  State<NotificationAccessPage> createState() => _NotificationAccessPageState();
}

class _NotificationAccessPageState extends State<NotificationAccessPage> {
  static const Color _accentGreen = Color(0xFF0ED761);
  static const Color _lightBg = Color(0xFFF5F5F7);

  bool _isSubmitting = false;

  void _openCreatingSanctuary() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => const CreatingSanctuaryPage(),
      ),
    );
  }

  Future<void> _enableNotificationsAndContinue() async {
    if (_isSubmitting) return;

    setState(() => _isSubmitting = true);
    try {
      await CareNotificationService.instance.requestPermissionAndRefresh();
    } catch (_) {
      // A platform permission failure should not block the onboarding flow.
    }

    if (!mounted) return;
    setState(() => _isSubmitting = false);
    _openCreatingSanctuary();
  }

  Future<void> _skipNotificationsAndContinue() async {
    if (_isSubmitting) return;

    setState(() => _isSubmitting = true);
    try {
      await CareNotificationService.instance.markPermissionPromptSkipped();
    } catch (_) {
      // Continue even if the local preference cannot be persisted.
    }

    if (!mounted) return;
    setState(() => _isSubmitting = false);
    _openCreatingSanctuary();
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
                            onPressed: _isSubmitting
                                ? null
                                : () => Navigator.maybePop(context),
                            tooltip: l10n.commonBack,
                            color: Colors.black,
                            iconSize: 20,
                            icon: const BackButtonIcon(),
                          ),
                        ),
                        const Spacer(),
                        const SizedBox(height: 24),
                        Semantics(
                          image: true,
                          label: l10n.notificationAccessTitle,
                          child: ExcludeSemantics(
                            child: SizedBox(
                              width: 200,
                              height: 200,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _accentGreen.withValues(
                                        alpha: 0.05,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 140,
                                    height: 140,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _accentGreen.withValues(
                                        alpha: 0.15,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _accentGreen.withValues(
                                        alpha: 0.9,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: _accentGreen.withValues(
                                            alpha: 0.5,
                                          ),
                                          blurRadius: 30,
                                          spreadRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.notifications_active_rounded,
                                      color: Colors.black,
                                      size: 40,
                                    ),
                                  ),
                                  PositionedDirectional(
                                    top: 20,
                                    end: 30,
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withValues(
                                          alpha: 0.1,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.water_drop_rounded,
                                        color: Colors.blueAccent.withValues(
                                          alpha: 0.8,
                                        ),
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  PositionedDirectional(
                                    bottom: 20,
                                    start: 20,
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withValues(
                                          alpha: 0.1,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.eco_rounded,
                                        color: Colors.greenAccent.withValues(
                                          alpha: 0.8,
                                        ),
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          l10n.notificationAccessTitle,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.outfit(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          l10n.notificationAccessSubtitle,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF6E6E73),
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                        const Spacer(),
                        const SizedBox(height: 32),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: _accentGreen.withValues(alpha: 0.15),
                                blurRadius: 30,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: _isSubmitting
                                ? null
                                : _enableNotificationsAndContinue,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _accentGreen,
                              disabledBackgroundColor: _accentGreen.withValues(
                                alpha: 0.6,
                              ),
                              elevation: 0,
                              minimumSize: const Size.fromHeight(56),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              l10n.notificationTurnOn,
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
                          onPressed: _isSubmitting
                              ? null
                              : _skipNotificationsAndContinue,
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
}
