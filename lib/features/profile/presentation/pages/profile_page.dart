import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'settings_page.dart';
import 'notifications_settings_page.dart';
import 'terms_page.dart';
import 'edit_profile_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../onboarding/presentation/pages/onboarding_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Color _accentGreen = const Color(0xFF86D5A6);
  final Color _lightBg = const Color(0xFFF9FAF9);
  final Color _cardBg = Colors.white;
  final Color _primaryText = const Color(0xFF2C3E35);
  final Color _textSecondary = const Color(0xFF8B9E93);
  final Color _dangerColor = const Color(0xFFE96565);

  int _selectedTabIndex = 0; // 0: Overview, 1: Settings

  String _fullName = 'Botanist';
  String _email = '';
  String _avatarUrl = 'https://i.pravatar.cc/150?img=68';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      _email = user.email ?? '';
      try {
        final data = await Supabase.instance.client
            .from('profiles')
            .select('full_name, avatar_url')
            .eq('id', user.id)
            .maybeSingle();

        if (data != null && mounted) {
          setState(() {
            if (data['full_name'] != null &&
                data['full_name'].toString().isNotEmpty) {
              _fullName = data['full_name'];
            } else {
              // Fallback to user metadata if exists
              _fullName = user.userMetadata?['full_name'] ?? 'Botanist';
            }
            if (data['avatar_url'] != null) _avatarUrl = data['avatar_url'];
          });
        }
      } catch (_) {}
    }
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _lightBg,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              // Header
              Text(
                'Profile',
                style: GoogleFonts.outfit(
                  color: _primaryText,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 32),

              // User Info Card
              GestureDetector(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfilePage(),
                    ),
                  );
                  if (result == true) {
                    _fetchUserData();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _cardBg,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFCBD5E1).withValues(alpha: 0.16),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: _accentGreen.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(_avatarUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _fullName,
                              style: GoogleFonts.outfit(
                                color: _primaryText,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _email,
                              style: GoogleFonts.inter(
                                color: _textSecondary,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _accentGreen.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'Edit Profile',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF4FA976),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.chevron_right_rounded, color: _textSecondary),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Custom Tab Bar
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: _cardBg,
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedTabIndex = 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: _selectedTabIndex == 0
                                ? _accentGreen
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Overview',
                            style: GoogleFonts.inter(
                              color: _selectedTabIndex == 0
                                  ? Colors.white
                                  : _textSecondary,
                              fontWeight: _selectedTabIndex == 0
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedTabIndex = 1),
                        child: Container(
                          decoration: BoxDecoration(
                            color: _selectedTabIndex == 1
                                ? _accentGreen
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Settings',
                            style: GoogleFonts.inter(
                              color: _selectedTabIndex == 1
                                  ? Colors.white
                                  : _textSecondary,
                              fontWeight: _selectedTabIndex == 1
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Tab Contents
              if (_selectedTabIndex == 0) _buildOverviewTab(),
              if (_selectedTabIndex == 1) _buildSettingsTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Grid for Total Plants & Consistency
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _cardBg,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _accentGreen.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.local_florist_rounded,
                            color: _accentGreen,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '24',
                      style: GoogleFonts.outfit(
                        color: _primaryText,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Total Plants',
                      style: GoogleFonts.inter(
                        color: _textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _cardBg,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4FA976).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.verified_rounded,
                            color: Color(0xFF4FA976),
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '92%',
                      style: GoogleFonts.outfit(
                        color: _primaryText,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Consistency',
                      style: GoogleFonts.inter(
                        color: _textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Care Activity
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: _cardBg,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Care Activity',
                style: GoogleFonts.outfit(
                  color: _primaryText,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildActivityBar('Mon', 0.6),
                  _buildActivityBar('Tue', 0.8),
                  _buildActivityBar('Wed', 0.4),
                  _buildActivityBar('Thu', 1.0),
                  _buildActivityBar('Fri', 0.7),
                  _buildActivityBar('Sat', 0.3),
                  _buildActivityBar('Sun', 0.9),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 120), // Padding for nav bar
      ],
    );
  }

  Widget _buildActivityBar(String day, double percentage) {
    return Column(
      children: [
        Container(
          height: 120,
          width: 12,
          decoration: BoxDecoration(
            color: _lightBg,
            borderRadius: BorderRadius.circular(6),
          ),
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 120 * percentage,
            width: 12,
            decoration: BoxDecoration(
              color: _accentGreen,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          day,
          style: GoogleFonts.inter(color: _textSecondary, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildSettingsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'General',
          style: GoogleFonts.inter(
            color: _textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 16),
        _buildMenuSection([
          _buildMenuItem(
            icon: Icons.settings_rounded,
            title: 'Settings',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
          _buildMenuItem(
            icon: Icons.language_rounded,
            title: 'App Language',
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.notifications_none_rounded,
            title: 'Notifications',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsSettingsPage(),
                ),
              );
            },
          ),
        ]),

        const SizedBox(height: 24),
        Text(
          'Support & Legal',
          style: GoogleFonts.inter(
            color: _textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 16),
        _buildMenuSection([
          _buildMenuItem(
            icon: Icons.help_outline_rounded,
            title: 'Help Center',
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.description_outlined,
            title: 'Terms & Policies',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TermsPage()),
              );
            },
          ),
        ]),

        const SizedBox(height: 32),

        // Danger Actions
        _buildMenuSection([
          _buildMenuItem(
            icon: Icons.logout_rounded,
            title: 'Sign Out',
            textColor: _primaryText,
            iconColor: _textSecondary,
            onTap: () => _showSignOutDialog(context),
          ),
          _buildMenuItem(
            icon: Icons.delete_outline_rounded,
            title: 'Delete Account',
            textColor: _dangerColor,
            iconColor: _dangerColor,
            isDestructive: true,
            onTap: () => _showDeleteAccountDialog(context),
          ),
        ]),

        const SizedBox(height: 120), // Padding for nav bar
      ],
    );
  }

  Widget _buildMenuSection(List<Widget> items) {
    return Container(
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFCBD5E1).withOpacity(0.02 * 4),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          int idx = entry.key;
          Widget item = entry.value;
          return Column(
            children: [
              item,
              if (idx != items.length - 1)
                Divider(
                  height: 1,
                  thickness: 1,
                  color: _lightBg,
                  indent: 64,
                  endIndent: 20,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDestructive ? _dangerColor.withOpacity(0.1) : _lightBg,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor ?? _accentGreen, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.inter(
                  color: textColor ?? _primaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: isDestructive
                  ? _dangerColor.withOpacity(0.5)
                  : _textSecondary.withOpacity(0.5),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _cardBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          'Sign Out',
          style: GoogleFonts.outfit(
            color: _primaryText,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to sign out?',
          style: GoogleFonts.inter(color: _textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: _textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await Supabase.instance.client.auth.signOut();
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const OnboardingPage()),
                  (_) => false,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryText,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              'Sign Out',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _cardBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          'Delete Account',
          style: GoogleFonts.outfit(
            color: _dangerColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'This action cannot be undone. All your garden data, photos, and settings will be permanently removed. Are you absolutely sure?',
          style: GoogleFonts.inter(color: _textSecondary, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: _textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              // Perform delete
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _dangerColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              'Delete',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
