import 'package:botaniq/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/services/auth_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../localization/presentation/widgets/language_picker_sheet.dart';
import 'login_page.dart';
import 'sign_up_page.dart';

class LoginOptionsPage extends StatefulWidget {
  const LoginOptionsPage({super.key});

  @override
  State<LoginOptionsPage> createState() => _LoginOptionsPageState();
}

class _LoginOptionsPageState extends State<LoginOptionsPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Stack(
        children: [
          const Positioned.fill(child: _WelcomeBackdrop()),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 44,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (Navigator.canPop(context))
                                BackButton(
                                  color: Colors.white,
                                  style: IconButton.styleFrom(
                                    iconSize: 18,
                                    backgroundColor: Colors.white.withValues(
                                      alpha: 0.08,
                                    ),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                )
                              else
                                IconButton.filledTonal(
                                  onPressed: null,
                                  style: IconButton.styleFrom(
                                    disabledBackgroundColor: Colors.transparent,
                                    disabledForegroundColor: Colors.white,
                                  ),
                                  icon: const Icon(Icons.eco_rounded, size: 18),
                                ),
                              IconButton.filledTonal(
                                tooltip: l10n.selectLanguage,
                                onPressed: () async {
                                  await showAndApplyLanguagePicker(context);
                                },
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.white.withValues(
                                    alpha: 0.08,
                                  ),
                                  foregroundColor: Colors.white,
                                ),
                                icon: const Icon(
                                  Icons.translate_rounded,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Center(
                            child: Hero(
                              tag: 'logo',
                              child: Container(
                                width: 82,
                                height: 82,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.32,
                                    ),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withValues(
                                        alpha: 0.2,
                                      ),
                                      blurRadius: 32,
                                    ),
                                  ],
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Image.asset(
                                  'assets/images/botaniq_app_icon_v2.png',
                                  fit: BoxFit.cover,
                                  matchTextDirection: false,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 22),
                          Text(
                            l10n.welcomeBotaniq,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.7,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            l10n.loginOptionsSubtitle,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              color: AppColors.textSecondary,
                              fontSize: 15,
                              height: 1.5,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.07),
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.11),
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 56,
                                  child: FilledButton(
                                    onPressed: _isLoading
                                        ? null
                                        : () => _open(const SignUpPage()),
                                    style: FilledButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),
                                    child: Text(
                                      l10n.signUp,
                                      style: GoogleFonts.outfit(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: double.infinity,
                                  height: 54,
                                  child: OutlinedButton(
                                    onPressed: _isLoading
                                        ? null
                                        : () => _open(const LoginPage()),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      side: BorderSide(
                                        color: Colors.white.withValues(
                                          alpha: 0.2,
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),
                                    child: Text(
                                      l10n.login,
                                      style: GoogleFonts.outfit(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        color: Colors.white.withValues(
                                          alpha: 0.1,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      child: Text(
                                        l10n.loginWith,
                                        style: GoogleFonts.inter(
                                          color: AppColors.textSecondary,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        color: Colors.white.withValues(
                                          alpha: 0.1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _SocialButton(
                                        icon: Icons.g_mobiledata_rounded,
                                        iconSize: 30,
                                        label: 'Google',
                                        onPressed: _isLoading
                                            ? null
                                            : () => _runSocialSignIn(
                                                AuthService
                                                    .instance
                                                    .signInWithGoogle,
                                              ),
                                      ),
                                    ),
                                    if (AuthService
                                        .instance
                                        .supportsAppleSignIn) ...[
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: _SocialButton(
                                          icon: Icons.apple_rounded,
                                          label: 'Apple',
                                          onPressed: _isLoading
                                              ? null
                                              : () => _runSocialSignIn(
                                                  AuthService
                                                      .instance
                                                      .signInWithApple,
                                                ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                if (_isLoading) ...[
                                  const SizedBox(height: 16),
                                  const LinearProgressIndicator(
                                    minHeight: 2,
                                    color: AppColors.primary,
                                    backgroundColor: Colors.transparent,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _open(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  Future<void> _runSocialSignIn(Future<bool> Function() signIn) async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isLoading = true);
    try {
      final didSignIn = await signIn();
      if (didSignIn && mounted) {
        Navigator.of(
          context,
          rootNavigator: true,
        ).popUntil((route) => route.isFirst);
      }
    } catch (error) {
      debugPrint('Social sign-in failed: $error');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.subscriptionErrorGeneric)));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.iconSize = 23,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: BorderSide(color: Colors.white.withValues(alpha: 0.16)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        icon: Icon(icon, size: iconSize),
        label: Text(
          label,
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _WelcomeBackdrop extends StatelessWidget {
  const _WelcomeBackdrop();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF142A20), AppColors.darkBackground],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
      ),
      child: Stack(
        children: [
          PositionedDirectional(
            top: -130,
            end: -110,
            child: _Glow(color: AppColors.primary, size: 360),
          ),
          PositionedDirectional(
            bottom: 120,
            start: -170,
            child: _Glow(color: Color(0xFF2B7B55), size: 330),
          ),
        ],
      ),
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withValues(alpha: 0.18), Colors.transparent],
        ),
      ),
    );
  }
}
