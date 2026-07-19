import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          'Settings',
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
                  'Preferences',
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
                        icon: Icons.dark_mode_outlined,
                        title: 'Dark Mode',
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
                      _buildSwitchTile(
                        icon: Icons.straighten_rounded,
                        title: 'Metric System',
                        subtitle: 'Use Celsius and Meters',
                        value: _useMetricSystem,
                        onChanged: (val) {
                          setState(() {
                            _useMetricSystem = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Account',
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
                        title: 'Edit Profile',
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
                        title: 'Change Password',
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
                        title: 'Subscription Management',
                        label: 'Premium',
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
  }) {
    return InkWell(
      onTap: () {},
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
