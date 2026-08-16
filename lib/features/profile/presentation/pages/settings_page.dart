import 'package:botaniq/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/locale/locale_provider.dart';
import '../../../../core/locale/supported_app_locale.dart';
import '../../../../core/services/care_notification_service.dart';
import '../../../localization/presentation/widgets/language_picker_sheet.dart';
import '../../../subscription/presentation/controllers/subscription_controller.dart';
import '../../../subscription/presentation/pages/subscription_page.dart';
import 'edit_profile_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  static const _green = Color(0xFF0ED761);
  static const _deepGreen = Color(0xFF174B32);
  static const _softGreen = Color(0xFFDDF8E8);
  static const _violet = Color(0xFF6C63D8);
  static const _warm = Color(0xFFF4A950);

  Color get _background => Theme.of(context).scaffoldBackgroundColor;
  Color get _surface => Theme.of(context).colorScheme.surface;
  Color get _ink => Theme.of(context).colorScheme.onSurface;
  Color get _muted => Theme.of(context).colorScheme.onSurfaceVariant;

  AppLocalizations get _l10n => AppLocalizations.of(context)!;

  String _currentLanguageLabel(LocaleProvider provider) {
    final tag = provider.currentLocaleTag;
    return tag == null
        ? _l10n.systemLanguage
        : SupportedAppLocales.byTag(tag)?.nativeName ?? tag;
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
                    _buildIntroCard(localeProvider),
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
          child: SizedBox(
            width: 46,
            height: 46,
            child: BackButton(
              color: _ink,
              style: IconButton.styleFrom(
                iconSize: 18,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
              ),
              onPressed: () => Navigator.pop(context),
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

  Widget _buildIntroCard(LocaleProvider preferences) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 18, 18),
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
          PositionedDirectional(
            end: -10,
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
                    preferences.themePreference != AppThemePreference.system,
                    _violet,
                  ),
                  const SizedBox(width: 8),
                  _buildStatusDot(
                    Icons.straighten_rounded,
                    preferences.measurementPreference !=
                        MeasurementSystemPreference.system,
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
    return _buildGroupCard([
      _SettingsRow(
        icon: Icons.dark_mode_outlined,
        iconColor: _violet,
        title: _l10n.darkMode,
        subtitle: _l10n.settingsDarkModeSubtitle,
        badge: _themeLabel(localeProvider.themePreference),
        onTap: () => _showThemeBottomSheet(localeProvider),
      ),
      _SettingsRow(
        icon: Icons.straighten_rounded,
        iconColor: _warm,
        title: _l10n.metricSystem,
        subtitle: _l10n.metricSystemSubtitle,
        badge: _measurementLabel(localeProvider.measurementPreference),
        onTap: () => _showMeasurementBottomSheet(localeProvider),
      ),
      _SettingsRow(
        icon: Icons.translate_rounded,
        iconColor: const Color(0xFF2D8BCB),
        title: _l10n.language,
        subtitle: _l10n.languageSubtitle,
        badge: _currentLanguageLabel(localeProvider),
        onTap: _showLanguageBottomSheet,
      ),
    ]);
  }

  Widget _buildAccountCard() {
    final subscription = context.watch<SubscriptionController>();
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
        badge: subscription.isPremium ? _l10n.premium : _l10n.subscriptionFree,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SubscriptionPage()),
        ),
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

  String _themeLabel(AppThemePreference preference) => switch (preference) {
    AppThemePreference.system => _l10n.preferenceSystem,
    AppThemePreference.light => _l10n.themeLight,
    AppThemePreference.dark => _l10n.themeDark,
  };

  String _measurementLabel(MeasurementSystemPreference preference) =>
      switch (preference) {
        MeasurementSystemPreference.system => _l10n.preferenceSystem,
        MeasurementSystemPreference.metric => _l10n.measurementMetric,
        MeasurementSystemPreference.imperial => _l10n.measurementImperial,
      };

  void _showThemeBottomSheet(LocaleProvider provider) {
    _showPreferenceBottomSheet<AppThemePreference>(
      title: _l10n.themeSelectionTitle,
      selected: provider.themePreference,
      options: [
        (
          AppThemePreference.system,
          Icons.brightness_auto,
          _l10n.preferenceSystem,
        ),
        (AppThemePreference.light, Icons.light_mode_outlined, _l10n.themeLight),
        (AppThemePreference.dark, Icons.dark_mode_outlined, _l10n.themeDark),
      ],
      onSelected: provider.setThemePreference,
    );
  }

  void _showMeasurementBottomSheet(LocaleProvider provider) {
    _showPreferenceBottomSheet<MeasurementSystemPreference>(
      title: _l10n.measurementSelectionTitle,
      selected: provider.measurementPreference,
      options: [
        (
          MeasurementSystemPreference.system,
          Icons.public_rounded,
          _l10n.preferenceSystem,
        ),
        (
          MeasurementSystemPreference.metric,
          Icons.straighten_rounded,
          _l10n.measurementMetric,
        ),
        (
          MeasurementSystemPreference.imperial,
          Icons.square_foot_rounded,
          _l10n.measurementImperial,
        ),
      ],
      onSelected: provider.setMeasurementPreference,
    );
  }

  void _showPreferenceBottomSheet<T>({
    required String title,
    required T selected,
    required List<(T, IconData, String)> options,
    required Future<void> Function(T) onSelected,
  }) {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(
                  sheetContext,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 14),
              for (final option in options)
                RadioListTile<T>(
                  value: option.$1,
                  groupValue: selected,
                  secondary: Icon(option.$2),
                  title: Text(option.$3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  onChanged: (value) async {
                    if (value == null) return;
                    Navigator.pop(sheetContext);
                    await onSelected(value);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showLanguageBottomSheet() async {
    final changed = await showAndApplyLanguagePicker(context);
    if (!changed) return;

    await CareNotificationService.instance.refreshSchedules();
    if (mounted) {
      _showSnack(AppLocalizations.of(context)!.languageChanged);
    }
  }

  void _showPasswordResetConfirmation() {
    final email = Supabase.instance.client.auth.currentUser?.email;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => Container(
        padding: const EdgeInsets.fromLTRB(22, 14, 22, 24),
        decoration: BoxDecoration(
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
                  textDirection: TextDirection.ltr,
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
    this.badge,
    this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String? badge;
  final VoidCallback? onTap;
}
