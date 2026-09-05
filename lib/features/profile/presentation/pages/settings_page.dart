import 'package:botaniq/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/config/auth_redirect.dart';
import '../../../../core/locale/locale_provider.dart';
import '../../../../core/locale/supported_app_locale.dart';
import '../../../../core/services/care_notification_service.dart';
import '../../../auth/presentation/widgets/animated_entrance.dart';
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

  final ScrollController _scrollController = ScrollController();

  /// Başlık, sayfa kaydırıldıkça küçülüp üst çubuğa yerleşir. Eşiği
  /// aşıldığında kompakt başlık belirir.
  bool _isCollapsed = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    final collapsed =
        _scrollController.hasClients && _scrollController.offset > 62;
    if (collapsed != _isCollapsed && mounted) {
      setState(() => _isCollapsed = collapsed);
    }
  }

  String _currentLanguageLabel(LocaleProvider provider) {
    final tag = provider.currentLocaleTag;
    return tag == null
        ? _l10n.systemLanguage
        : SupportedAppLocales.byTag(tag)?.nativeName ?? tag;
  }

  /// Hesap adı ve e-postası oturum bilgisinden okunur — ek bir ağ isteği
  /// yapılmaz, bu yüzden sayfa anında çizilir.
  ({String name, String email, String initial}) get _identity {
    final user = Supabase.instance.client.auth.currentUser;
    final metadata = user?.userMetadata ?? const {};
    final rawName = (metadata['full_name'] ?? metadata['name'] ?? '')
        .toString()
        .trim();
    final email = (user?.email ?? '').trim();
    final name = rawName.isNotEmpty
        ? rawName
        : (email.isNotEmpty ? email.split('@').first : _l10n.appTitle);
    final initial = name.isNotEmpty ? name.characters.first.toUpperCase() : 'B';
    return (name: name, email: email, initial: initial);
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = context.watch<LocaleProvider>();
    var step = 0;
    Duration nextDelay() => Duration(milliseconds: 70 * step++);

    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 720),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 44),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimatedEntrance(
                            delay: nextDelay(),
                            child: _buildLargeTitle(),
                          ),
                          const SizedBox(height: 18),
                          AnimatedEntrance(
                            delay: nextDelay(),
                            child: _buildIdentityCard(localeProvider),
                          ),
                          const SizedBox(height: 26),
                          AnimatedEntrance(
                            delay: nextDelay(),
                            child: _buildPremiumSection(),
                          ),
                          const SizedBox(height: 30),
                          AnimatedEntrance(
                            delay: nextDelay(),
                            child: _buildSectionHeading(
                              _l10n.preferences,
                              _l10n.settingsLocalPreference,
                              Icons.tune_rounded,
                              _violet,
                            ),
                          ),
                          const SizedBox(height: 12),
                          AnimatedEntrance(
                            delay: nextDelay(),
                            child: _buildPreferencesCard(localeProvider),
                          ),
                          const SizedBox(height: 30),
                          AnimatedEntrance(
                            delay: nextDelay(),
                            child: _buildSectionHeading(
                              _l10n.account,
                              _l10n.settingsAccountSubtitle,
                              Icons.person_outline_rounded,
                              _deepGreen,
                            ),
                          ),
                          const SizedBox(height: 12),
                          AnimatedEntrance(
                            delay: nextDelay(),
                            child: _buildAccountCard(),
                          ),
                          const SizedBox(height: 90),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Kaydırma ile küçülen üst çubuk: başta yalnızca geri düğmesi görünür,
  /// sayfa kaydırıldığında başlık buraya yumuşakça taşınır.
  Widget _buildTopBar() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      decoration: BoxDecoration(
        color: _isCollapsed ? _surface : Colors.transparent,
        boxShadow: _isCollapsed
            ? [
                BoxShadow(
                  color: _ink.withValues(alpha: 0.06),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          Material(
            color: _isCollapsed ? _background : _surface,
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
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: _isCollapsed ? 1 : 0,
            child: Text(
              _l10n.settings,
              style: GoogleFonts.outfit(
                color: _ink,
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLargeTitle() {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: _isCollapsed ? 0 : 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _l10n.settings,
            style: GoogleFonts.outfit(
              color: _ink,
              fontSize: 34,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.8,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            _l10n.settingsSubtitle,
            style: GoogleFonts.inter(
              color: _muted,
              fontSize: 13.5,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  /// Kullanıcının kim olduğunu gösteren, yavaşça nefes alan ışıltılı
  /// karşılama kartı. Ayarlar sayfasını kişisel hissettirir; alt satırdaki
  /// rozetler hangi tercihlerin varsayılandan farklı olduğunu tek bakışta
  /// gösterir.
  Widget _buildIdentityCard(LocaleProvider preferences) {
    final identity = _identity;
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.fromSTEB(20, 22, 18, 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F3B27), Color(0xFF1C6340)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: _deepGreen.withValues(alpha: 0.22),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          const Positioned(right: -26, top: -34, child: _BreathingGlow()),
          PositionedDirectional(
            end: -12,
            bottom: -26,
            child: Icon(
              Icons.spa_rounded,
              size: 104,
              color: _green.withValues(alpha: 0.09),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [_green, Color(0xFF0ABF55)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: _green.withValues(alpha: 0.4),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      identity.initial,
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          identity.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w700,
                            height: 1.15,
                          ),
                        ),
                        if (identity.email.isNotEmpty) ...[
                          const SizedBox(height: 3),
                          Text(
                            identity.email,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.ltr,
                            style: GoogleFonts.inter(
                              color: Colors.white.withValues(alpha: 0.66),
                              fontSize: 12.5,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      _currentLanguageLabel(preferences),
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Premium bölümü kompakt bir kart olarak gösterilir; tam plan/fiyat/
  /// karşılaştırma içeriği artık burada değil, ayrı Abonelik sayfasında.
  Widget _buildPremiumSection() {
    final subscription = context.watch<SubscriptionController>();
    return subscription.isPremium
        ? _buildPremiumActiveBanner(subscription)
        : _buildPremiumCtaBanner();
  }

  Widget _buildPremiumCtaBanner() {
    return _buildPremiumBanner(
      gradientColors: const [Color(0xFF0D3926), Color(0xFF19583A)],
      title: _l10n.settingsPremiumBannerTitle,
      subtitle: _l10n.settingsPremiumBannerSubtitle,
      trailingLabel: null,
      shimmer: true,
    );
  }

  Widget _buildPremiumActiveBanner(SubscriptionController controller) {
    final entitlement = controller.premiumEntitlement;
    final expirationDate = controller.expirationDate;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final formattedDate = expirationDate == null
        ? null
        : DateFormat.yMMMd(locale).format(expirationDate);
    final statusLine = formattedDate == null
        ? _l10n.subscriptionActiveSubtitle
        : (entitlement?.willRenew ?? false
              ? _l10n.subscriptionRenewsOn(formattedDate)
              : _l10n.subscriptionExpiresOn(formattedDate));

    return _buildPremiumBanner(
      gradientColors: const [Color(0xFF0C3A25), Color(0xFF187046)],
      title: _l10n.subscriptionActiveTitle,
      subtitle: statusLine,
      trailingLabel: _l10n.subscriptionManage,
      shimmer: false,
    );
  }

  Widget _buildPremiumBanner({
    required List<Color> gradientColors,
    required String title,
    required String subtitle,
    required String? trailingLabel,
    required bool shimmer,
  }) {
    return _PressableCard(
      borderRadius: 28,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SubscriptionPage()),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 18, 16, 18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: gradientColors.first.withValues(alpha: 0.3),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            children: [
              if (shimmer) const Positioned.fill(child: _ShimmerSweep()),
              Positioned(
                right: -18,
                bottom: -18,
                child: Icon(
                  Icons.auto_awesome_rounded,
                  size: 90,
                  color: _green.withValues(alpha: 0.1),
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5B74A).withValues(alpha: 0.18),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.workspace_premium_rounded,
                      color: Color(0xFFF5B74A),
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            color: Colors.white.withValues(alpha: 0.78),
                            fontSize: 11.5,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (trailingLabel != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        trailingLabel,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    )
                  else
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.14),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward_rounded,
                        color: Color(0xFFF5B74A),
                        size: 16,
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

  Widget _buildStatusDot(IconData icon, bool active, Color color) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOut,
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: active
            ? color.withValues(alpha: 0.24)
            : Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: active
              ? color.withValues(alpha: 0.55)
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

  /// Bölüm başlığı: solunda renkli bir ikon rozeti, altında kısa açıklama.
  Widget _buildSectionHeading(
    String title,
    String subtitle,
    IconData icon,
    Color accent,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(icon, color: accent, size: 17),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    color: _ink,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(color: _muted, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesCard(LocaleProvider localeProvider) {
    return Container(
      decoration: _cardDecoration(),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _buildPreferenceSegmentRow(
            icon: Icons.dark_mode_outlined,
            iconColor: _violet,
            title: _l10n.darkMode,
            subtitle: _l10n.settingsDarkModeSubtitle,
            control: _InlineSegmentedControl<AppThemePreference>(
              accentColor: _violet,
              selected: localeProvider.themePreference,
              onChanged: localeProvider.setThemePreference,
              options: [
                _SegmentOption(
                  AppThemePreference.system,
                  Icons.brightness_auto,
                  _l10n.preferenceSystem,
                ),
                _SegmentOption(
                  AppThemePreference.light,
                  Icons.light_mode_outlined,
                  _l10n.themeLight,
                ),
                _SegmentOption(
                  AppThemePreference.dark,
                  Icons.dark_mode_outlined,
                  _l10n.themeDark,
                ),
              ],
            ),
          ),
          _buildDivider(indent: 16),
          _buildPreferenceSegmentRow(
            icon: Icons.straighten_rounded,
            iconColor: _warm,
            title: _l10n.metricSystem,
            subtitle: _l10n.metricSystemSubtitle,
            control: _InlineSegmentedControl<MeasurementSystemPreference>(
              accentColor: _warm,
              selected: localeProvider.measurementPreference,
              onChanged: localeProvider.setMeasurementPreference,
              options: [
                _SegmentOption(
                  MeasurementSystemPreference.system,
                  Icons.public_rounded,
                  _l10n.preferenceSystem,
                ),
                _SegmentOption(
                  MeasurementSystemPreference.metric,
                  Icons.straighten_rounded,
                  _l10n.measurementMetric,
                ),
                _SegmentOption(
                  MeasurementSystemPreference.imperial,
                  Icons.square_foot_rounded,
                  _l10n.measurementImperial,
                ),
              ],
            ),
          ),
          _buildDivider(indent: 74),
          _buildSettingsRow(
            _SettingsRow(
              icon: Icons.translate_rounded,
              iconColor: const Color(0xFF2D8BCB),
              title: _l10n.language,
              subtitle: _l10n.languageSubtitle,
              badge: _currentLanguageLabel(localeProvider),
              onTap: _showLanguageBottomSheet,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider({required double indent}) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: indent,
      endIndent: 16,
      color: _ink.withValues(alpha: 0.06),
    );
  }

  Widget _buildPreferenceSegmentRow({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Widget control,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        color: _ink,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        color: _muted,
                        fontSize: 11,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          control,
        ],
      ),
    );
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
            if (index != rows.length - 1) _buildDivider(indent: 74),
          ],
        ],
      ),
    );
  }

  Widget _buildSettingsRow(_SettingsRow item) {
    final row = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: item.iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(15),
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
                    fontSize: 14.5,
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: _green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(999),
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
      child: InkWell(
        onTap: item.onTap,
        splashColor: item.iconColor.withValues(alpha: 0.08),
        highlightColor: item.iconColor.withValues(alpha: 0.04),
        child: row,
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: _surface,
      borderRadius: BorderRadius.circular(26),
      border: Border.all(color: _ink.withValues(alpha: 0.05)),
      boxShadow: [
        BoxShadow(
          color: _ink.withValues(alpha: 0.05),
          blurRadius: 26,
          offset: const Offset(0, 10),
        ),
      ],
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
      await Supabase.instance.client.auth.resetPasswordForEmail(
        email,
        redirectTo: kAuthCallbackUrl,
      );
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

class _SegmentOption<T> {
  const _SegmentOption(this.value, this.icon, this.label);

  final T value;
  final IconData icon;
  final String label;
}

/// İki veya daha fazla seçenek arasında kayan bir gösterge ile geçiş yapan
/// segment kontrolü — [SubscriptionPanel]'daki plan seçicisiyle aynı
/// animasyon dilini N seçeneğe genelleştirir. Ayarlar sayfasında artık ayrı
/// bir pop-up açmadan doğrudan sayfa içinde tercih değiştirmek için kullanılır.
class _InlineSegmentedControl<T> extends StatelessWidget {
  const _InlineSegmentedControl({
    required this.options,
    required this.selected,
    required this.onChanged,
    required this.accentColor,
  });

  final List<_SegmentOption<T>> options;
  final T selected;
  final Future<void> Function(T) onChanged;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final track = Theme.of(context).colorScheme.surfaceContainerHighest;
    final ink = Theme.of(context).colorScheme.onSurface;
    final selectedIndex = options.indexWhere(
      (option) => option.value == selected,
    );
    final segmentCount = options.length;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: track.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          if (selectedIndex >= 0)
            AnimatedAlign(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              alignment: Alignment(
                segmentCount > 1
                    ? -1 + 2 * selectedIndex / (segmentCount - 1)
                    : 0,
                0,
              ),
              child: FractionallySizedBox(
                widthFactor: 1 / segmentCount,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Row(
            children: [
              for (final option in options)
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => onChanged(option.value),
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              option.icon,
                              size: 15,
                              color: option.value == selected
                                  ? accentColor
                                  : ink.withValues(alpha: 0.5),
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                option.label,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                  color: option.value == selected
                                      ? ink
                                      : ink.withValues(alpha: 0.5),
                                  fontSize: 11.5,
                                  fontWeight: option.value == selected
                                      ? FontWeight.w700
                                      : FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Basılınca hafifçe küçülen kart — dokunuşun "kaydedildiğini" anında
/// hissettirir, gradient kartlarda mürekkep dalgası (ink ripple)
/// görünmediği için özellikle gerekli.
class _PressableCard extends StatefulWidget {
  const _PressableCard({
    required this.child,
    required this.onTap,
    required this.borderRadius,
  });

  final Widget child;
  final VoidCallback onTap;
  final double borderRadius;

  @override
  State<_PressableCard> createState() => _PressableCardState();
}

class _PressableCardState extends State<_PressableCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.975 : 1,
        duration: const Duration(milliseconds: 130),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}

/// Karşılama kartının arkasında yavaşça büyüyüp küçülen yumuşak ışık.
class _BreathingGlow extends StatefulWidget {
  const _BreathingGlow();

  @override
  State<_BreathingGlow> createState() => _BreathingGlowState();
}

class _BreathingGlowState extends State<_BreathingGlow>
    with SingleTickerProviderStateMixin {
  /// Kaç kez nefes alıp duracağı. Sonsuz döngü kullanmıyoruz: hem ayarlar
  /// sayfasında sürekli hareket dikkat dağıtır, hem de hiç bitmeyen bir
  /// animasyon widget ağacının "durulmasını" (pumpAndSettle) engelleyerek
  /// testleri kilitler.
  static const _cycleLimit = 3;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 6),
  );
  int _completedCycles = 0;

  @override
  void initState() {
    super.initState();
    _controller.addStatusListener(_handleStatus);
    _controller.forward();
  }

  void _handleStatus(AnimationStatus status) {
    if (_completedCycles >= _cycleLimit) return;
    if (status == AnimationStatus.completed) {
      _completedCycles++;
      if (_completedCycles < _cycleLimit) _controller.reverse();
    } else if (status == AnimationStatus.dismissed) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_handleStatus);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = Curves.easeInOut.transform(_controller.value);
        return Opacity(
          opacity: 0.30 + 0.22 * t,
          child: Transform.scale(scale: 0.92 + 0.16 * t, child: child),
        );
      },
      child: Container(
        width: 168,
        height: 168,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              const Color(0xFF0ED761).withValues(alpha: 0.34),
              const Color(0xFF0ED761).withValues(alpha: 0.0),
            ],
          ),
        ),
      ),
    );
  }
}

/// Premium kartının üzerinden düzenli aralıklarla geçen ışık huzmesi —
/// kartın tıklanabilir ve "değerli" olduğunu sezdirir.
class _ShimmerSweep extends StatefulWidget {
  const _ShimmerSweep();

  @override
  State<_ShimmerSweep> createState() => _ShimmerSweepState();
}

class _ShimmerSweepState extends State<_ShimmerSweep>
    with SingleTickerProviderStateMixin {
  /// Huzme kaç kez geçecek. Sonsuz döngü değil — bkz. [_BreathingGlow].
  static const _sweepLimit = 2;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2600),
  );
  int _sweeps = 0;

  @override
  void initState() {
    super.initState();
    _controller.addStatusListener(_handleStatus);
    _controller.forward();
  }

  void _handleStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed) return;
    _sweeps++;
    if (_sweeps < _sweepLimit) {
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_handleStatus);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          // Huzme ekranı geçtikten sonra uzunca bekler; sürekli parlayan
          // bir kart dikkat dağıtıcı olurdu.
          final progress = (_controller.value * 2.6).clamp(0.0, 1.0);
          return ShaderMask(
            blendMode: BlendMode.srcATop,
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment(-2.2 + progress * 3.6, -1),
                end: Alignment(-1.4 + progress * 3.6, 1),
                colors: [
                  Colors.white.withValues(alpha: 0.0),
                  Colors.white.withValues(alpha: 0.13),
                  Colors.white.withValues(alpha: 0.0),
                ],
              ).createShader(rect);
            },
            child: Container(color: Colors.white.withValues(alpha: 0.001)),
          );
        },
      ),
    );
  }
}
