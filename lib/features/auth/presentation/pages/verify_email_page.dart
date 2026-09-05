import 'dart:async';

import 'package:botaniq/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/animated_entrance.dart';
import '../widgets/otp_code_field.dart';

/// E-posta ile kayıt olan kullanıcının, gelen 6 haneli kodu girerek
/// hesabını doğruladığı ekran.
///
/// Neden bağlantı değil de kod: e-postadaki bağlantı, mobilde tarayıcı →
/// derin bağlantı zinciri üzerinden geri dönmek zorunda ve bu zincir
/// (Supabase Redirect URL izin listesi, Gmail'in link sarmalaması, iOS'un
/// özel şema izni) her adımda kopabiliyor. Kod girişi tamamen uygulama
/// içinde kaldığı için bu kırılganlıkların hiçbirine bağlı değil.
class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key, required this.email});

  final String email;

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  final TextEditingController _codeController = TextEditingController();
  bool _isVerifying = false;
  bool _hasError = false;
  int _resendCooldown = 0;
  Timer? _cooldownTimer;

  @override
  void initState() {
    super.initState();
    // Kayıt sırasında kod zaten gönderildi; kullanıcı hemen "tekrar
    // gönder"e basıp Supabase'in dakikalık gönderim limitine takılmasın
    // diye sayaçla başlıyoruz.
    _startCooldown();
  }

  @override
  void dispose() {
    _cooldownTimer?.cancel();
    _codeController.dispose();
    super.dispose();
  }

  void _startCooldown() {
    _cooldownTimer?.cancel();
    setState(() => _resendCooldown = 60);
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() => _resendCooldown--);
      if (_resendCooldown <= 0) timer.cancel();
    });
  }

  Future<void> _verify() async {
    final l10n = AppLocalizations.of(context)!;
    final code = _codeController.text.trim();
    FocusScope.of(context).unfocus();

    if (code.length != 6) {
      setState(() => _hasError = true);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.verifyEmailEnterCode)));
      return;
    }

    setState(() {
      _isVerifying = true;
      _hasError = false;
    });

    try {
      await Supabase.instance.client.auth
          .verifyOTP(email: widget.email, token: code, type: OtpType.signup)
          .timeout(const Duration(seconds: 20));

      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.verifyEmailSuccess)));
      // verifyOTP başarılı olduğunda Supabase oturumu kurar; kök
      // yönlendiriciye dönünce main.dart'taki StreamBuilder Ana Sayfa'yı
      // gösterir.
      Navigator.of(
        context,
        rootNavigator: true,
      ).popUntil((route) => route.isFirst);
    } catch (error) {
      debugPrint('Email verification failed: $error');
      if (!mounted) return;
      setState(() {
        _hasError = true;
        _isVerifying = false;
      });
      _codeController.clear();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.verifyEmailInvalidCode)));
    }
  }

  Future<void> _resend() async {
    final l10n = AppLocalizations.of(context)!;
    if (_resendCooldown > 0) return;
    try {
      await Supabase.instance.client.auth
          .resend(type: OtpType.signup, email: widget.email)
          .timeout(const Duration(seconds: 15));
      if (!mounted) return;
      _startCooldown();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.confirmationEmailResent)));
    } catch (error) {
      debugPrint('Resend confirmation code failed: $error');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.confirmationEmailResendFailed)),
      );
    }
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AnimatedEntrance(
                delay: Duration.zero,
                child: Center(
                  child: Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.14),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.mark_email_unread_outlined,
                      color: AppColors.primary,
                      size: 34,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 26),
              AnimatedEntrance(
                delay: const Duration(milliseconds: 80),
                child: Text(
                  l10n.verifyEmailTitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              AnimatedEntrance(
                delay: const Duration(milliseconds: 140),
                child: Text(
                  l10n.verifyEmailSubtitle(widget.email),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: AppColors.textSecondary,
                    fontSize: 15,
                    height: 1.55,
                  ),
                ),
              ),
              const SizedBox(height: 36),
              AnimatedEntrance(
                delay: const Duration(milliseconds: 200),
                child: OtpCodeField(
                  controller: _codeController,
                  enabled: !_isVerifying,
                  hasError: _hasError,
                  onCompleted: (_) => _verify(),
                ),
              ),
              const SizedBox(height: 32),
              AnimatedEntrance(
                delay: const Duration(milliseconds: 260),
                child: GestureDetector(
                  onTap: _isVerifying ? null : _verify,
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
                      child: _isVerifying
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              l10n.verifyEmailButton,
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
              const SizedBox(height: 20),
              AnimatedEntrance(
                delay: const Duration(milliseconds: 320),
                child: Center(
                  child: TextButton(
                    onPressed: _resendCooldown > 0 ? null : _resend,
                    child: Text(
                      _resendCooldown > 0
                          ? l10n.verifyEmailResendIn(_resendCooldown)
                          : l10n.verifyEmailResend,
                      style: GoogleFonts.inter(
                        color: _resendCooldown > 0
                            ? AppColors.textSecondary
                            : AppColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
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
}
