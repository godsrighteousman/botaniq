import 'package:botaniq/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/animated_entrance.dart';
import '../widgets/otp_code_field.dart';

/// Yeni şifre belirleme ekranı. İki farklı yoldan açılabilir:
///
/// 1. **Kod ile (birincil yol)** — [email] verilerek açılır. Kullanıcı
///    e-postasına gelen 6 haneli kodu girer; önce [GoTrueClient.verifyOTP]
///    ile kurtarma oturumu açılır, hemen ardından yeni şifre yazılır.
///    Tamamen uygulama içinde kaldığı için derin bağlantıya, Supabase
///    Redirect URL izin listesine veya e-posta istemcisinin link
///    davranışına hiç bağlı değildir.
///
/// 2. **Derin bağlantı ile (yedek yol)** — [email] null gelir. Kullanıcı
///    e-postadaki bağlantıya tıklamış, `supabase_flutter` kurtarma
///    oturumunu zaten kurmuş ve main.dart'taki `passwordRecovery`
///    dinleyicisi bu sayfayı açmıştır; bu durumda kod alanı gösterilmez.
class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key, this.email});

  /// Kod ile doğrulama yolunda şifresi sıfırlanacak adres. Derin bağlantı
  /// yolunda oturum zaten kurulu olduğu için null'dır.
  final String? email;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;
  bool _codeHasError = false;

  bool get _needsCode => widget.email != null;

  @override
  void dispose() {
    _codeController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;
    FocusScope.of(context).unfocus();
    final password = _passwordController.text;
    final confirm = _confirmController.text;
    final code = _codeController.text.trim();

    if (_needsCode && code.length != 6) {
      setState(() => _codeHasError = true);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.verifyEmailEnterCode)));
      return;
    }
    if (password.isEmpty || confirm.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.fillAllFields)));
      return;
    }
    if (password != confirm) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.passwordsDoNotMatch)));
      return;
    }

    setState(() {
      _isLoading = true;
      _codeHasError = false;
    });

    try {
      if (_needsCode) {
        // Kurtarma oturumunu kodla aç. Bu başarısız olursa şifreyi
        // değiştirmeye hiç kalkışmıyoruz — hata mesajı da "kod yanlış"
        // olmalı, "şifre değiştirilemedi" değil.
        try {
          await Supabase.instance.client.auth
              .verifyOTP(
                email: widget.email!,
                token: code,
                type: OtpType.recovery,
              )
              .timeout(const Duration(seconds: 20));
        } catch (error) {
          debugPrint('Recovery code verification failed: $error');
          if (!mounted) return;
          setState(() {
            _codeHasError = true;
            _isLoading = false;
          });
          _codeController.clear();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(l10n.verifyEmailInvalidCode)));
          return;
        }
      }

      await Supabase.instance.client.auth
          .updateUser(UserAttributes(password: password))
          .timeout(const Duration(seconds: 20));

      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.passwordUpdatedSuccess)));
      // Kurtarma oturumu geçerli bir oturumdur — kullanıcıyı yeni
      // şifresiyle tekrar giriş yapmaya zorlamadan içeri alıyoruz.
      Navigator.of(
        context,
        rootNavigator: true,
      ).popUntil((route) => route.isFirst);
    } catch (error) {
      debugPrint('Password update failed: $error');
      if (!mounted) return;
      final message = error is AuthException ? error.message : error.toString();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.authError(message))));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    var step = 0;
    Duration nextDelay() => Duration(milliseconds: 60 * step++);

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            tooltip: l10n.cancel,
            icon: const Icon(Icons.close_rounded, color: Colors.white),
            onPressed: () => Navigator.of(
              context,
              rootNavigator: true,
            ).popUntil((route) => route.isFirst),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AnimatedEntrance(
                delay: nextDelay(),
                child: Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.14),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.lock_reset_rounded,
                    color: AppColors.primary,
                    size: 34,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              AnimatedEntrance(
                delay: nextDelay(),
                child: Text(
                  l10n.resetPasswordPageTitle,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              AnimatedEntrance(
                delay: nextDelay(),
                child: Text(
                  _needsCode
                      ? l10n.verifyEmailSubtitle(widget.email!)
                      : l10n.resetPasswordPageSubtitle,
                  style: GoogleFonts.inter(
                    color: AppColors.textSecondary,
                    fontSize: 15,
                    height: 1.55,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              if (_needsCode) ...[
                AnimatedEntrance(
                  delay: nextDelay(),
                  child: OtpCodeField(
                    controller: _codeController,
                    enabled: !_isLoading,
                    hasError: _codeHasError,
                  ),
                ),
                const SizedBox(height: 24),
              ],
              AnimatedEntrance(
                delay: nextDelay(),
                child: _buildPasswordField(
                  controller: _passwordController,
                  hintText: l10n.newPassword,
                  obscureText: _obscurePassword,
                  onToggleVisibility: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
              const SizedBox(height: 16),
              AnimatedEntrance(
                delay: nextDelay(),
                child: _buildPasswordField(
                  controller: _confirmController,
                  hintText: l10n.confirmNewPassword,
                  obscureText: _obscureConfirm,
                  onToggleVisibility: () =>
                      setState(() => _obscureConfirm = !_obscureConfirm),
                ),
              ),
              const SizedBox(height: 36),
              AnimatedEntrance(
                delay: nextDelay(),
                child: GestureDetector(
                  onTap: _isLoading ? null : _submit,
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
                              l10n.updatePassword,
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        textDirection: TextDirection.ltr,
        style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.inter(
            color: AppColors.textSecondary,
            fontSize: 16,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(
              Icons.lock_outline,
              color: AppColors.textSecondary,
              size: 22,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 50,
            minHeight: 50,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              obscureText
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: AppColors.textSecondary,
              size: 22,
            ),
            onPressed: onToggleVisibility,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
        ),
      ),
    );
  }
}
