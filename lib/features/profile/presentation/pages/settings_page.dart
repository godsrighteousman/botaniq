import 'package:flutter/material.dart';
import 'package:botaniq/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/locale/locale_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final Color _accentGreen = const Color(0xFF86D5A6);
  final Color _lightBg = const Color(0xFFF9FAF9);
  final Color _cardBg = Colors.white;
  final Color _primaryText = const Color(0xFF2C3E35);
  final Color _textSecondary = const Color(0xFF8B9E93);

  bool _isDarkMode = false;
  bool _useMetricSystem = true;
  late TextEditingController _apiKeyController;

  @override
  void initState() {
    super.initState();
    _apiKeyController = TextEditingController();
    _loadApiKey();
  }

  Future<void> _loadApiKey() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _apiKeyController.text = prefs.getString('openai_api_key') ?? '';
      });
    } catch (e) {
      debugPrint("API Key yükleme hatası: $e");
    }
  }

  Future<void> _saveApiKey(String value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('openai_api_key', value.trim());
    } catch (e) {
      debugPrint("API Key kaydetme hatası: $e");
    }
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }

  // ─── Seçili dil koduna göre kullanıcıya gösterilecek label ───
  String _currentLanguageLabel(LocaleProvider provider, AppLocalizations l10n) {
    final code = provider.currentLanguageCode;
    switch (code) {
      case 'en':
        return l10n.english;
      case 'tr':
        return l10n.turkish;
      default:
        return l10n.systemLanguage;
    }
  }

  // ─── Dil seçim BottomSheet ───
  void _showLanguageBottomSheet(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final provider = context.read<LocaleProvider>();
    final currentCode = provider.currentLanguageCode;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return Container(
          decoration: BoxDecoration(
            color: _cardBg,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 24,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Handle bar
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: _textSecondary.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Başlık
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: _accentGreen.withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.translate_rounded,
                          color: _accentGreen,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        l10n.selectLanguage,
                        style: GoogleFonts.outfit(
                          color: _primaryText,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Seçenekler
                  _buildLanguageOption(
                    context: context,
                    title: l10n.systemLanguage,
                    subtitle: _getSystemLocaleName(context),
                    icon: Icons.phone_android_rounded,
                    isSelected: currentCode == null,
                    onTap: () {
                      Navigator.pop(context);
                      provider.setLocale(null);
                      _showLanguageChangedSnack(context);
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildLanguageOption(
                    context: context,
                    title: 'English',
                    subtitle: 'English',
                    icon: Icons.language_rounded,
                    flagEmoji: '🇺🇸',
                    isSelected: currentCode == 'en',
                    onTap: () {
                      Navigator.pop(context);
                      provider.setLocale('en');
                      _showLanguageChangedSnack(context);
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildLanguageOption(
                    context: context,
                    title: 'Türkçe',
                    subtitle: 'Turkish',
                    icon: Icons.language_rounded,
                    flagEmoji: '🇹🇷',
                    isSelected: currentCode == 'tr',
                    onTap: () {
                      Navigator.pop(context);
                      provider.setLocale('tr');
                      _showLanguageChangedSnack(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Cihazın sistem dil adını okunabilir formatta döndürür.
  String _getSystemLocaleName(BuildContext context) {
    final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
    switch (systemLocale.languageCode) {
      case 'tr':
        return 'Türkçe';
      case 'en':
        return 'English';
      default:
        return systemLocale.languageCode.toUpperCase();
    }
  }

  void _showLanguageChangedSnack(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.languageChanged),
        backgroundColor: const Color(0xFF4FA976),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  // ─── BottomSheet dil seçenek kartı ───
  Widget _buildLanguageOption({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    String? flagEmoji,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: isSelected ? _accentGreen.withOpacity(0.08) : _lightBg,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              if (flagEmoji != null)
                Text(flagEmoji, style: const TextStyle(fontSize: 24))
              else
                Icon(icon, color: _accentGreen, size: 24),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        color: _primaryText,
                        fontSize: 16,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                      ),
                    ),
                    if (subtitle != title)
                      Text(
                        subtitle,
                        style: GoogleFonts.inter(
                          color: _textSecondary,
                          fontSize: 13,
                        ),
                      ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? _accentGreen
                        : _textSecondary.withOpacity(0.3),
                    width: isSelected ? 2 : 1.5,
                  ),
                  color: isSelected ? _accentGreen : Colors.transparent,
                ),
                child: isSelected
                    ? const Icon(Icons.check, color: Colors.white, size: 16)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeProvider = context.watch<LocaleProvider>();

    return Scaffold(
      backgroundColor: _lightBg,
      appBar: AppBar(
        backgroundColor: _lightBg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF2C3E35),
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.settings,
          style: GoogleFonts.outfit(
            color: const Color(0xFF2C3E35),
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ═══════════════════════════════════════
                // PREFERENCES SECTION
                // ═══════════════════════════════════════
                Text(
                  l10n.preferences,
                  style: GoogleFonts.inter(
                    color: _textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: _cardBg,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFCBD5E1).withOpacity(0.04 * 4),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // ─── Dark Mode ───
                      _buildSwitchTile(
                        icon: Icons.dark_mode_outlined,
                        title: l10n.darkMode,
                        value: _isDarkMode,
                        onChanged: (val) {
                          setState(() {
                            _isDarkMode = val;
                          });
                        },
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: _lightBg,
                        indent: 64,
                        endIndent: 20,
                      ),

                      // ─── Metric System ───
                      _buildSwitchTile(
                        icon: Icons.straighten_rounded,
                        title: l10n.metricSystem,
                        subtitle: l10n.metricSystemSubtitle,
                        value: _useMetricSystem,
                        onChanged: (val) {
                          setState(() {
                            _useMetricSystem = val;
                          });
                        },
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: _lightBg,
                        indent: 64,
                        endIndent: 20,
                      ),

                      // ─── Language Selector ───
                      _buildActionTile(
                        icon: Icons.translate_rounded,
                        title: l10n.language,
                        label: _currentLanguageLabel(localeProvider, l10n),
                        onTap: () => _showLanguageBottomSheet(context),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // ═══════════════════════════════════════
                // ACCOUNT SECTION
                // ═══════════════════════════════════════
                Text(
                  l10n.account,
                  style: GoogleFonts.inter(
                    color: _textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: _cardBg,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFCBD5E1).withOpacity(0.04 * 4),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildActionTile(
                        icon: Icons.person_outline_rounded,
                        title: l10n.editProfile,
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: _lightBg,
                        indent: 64,
                        endIndent: 20,
                      ),
                      _buildActionTile(
                        icon: Icons.lock_outline_rounded,
                        title: l10n.changePassword,
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: _lightBg,
                        indent: 64,
                        endIndent: 20,
                      ),
                      _buildActionTile(
                        icon: Icons.payment_rounded,
                        title: l10n.subscriptionManagement,
                        label: l10n.premium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // ═══════════════════════════════════════
                // API SETTINGS SECTION
                // ═══════════════════════════════════════
                Text(
                  l10n.apiSettings,
                  style: GoogleFonts.inter(
                    color: _textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: _cardBg,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFCBD5E1).withOpacity(0.04 * 4),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: _lightBg,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.key,
                              color: _accentGreen,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'OpenAI API Key',
                              style: GoogleFonts.inter(
                                color: _primaryText,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _apiKeyController,
                        obscureText: true,
                        style: GoogleFonts.inter(
                          color: _primaryText,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          hintText: l10n.apiKeyHint,
                          hintStyle: GoogleFonts.inter(
                            color: _textSecondary.withOpacity(0.5),
                          ),
                          filled: true,
                          fillColor: _lightBg,
                          prefixIcon: const Icon(
                            Icons.vpn_key_outlined,
                            size: 18,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.save_rounded,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              _saveApiKey(_apiKeyController.text);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(l10n.apiKeySaved),
                                  backgroundColor: Colors.green,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                          ),
                        ),
                        onChanged: _saveApiKey,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        l10n.apiKeyDescription,
                        style: GoogleFonts.inter(
                          color: _textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════
  // REUSABLE TILE WIDGETS
  // ═══════════════════════════════════════

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: _lightBg, shape: BoxShape.circle),
            child: Icon(icon, color: _accentGreen, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: _primaryText,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      color: _textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: _accentGreen,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xFFE5E5EA),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    String? label,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _lightBg,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: _accentGreen, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.inter(
                  color: _primaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (label != null)
              Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _accentGreen.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  label,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF4FA976),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            Icon(
              Icons.chevron_right_rounded,
              color: _textSecondary.withOpacity(0.5),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
