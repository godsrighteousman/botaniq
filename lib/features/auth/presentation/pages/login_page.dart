import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:botaniq/l10n/app_localizations.dart';

import '../../../../core/config/auth_redirect.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../localization/presentation/widgets/language_picker_sheet.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'reset_password_page.dart';
import 'sign_up_page.dart';
import 'verify_email_page.dart';

class LoginPage extends StatefulWidget {
  /// Kayıt ol akışından geldiğimizde, kullanıcıya hesabının oluşturulduğunu
  /// ve şimdi az önce belirlediği bilgilerle giriş yapması gerektiğini
  /// bildiren kısa bir mesaj gösterir.
  final bool showAccountCreatedMessage;

  /// Kayıt ol ekranından buraya bir e-posta önceden doldurulmuş şekilde
  /// gelinmesi gerektiğinde (örn. "bu e-posta zaten kayıtlı, giriş yap"
  /// senaryosu) kullanıcı e-postasını tekrar yazmak zorunda kalmasın diye.
  final String? initialEmail;

  const LoginPage({
    super.key,
    this.showAccountCreatedMessage = false,
    this.initialEmail,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialEmail != null) {
      _emailController.text = widget.initialEmail!;
    }
    if (widget.showAccountCreatedMessage) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.accountCreatedPleaseLogIn)));
      });
    }
  }

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

              // E-posta + şifre alanları tek AutofillGroup içinde: Android'in
              // kayıtlı parolaları öneriden çıkarabilmesi için gerekli —
              // grup ve doğru autofillHints olmadan klavye üstünde hiç
              // öneri çıkmıyor.
              AutofillGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Email Field
                    _buildTextField(
                      controller: _emailController,
                      hintText: l10n.emailAddress,
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      forceLtr: true,
                      autofillHints: const [AutofillHints.email],
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
                      autofillHints: const [AutofillHints.password],
                      onToggleVisibility: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Forgot Password
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: _showForgotPasswordSheet,
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

                          // Doğru giriş yapıldı — Android'in parola
                          // yöneticisine "bu bilgiyi kaydet?" isteğini
                          // burada tetikliyoruz.
                          TextInput.finishAutofillContext();
                          _finishAuthentication();
                        } catch (error) {
                          debugPrint('Email sign-in failed: $error');
                          if (context.mounted) {
                            if (error is AuthException &&
                                error.code == 'email_not_confirmed') {
                              // Hesap var ama e-posta henüz onaylanmamış.
                              // Kullanıcıyı bir uyarı mesajıyla baş başa
                              // bırakmak yerine doğrudan kod girme ekranına
                              // alıyoruz; kodu yoksa orada tekrar
                              // isteyebiliyor.
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      VerifyEmailPage(email: email),
                                ),
                              );
                              return;
                            }

                            // Diğer durumlarda jenerik bir mesaj yerine
                            // gerçek nedeni göster (yanlış şifre, ağ hatası
                            // vb.) — kullanıcının kendi kendine teşhis
                            // koyabilmesi için.
                            final message = error is AuthException
                                ? error.message
                                : error.toString();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(l10n.authError(message))),
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

  /// "Şifremi Unuttum" — e-posta adresini sorup Supabase'in şifre sıfırlama
  /// bağlantısını göndermesini tetikler. Bağlantı [kAuthCallbackUrl]'e
  /// yönlendirilir; kullanıcı ona tıklayınca uygulama tekrar açılır ve
  /// main.dart'taki `passwordRecovery` dinleyicisi onu [ResetPasswordPage]'e
  /// yönlendirir.
  Future<void> _showForgotPasswordSheet() async {
    final l10n = AppLocalizations.of(context)!;
    final emailController = TextEditingController(text: _emailController.text);
    bool isSending = false;

    // Sheet kapanana kadar BEKLİYORUZ, sonra yönlendiriyoruz. Sheet'i
    // kapatıp aynı karede yeni sayfa açmak, kapanma animasyonuyla açılma
    // animasyonunu çakıştırıyor ve modal perdesi ekranda asılı kalarak
    // dokunuşları yutuyordu — uygulama donmuş gibi görünüyordu.
    final sentEmail = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (sheetContext, setSheetState) {
            Future<void> submit() async {
              FocusScope.of(sheetContext).unfocus();
              final email = emailController.text.trim();
              if (email.isEmpty) {
                ScaffoldMessenger.of(
                  sheetContext,
                ).showSnackBar(SnackBar(content: Text(l10n.enterEmailAddress)));
                return;
              }
              setSheetState(() => isSending = true);
              try {
                await Supabase.instance.client.auth
                    .resetPasswordForEmail(email, redirectTo: kAuthCallbackUrl)
                    .timeout(const Duration(seconds: 10));
                if (sheetContext.mounted) {
                  Navigator.pop(sheetContext, email);
                }
              } catch (error) {
                debugPrint('Password reset request failed: $error');
                final message = error is AuthException
                    ? error.message
                    : error.toString();
                if (sheetContext.mounted) {
                  ScaffoldMessenger.of(sheetContext).showSnackBar(
                    SnackBar(content: Text(l10n.authError(message))),
                  );
                }
                // Hata hangi koşulda olursa olsun düğme yeniden
                // denenebilir hale gelmeli; aksi halde dönen gösterge
                // ekranda takılı kalıyor.
                setSheetState(() => isSending = false);
              }
            }

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
                decoration: const BoxDecoration(
                  color: AppColors.darkBackground,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: SafeArea(
                  top: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Container(
                          width: 42,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        l10n.forgotPasswordSheetTitle,
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.forgotPasswordSheetBody,
                        style: GoogleFonts.inter(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        controller: emailController,
                        hintText: l10n.emailAddress,
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        forceLtr: true,
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: isSending ? null : submit,
                        child: Container(
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.primary, Color(0xFF4FA976)],
                              begin: AlignmentDirectional.topStart,
                              end: AlignmentDirectional.bottomEnd,
                            ),
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Center(
                            child: isSending
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    l10n.sendResetLink,
                                    style: GoogleFonts.outfit(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
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
          },
        );
      },
    );

    emailController.dispose();
    if (!mounted || sentEmail == null) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.settingsPasswordResetSent)));
    // Kodu girip yeni şifreyi belirleyeceği ekrana geçiyoruz; e-postadaki
    // bağlantıya tıklamak zorunda değil.
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResetPasswordPage(email: sentEmail),
      ),
    );
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
    List<String>? autofillHints,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textDirection: forceLtr ? TextDirection.ltr : null,
        autofillHints: autofillHints,
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
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.15),
            width: 1,
          ),
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
