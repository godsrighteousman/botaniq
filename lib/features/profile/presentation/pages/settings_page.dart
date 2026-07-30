import 'package:botaniq/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/locale/locale_provider.dart';
import '../../../../core/services/care_notification_service.dart';
import 'edit_profile_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  static const _background = Color(0xFFF5F9F6);
  static const _surface = Colors.white;
  static const _ink = Color(0xFF20352A);
  static const _muted = Color(0xFF7A8F82);
  static const _green = Color(0xFF0ED761);
  static const _deepGreen = Color(0xFF174B32);
  static const _softGreen = Color(0xFFDDF8E8);
  static const _violet = Color(0xFF6C63D8);
  static const _warm = Color(0xFFF4A950);

  static const _darkModeKey = 'settings_dark_mode';
  static const _metricSystemKey = 'settings_metric_system';

  bool _isDarkMode = false;
  bool _useMetricSystem = true;
  bool _preferencesLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      // Eski sürümlerde kullanıcıdan alınmış olabilecek anahtarı temizle.
      await preferences.remove('openai_api_key');
      if (!mounted) {
        return;
      }
      setState(() {
        _isDarkMode = preferences.getBool(_darkModeKey) ?? false;
        _useMetricSystem = preferences.getBool(_metricSystemKey) ?? true;
        _preferencesLoaded = true;
      });
    } catch (error) {
      debugPrint('Ayarlar yüklenemedi: $error');
      if (mounted) {
        setState(() => _preferencesLoaded = true);
      }
    }
  }

  Future<void> _setDarkMode(bool value) async {
    setState(() => _isDarkMode = value);
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_darkModeKey, value);
  }

  Future<void> _setMetricSystem(bool value) async {
    setState(() => _useMetricSystem = value);
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_metricSystemKey, value);
  }

  AppLocalizations get _l10n => AppLocalizations.of(context)!;

  String _currentLanguageLabel(LocaleProvider provider) {
    switch (provider.currentLanguageCode) {
      case 'en':
        return _l10n.english;
      case 'tr':
        return _l10n.turkish;
      default:
        return _l10n.systemLanguage;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = context.watch<LocaleProvider>();

    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 44),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 18),
                    _buildIntroCard(),
                    const SizedBox(height: 28),
                    _buildSectionHeading(
                      _l10n.preferences,
                      _l10n.settingsLocalPreference,
                    ),
                    const SizedBox(height: 10),
                    _buildPreferencesCard(localeProvider),
                    const SizedBox(height: 26),
                    _buildSectionHeading(
                      _l10n.account,
                      _l10n.settingsAccountSubtitle,
                    ),
                    const SizedBox(height: 10),
                    _buildAccountCard(),
                    const SizedBox(height: 90),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Material(
          color: _surface,
          borderRadius: BorderRadius.circular(17),
          child: InkWell(
            borderRadius: BorderRadius.circular(17),
            onTap: () => Navigator.pop(context),
            child: const SizedBox(
              width: 46,
              height: 46,
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: _ink,
                size: 18,
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Text(
          _l10n.settings,
          style: GoogleFonts.outfit(
            color: _ink,
            fontSize: 28,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildIntroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 18, 18),
      decoration: BoxDecoration(
        color: _deepGreen,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: _deepGreen.withValues(alpha: 0.16),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            right: -10,
            top: -18,
            child: Transform.rotate(
              angle: -0.2,
              child: Icon(
                Icons.spa_rounded,
                size: 110,
                color: _green.withValues(alpha: 0.14),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.tune_rounded,
                  color: Colors.white,
                  size: 21,
                ),
              ),
              const SizedBox(height: 30),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 300),
                child: Text(
                  _l10n.settingsSubtitle,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    height: 1.18,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildStatusDot(
                    Icons.dark_mode_rounded,
                    _isDarkMode,
                    _violet,
                  ),
                  const SizedBox(width: 8),
                  _buildStatusDot(
                    Icons.straighten_rounded,
                    _useMetricSystem,
                    _warm,
                  ),
                  const SizedBox(width: 8),
                  _buildStatusDot(
                    Icons.translate_rounded,
                    true,
                    const Color(0xFF2D8BCB),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusDot(IconData icon, bool active, Color color) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: active
            ? color.withValues(alpha: 0.22)
            : Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: active
              ? color.withValues(alpha: 0.5)
              : Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Icon(
        icon,
        size: 16,
        color: active ? Colors.white : Colors.white.withValues(alpha: 0.35),
      ),
    );
  }

  Widget _buildSectionHeading(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    color: _ink,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(color: _muted, fontSize: 11),
                ),
              ],
            ),
          ),
          Container(
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              color: _green,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesCard(LocaleProvider localeProvider) {
    if (!_preferencesLoaded) {
      return Container(
        height: 196,
        decoration: _cardDecoration(),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(color: _green),
      );
    }

    return _buildGroupCard([
      _SettingsRow(
        icon: Icons.dark_mode_outlined,
        iconColor: _violet,
        title: _l10n.darkMode,
        subtitle: _l10n.settingsDarkModeSubtitle,
        trailing: _GardenSwitch(
          value: _isDarkMode,
          activeColor: _violet,
          onChanged: _setDarkMode,
        ),
      ),
      _SettingsRow(
        icon: Icons.straighten_rounded,
        iconColor: _warm,
        title: _l10n.metricSystem,
        subtitle: _l10n.metricSystemSubtitle,
        trailing: _GardenSwitch(
          value: _useMetricSystem,
          activeColor: _green,
          onChanged: _setMetricSystem,
        ),
      ),
      _SettingsRow(
        icon: Icons.translate_rounded,
        iconColor: const Color(0xFF2D8BCB),
        title: _l10n.language,
        subtitle: _l10n.languageSubtitle,
        badge: _currentLanguageLabel(localeProvider),
        onTap: () => _showLanguageBottomSheet(context),
      ),
    ]);
  }

  Widget _buildAccountCard() {
    return _buildGroupCard([
      _SettingsRow(
        icon: Icons.person_outline_rounded,
        iconColor: _deepGreen,
        title: _l10n.editProfile,
        subtitle: _l10n.settingsEditProfileSubtitle,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const EditProfilePage()),
        ),
      ),
      _SettingsRow(
        icon: Icons.lock_reset_rounded,
        iconColor: _violet,
        title: _l10n.changePassword,
        subtitle: _l10n.settingsPasswordSubtitle,
        onTap: _showPasswordResetConfirmation,
      ),
      _SettingsRow(
        icon: Icons.diamond_outlined,
        iconColor: _warm,
        title: _l10n.subscriptionManagement,
        subtitle: _l10n.settingsSubscriptionSubtitle,
        badge: _l10n.premium,
        onTap: () => _showSnack(_l10n.settingsComingSoon),
      ),
    ]);
  }

  Widget _buildGroupCard(List<_SettingsRow> rows) {
    return Container(
      decoration: _cardDecoration(),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          for (var index = 0; index < rows.length; index++) ...[
            _buildSettingsRow(rows[index]),
            if (index != rows.length - 1)
              const Divider(
                height: 1,
                thickness: 1,
                color: Color(0xFFEDF2EE),
                indent: 74,
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildSettingsRow(_SettingsRow item) {
    final row = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: item.iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(item.icon, color: item.iconColor, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: GoogleFonts.inter(
                    color: _ink,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.subtitle,
                  style: GoogleFonts.inter(
                    color: _muted,
                    fontSize: 11,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          if (item.badge != null)
            Container(
              constraints: const BoxConstraints(maxWidth: 92),
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
              decoration: BoxDecoration(
                color: _background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                item.badge!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  color: _deepGreen,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          if (item.trailing != null) item.trailing!,
          if (item.onTap != null) ...[
            const SizedBox(width: 6),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: _muted.withValues(alpha: 0.45),
              size: 14,
            ),
          ],
        ],
      ),
    );

    if (item.onTap == null) {
      return row;
    }
    return Material(
      color: Colors.transparent,
      child: InkWell(onTap: item.onTap, child: row),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: _surface,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: const Color(0xFFEAF0EB)),
      boxShadow: [
        BoxShadow(
          color: _ink.withValues(alpha: 0.045),
          blurRadius: 22,
          offset: const Offset(0, 9),
        ),
      ],
    );
  }

  void _showLanguageBottomSheet(BuildContext context) {
    final provider = context.read<LocaleProvider>();
    final currentCode = provider.currentLanguageCode;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) => Container(
        decoration: const BoxDecoration(
          color: _surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD7E1DA),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: _softGreen,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.translate_rounded,
                        color: _deepGreen,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 13),
                    Text(
                      _l10n.selectLanguage,
                      style: GoogleFonts.outfit(
                        color: _ink,
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildLanguageOption(
                  title: _l10n.systemLanguage,
                  subtitle: _systemLocaleName(),
                  icon: Icons.phone_android_rounded,
                  selected: currentCode == null,
                  onTap: () => _selectLanguage(sheetContext, provider, null),
                ),
                const SizedBox(height: 9),
                _buildLanguageOption(
                  title: 'English',
                  subtitle: _l10n.languageEnglish,
                  emoji: '🇺🇸',
                  selected: currentCode == 'en',
                  onTap: () => _selectLanguage(sheetContext, provider, 'en'),
                ),
                const SizedBox(height: 9),
                _buildLanguageOption(
                  title: 'Türkçe',
                  subtitle: _l10n.languageTurkish,
                  emoji: '🇹🇷',
                  selected: currentCode == 'tr',
                  onTap: () => _selectLanguage(sheetContext, provider, 'tr'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption({
    required String title,
    required String subtitle,
    IconData? icon,
    String? emoji,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: selected ? _softGreen : _background,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
          child: Row(
            children: [
              SizedBox(
                width: 30,
                child: emoji != null
                    ? Text(emoji, style: const TextStyle(fontSize: 22))
                    : Icon(icon, color: _deepGreen, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        color: _ink,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subtitle != title)
                      Text(
                        subtitle,
                        style: GoogleFonts.inter(color: _muted, fontSize: 11),
                      ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: selected ? _green : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected ? _green : const Color(0xFFCAD7CE),
                    width: 1.5,
                  ),
                ),
                child: selected
                    ? const Icon(Icons.check_rounded, color: _ink, size: 16)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectLanguage(
    BuildContext sheetContext,
    LocaleProvider provider,
    String? languageCode,
  ) {
    Navigator.pop(sheetContext);
    provider.setLocale(languageCode);
    CareNotificationService.instance.refreshSchedules();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _showSnack(AppLocalizations.of(context)!.languageChanged);
      }
    });
  }

  String _systemLocaleName() {
    final code = WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    if (code == 'tr') {
      return 'Türkçe';
    }
    if (code == 'en') {
      return 'English';
    }
    return code.toUpperCase();
  }

  void _showPasswordResetConfirmation() {
    final email = Supabase.instance.client.auth.currentUser?.email;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => Container(
        padding: const EdgeInsets.fromLTRB(22, 14, 22, 24),
        decoration: const BoxDecoration(
          color: _surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFD7E1DA),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(height: 22),
              Container(
                width: 58,
                height: 58,
                decoration: const BoxDecoration(
                  color: _softGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.mark_email_read_outlined,
                  color: _deepGreen,
                  size: 27,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                _l10n.changePassword,
                style: GoogleFonts.outfit(
                  color: _ink,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _l10n.settingsPasswordSubtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: _muted,
                  fontSize: 13,
                  height: 1.45,
                ),
              ),
              if (email != null) ...[
                const SizedBox(height: 8),
                Text(
                  email,
                  style: GoogleFonts.inter(
                    color: _deepGreen,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
              const SizedBox(height: 22),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(sheetContext),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        foregroundColor: _ink,
                        side: const BorderSide(color: Color(0xFFDDE7E0)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(_l10n.cancel),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton(
                      onPressed: email == null
                          ? null
                          : () async {
                              Navigator.pop(sheetContext);
                              await _sendPasswordReset(email);
                            },
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        backgroundColor: _deepGreen,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(_l10n.continueAction),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendPasswordReset(String email) async {
    try {
      await Supabase.instance.client.auth.resetPasswordForEmail(email);
      if (mounted) {
        _showSnack(_l10n.settingsPasswordResetSent);
      }
    } on AuthException catch (error) {
      if (mounted) {
        _showSnack(error.message);
      }
    }
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: _deepGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
  }
}

class _SettingsRow {
  const _SettingsRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.badge,
    this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final String? badge;
  final VoidCallback? onTap;
}

class _GardenSwitch extends StatelessWidget {
  const _GardenSwitch({
    required this.value,
    required this.activeColor,
    required this.onChanged,
  });

  final bool value;
  final Color activeColor;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      toggled: value,
      child: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: Colors.white,
        activeTrackColor: activeColor,
        inactiveThumbColor: Colors.white,
        inactiveTrackColor: const Color(0xFFDCE5DF),
      ),
    );
  }
}
