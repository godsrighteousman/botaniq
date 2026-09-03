import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:botaniq/l10n/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/theme/app_colors.dart';

/// Kullanıcı, e-postasına gelen şifre sıfırlama bağlantısına tıklayıp
/// uygulamaya geri döndüğünde (bkz. main.dart'taki `passwordRecovery`
/// dinleyicisi) açılan sayfa. Bu noktada Supabase zaten geçici, geçerli
/// bir "recovery" oturumu kurmuş durumdadır — burada yapılan tek şey bu
/// oturumu kullanarak yeni bir şifre belirlemek ([updateUser]).
class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;
    FocusScope.of(context).unfocus();
    final password = _passwordController.text;
    final confirm = _confirmController.text;

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

    setState(() => _isLoading = true);
    try {
      await Supabase.instance.client.auth
          .updateUser(UserAttributes(password: password))
          .timeout(const Duration(seconds: 15));
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.passwordUpdatedSuccess)));
      // Recovery oturumu zaten geçerli bir oturum — kullanıcıyı tekrar
      // giriş yapmaya zorlamadan doğrudan uygulamaya alıyoruz.
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
    return PopScope(
      canPop: false,
      child: Scaffold(
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
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.resetPasswordPageTitle,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.resetPasswordPageSubtitle,
                  style: GoogleFonts.inter(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 40),
                _buildPasswordField(
                  controller: _passwordController,
                  hintText: l10n.newPassword,
                  obscureText: _obscurePassword,
                  onToggleVisibility: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
                const SizedBox(height: 20),
                _buildPasswordField(
                  controller: _confirmController,
                  hintText: l10n.confirmNewPassword,
                  obscureText: _obscureConfirm,
                  onToggleVisibility: () =>
                      setState(() => _obscureConfirm = !_obscureConfirm),
                ),
                const SizedBox(height: 40),
                GestureDetector(
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
              ],
            ),
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
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
