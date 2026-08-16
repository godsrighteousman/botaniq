import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:botaniq/l10n/app_localizations.dart';

import '../../../../core/services/auth_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../localization/presentation/widgets/language_picker_sheet.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: Colors.white,
          style: IconButton.styleFrom(iconSize: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            tooltip: l10n.selectLanguage,
            onPressed: () async {
              await showAndApplyLanguagePicker(context);
            },
            icon: const Icon(
              Icons.translate_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.welcomeBack,
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.loginSubtitle,
                style: GoogleFonts.inter(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 48),

              // Email Field
              _buildTextField(
                controller: _emailController,
                hintText: l10n.emailAddress,
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                forceLtr: true,
              ),
              const SizedBox(height: 24),

              // Password Field
              _buildTextField(
                controller: _passwordController,
                hintText: l10n.password,
                icon: Icons.lock_outline,
                obscureText: _obscurePassword,
                isPassword: true,
                forceLtr: true,
                onToggleVisibility: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              const SizedBox(height: 12),

              // Forgot Password
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    l10n.forgotPassword,
                    style: GoogleFonts.inter(
                      color: AppColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Log In Button
              GestureDetector(
                onTap: _isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
                        final email = _emailController.text.trim();
                        final password = _passwordController.text;

                        if (email.isEmpty || password.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.enterEmailPassword)),
                          );
                          return;
                        }

                        setState(() => _isLoading = true);

                        try {
                          await Supabase.instance.client.auth
                              .signInWithPassword(
                                email: email,
                                password: password,
                              )
                              .timeout(const Duration(seconds: 10));

                          _finishAuthentication();
                        } catch (error) {
                          debugPrint('Email sign-in failed: $error');
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(l10n.subscriptionErrorGeneric),
                              ),
                            );
                          }
                        } finally {
                          if (mounted) {
                            setState(() => _isLoading = false);
                          }
                        }
                      },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, Color(0xFF4FA976)],
                      begin: AlignmentDirectional.topStart,
                      end: AlignmentDirectional.bottomEnd,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Center(
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            l10n.login,
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                  ),
                ),
              ),
              if (kDebugMode) ...[
                const SizedBox(height: 16),
                TextButton(
                  onPressed: _isLoading
                      ? null
                      : () async {
                          setState(() => _isLoading = true);
                          try {
                            final timestamp =
                                DateTime.now().millisecondsSinceEpoch;
                            final devEmail = 'dev_$timestamp@botaniq.test';
                            final devPassword = 'DevPassword123!';

                            final AuthResponse res = await Supabase
                                .instance
                                .client
                                .auth
                                .signUp(email: devEmail, password: devPassword);

                            if (res.user != null) {
                              await Supabase.instance.client
                                  .from('users')
                                  .insert({
                                    'id': res.user!.id,
                                    'full_name': 'Developer',
                                    'email': devEmail,
                                  });
                            }

                            _finishAuthentication();
                          } catch (error) {
                            debugPrint('Developer sign-in failed: $error');
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(l10n.subscriptionErrorGeneric),
                                ),
                              );
                            }
                          } finally {
                            if (mounted) {
                              setState(() => _isLoading = false);
                            }
                          }
                        },
                  child: Text(
                    l10n.developerSession,
                    style: GoogleFonts.outfit(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 48),

              // Divider
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.white.withValues(alpha: 0.1),
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      l10n.loginWith,
                      style: GoogleFonts.inter(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.white.withValues(alpha: 0.1),
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Social Logins
              Row(
                children: [
                  Expanded(
                    child: _buildSocialLoginButton(
                      icon: Icons.g_mobiledata,
                      iconSize: 32,
                      label: 'Google',
                      onTap: _isLoading ? () {} : _nativeGoogleSignIn,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildSocialLoginButton(
                      icon: Icons.apple,
                      label: 'Apple',
                      onTap: _isLoading ? () {} : _nativeAppleSignIn,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 48),

              // Bottom Register link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.noAccount,
                    style: GoogleFonts.inter(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      l10n.signUp,
                      style: GoogleFonts.inter(
                        color: AppColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _nativeGoogleSignIn() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isLoading = true);
    try {
      final didSignIn = await AuthService.instance.signInWithGoogle();
      if (didSignIn) {
        _finishAuthentication();
      }
    } catch (e) {
      debugPrint('Google sign-in failed: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.subscriptionErrorGeneric)));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _nativeAppleSignIn() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isLoading = true);
    try {
      final didSignIn = await AuthService.instance.signInWithApple();
      if (didSignIn) {
        _finishAuthentication();
      }
    } catch (error) {
      debugPrint('Apple sign-in failed: $error');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.subscriptionErrorGeneric)));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _finishAuthentication() {
    if (!mounted) {
      return;
    }
    Navigator.of(
      context,
      rootNavigator: true,
    ).popUntil((route) => route.isFirst);
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    bool isPassword = false,
    VoidCallback? onToggleVisibility,
    TextInputType keyboardType = TextInputType.text,
    bool forceLtr = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1), width: 1),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textDirection: forceLtr ? TextDirection.ltr : null,
        style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.inter(
            color: AppColors.textSecondary,
            fontSize: 16,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(icon, color: AppColors.textSecondary, size: 22),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 50,
            minHeight: 50,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.textSecondary,
                    size: 22,
                  ),
                  onPressed: onToggleVisibility,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
        ),
      ),
    );
  }

  Widget _buildSocialLoginButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    double iconSize = 24,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.15), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: iconSize),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
