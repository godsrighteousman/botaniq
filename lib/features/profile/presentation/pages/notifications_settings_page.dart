import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  Widget build(BuildContext context) {
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
          'Notifications',
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
                  'Plant Care Alerts',
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
                        title: 'Watering Reminders',
                        subtitle: 'Never miss a watering day',
                        value: _waterReminders,
                        onChanged: (val) =>
                            setState(() => _waterReminders = val),
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
                        title: 'Fertilizing Reminders',
                        subtitle: 'Schedule feeding alerts',
                        value: _fertilizeReminders,
                        onChanged: (val) =>
                            setState(() => _fertilizeReminders = val),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Other Notifications',
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
                        title: 'Weather Alerts',
                        subtitle: 'Extreme weather warnings',
                        value: _weatherAlerts,
                        onChanged: (val) =>
                            setState(() => _weatherAlerts = val),
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
                        title: 'New Articles',
                        subtitle: 'Tips and tricks for your garden',
                        value: _newArticles,
                        onChanged: (val) => setState(() => _newArticles = val),
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
