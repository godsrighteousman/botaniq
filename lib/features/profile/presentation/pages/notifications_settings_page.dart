import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:botaniq/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/services/care_notification_service.dart';

class NotificationsSettingsPage extends StatefulWidget {
  const NotificationsSettingsPage({super.key});

  @override
  State<NotificationsSettingsPage> createState() =>
      _NotificationsSettingsPageState();
}

class _NotificationsSettingsPageState extends State<NotificationsSettingsPage> {
  final Color _accentGreen = const Color(0xFF86D5A6);
  final Color _lightBg = const Color(0xFFF9FAF9);
  final Color _cardBg = Colors.white;
  final Color _primaryText = const Color(0xFF2C3E35);
  final Color _textSecondary = const Color(0xFF8B9E93);

  bool _waterReminders = true;
  bool _fertilizeReminders = false;
  bool _weatherAlerts = true;
  bool _newArticles = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      for (final table in const ['users', 'profiles']) {
        try {
          final data = await Supabase.instance.client
              .from(table)
              .select('watering_reminders, fertilizer_reminders')
              .eq('id', user.id)
              .maybeSingle();
          if (data != null) {
            if (!mounted) return;
            setState(() {
              _waterReminders = data['watering_reminders'] ?? true;
              _fertilizeReminders = data['fertilizer_reminders'] ?? true;
            });
            break;
          }
        } catch (_) {
          // Kurulum sürümüne göre users veya profiles tablosu bulunmayabilir.
        }
      }
    }

    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _weatherAlerts = prefs.getBool('weather_alerts') ?? true;
      _newArticles = prefs.getBool('new_article_alerts') ?? false;
    });
  }

  Future<void> _saveCareSetting(String key, bool value) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      for (final table in const ['users', 'profiles']) {
        try {
          await Supabase.instance.client
              .from(table)
              .update({key: value})
              .eq('id', user.id);
        } catch (_) {
          // Var olan kurulum tablosu güncellendiği sürece diğerini atla.
        }
      }
    }

    if (key == 'watering_reminders' && value) {
      await CareNotificationService.instance.requestPermissionAndRefresh();
    } else {
      await CareNotificationService.instance.refreshSchedules();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
          l10n.notificationTitle,
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
                Text(
                  l10n.notificationPlantCareAlerts,
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
                      _buildSwitchTile(
                        icon: Icons.water_drop_outlined,
                        iconColor: const Color(0xFF4A90E2),
                        title: l10n.notificationWateringTitle,
                        subtitle: l10n.notificationWateringSubtitle,
                        value: _waterReminders,
                        onChanged: (val) {
                          setState(() => _waterReminders = val);
                          _saveCareSetting('watering_reminders', val);
                        },
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: _lightBg,
                        indent: 64,
                        endIndent: 20,
                      ),
                      _buildSwitchTile(
                        icon: Icons.eco_outlined,
                        iconColor: const Color(0xFFE2A04A),
                        title: l10n.notificationFertilizerTitle,
                        subtitle: l10n.notificationFertilizerSubtitle,
                        value: _fertilizeReminders,
                        onChanged: (val) {
                          setState(() => _fertilizeReminders = val);
                          _saveCareSetting('fertilizer_reminders', val);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  l10n.notificationOther,
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
                      _buildSwitchTile(
                        icon: Icons.wb_sunny_outlined,
                        iconColor: const Color(0xFFFFB347),
                        title: l10n.notificationWeatherTitle,
                        subtitle: l10n.notificationWeatherSubtitle,
                        value: _weatherAlerts,
                        onChanged: (val) async {
                          setState(() => _weatherAlerts = val);
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('weather_alerts', val);
                        },
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: _lightBg,
                        indent: 64,
                        endIndent: 20,
                      ),
                      _buildSwitchTile(
                        icon: Icons.article_outlined,
                        iconColor: _accentGreen,
                        title: l10n.notificationArticlesTitle,
                        subtitle: l10n.notificationArticlesSubtitle,
                        value: _newArticles,
                        onChanged: (val) async {
                          setState(() => _newArticles = val);
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('new_article_alerts', val);
                        },
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

  Widget _buildSwitchTile({
    required IconData icon,
    required Color iconColor,
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
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
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
}
