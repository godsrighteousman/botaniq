import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'settings_page.dart';
import 'notifications_settings_page.dart';
import 'terms_page.dart';
import 'edit_profile_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../onboarding/presentation/pages/onboarding_page.dart';
import 'package:botaniq/l10n/app_localizations.dart';

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

  int _selectedTabIndex = 0; // 0: Genel Bakış, 1: Ayarlar

  String _fullName = 'Bahçıvan';
  String _email = '';
  String _avatarUrl = 'https://i.pravatar.cc/150?img=68';
  bool _isLoading = true;

  // Dinamik istatistikler ve haftalık aktivite
  int _totalPlantsCount = 0;
  int _completedTasksCount = 0;
  List<double> _weeklyActivity = List.filled(7, 0.0);
  List<String> _activityDays = [
    'Pzt',
    'Sal',
    'Çar',
    'Per',
    'Cum',
    'Cmt',
    'Paz',
  ];

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      _email = user.email ?? '';

      // Profil verisi + istatistikleri PARALEL yükle
      await Future.wait([_fetchProfile(user), _fetchStatistics(user.id)]);
    }
    if (mounted) setState(() => _isLoading = false);
  }

  Future<void> _fetchProfile(User user) async {
    try {
      // users ve profiles tablolarını paralel sorgula
      final results = await Future.wait([
        Supabase.instance.client
            .from('users')
            .select()
            .eq('id', user.id)
            .maybeSingle()
            .timeout(const Duration(seconds: 5)),
        Supabase.instance.client
            .from('profiles')
            .select('full_name, avatar_url')
            .eq('id', user.id)
            .maybeSingle()
            .timeout(const Duration(seconds: 5)),
      ]);

      final usersData = results[0] as Map<String, dynamic>?;
      final profilesData = results[1] as Map<String, dynamic>?;

      if (mounted) {
        setState(() {
          // Öncelik: users tablosu, sonra profiles, fallback: userMetadata
          if (usersData != null) {
            if (usersData['full_name'] != null &&
                usersData['full_name'].toString().isNotEmpty) {
              _fullName = usersData['full_name'];
            } else {
              _fullName = user.userMetadata?['full_name'] ?? 'Bahçıvan';
            }
            if (usersData['avatar_url'] != null) {
              _avatarUrl = usersData['avatar_url'];
            }
          } else if (profilesData != null) {
            if (profilesData['full_name'] != null &&
                profilesData['full_name'].toString().isNotEmpty) {
              _fullName = profilesData['full_name'];
            } else {
              _fullName = user.userMetadata?['full_name'] ?? 'Bahçıvan';
            }
            if (profilesData['avatar_url'] != null) {
              _avatarUrl = profilesData['avatar_url'];
            }
          } else {
            _fullName = user.userMetadata?['full_name'] ?? 'Bahçıvan';
          }
        });
      }
    } catch (_) {
      if (mounted) {
        final user2 = Supabase.instance.client.auth.currentUser;
        setState(() {
          _fullName = user2?.userMetadata?['full_name'] ?? 'Bahçıvan';
        });
      }
    }
  }

  Future<void> _fetchStatistics(String userId) async {
    try {
      // Bitki sayısı + görev sayısı PARALEL sorgula
      final results = await Future.wait([
        Supabase.instance.client
            .from('plants')
            .select('id')
            .eq('user_id', userId)
            .timeout(const Duration(seconds: 5)),
        Supabase.instance.client
            .from('care_tasks')
            .select('id, completed_at')
            .eq('user_id', userId)
            .eq('is_completed', true)
            .timeout(const Duration(seconds: 5)),
      ]);

      final plantsRes = results[0] as List;
      final completedTasksRes = results[1] as List;

      if (mounted) {
        setState(() {
          _totalPlantsCount = plantsRes.length;
          _completedTasksCount = completedTasksRes.length;

          final now = DateTime.now();
          final startOfWeek = DateTime(
            now.year,
            now.month,
            now.day,
          ).subtract(const Duration(days: 6));
          final dailyCounts = List.filled(7, 0);

          _activityDays.clear();
          final turkishWeekDays = [
            'Pzt',
            'Sal',
            'Çar',
            'Per',
            'Cum',
            'Cmt',
            'Paz',
          ];
          for (int i = 0; i < 7; i++) {
            final day = startOfWeek.add(Duration(days: i));
            _activityDays.add(turkishWeekDays[day.weekday - 1]);
          }

          for (final task in completedTasksRes) {
            final compAtStr = task['completed_at'] as String?;
            if (compAtStr != null) {
              final compDate = DateTime.parse(compAtStr).toLocal();
              final diff = compDate.difference(startOfWeek).inDays;
              if (diff >= 0 && diff < 7) {
                dailyCounts[diff]++;
              }
            }
          }

          int maxCount = 1;
          for (final count in dailyCounts) {
            if (count > maxCount) maxCount = count;
          }

          _weeklyActivity = dailyCounts.map((c) => c / maxCount).toList();
        });
      }
    } catch (e) {
      debugPrint('İstatistik getirme hatası: $e');
    }
  }

  String get _gardenerTitle {
    final l10n = AppLocalizations.of(context)!;
    if (_totalPlantsCount == 0) return l10n.profileTitleNew;
    if (_totalPlantsCount <= 2) return l10n.profileTitleSprout;
    if (_totalPlantsCount <= 5) return l10n.profileTitleLeaf;
    if (_totalPlantsCount <= 10) return l10n.profileTitleSkilled;
    return l10n.profileTitleMaster;
  }

  String get _nextLevelText {
    final l10n = AppLocalizations.of(context)!;
    if (_totalPlantsCount == 0) return l10n.profileNextLevelStart;
    if (_totalPlantsCount <= 2)
      return l10n.profileNextLevelLeaf(3 - _totalPlantsCount);
    if (_totalPlantsCount <= 5)
      return l10n.profileNextLevelSkilled(6 - _totalPlantsCount);
    if (_totalPlantsCount <= 10)
      return l10n.profileNextLevelMaster(11 - _totalPlantsCount);
    return l10n.profileNextLevelMax;
  }

  double get _levelProgress {
    if (_totalPlantsCount == 0) return 0.0;
    if (_totalPlantsCount <= 2) return _totalPlantsCount / 3;
    if (_totalPlantsCount <= 5) return _totalPlantsCount / 6;
    if (_totalPlantsCount <= 10) return _totalPlantsCount / 11;
    return 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _lightBg,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _fetchUserData,
              color: const Color(0xFF4FA976),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 36),
                      // Header
                      Text(
                        AppLocalizations.of(context)!.profileTitle,
                        style: GoogleFonts.outfit(
                          color: _primaryText,
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 24),

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
                                color: const Color(
                                  0xFFCBD5E1,
                                ).withOpacity(0.16),
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
                                  color: _accentGreen.withOpacity(0.2),
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
                                        color: _accentGreen.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.profileEditProfile,
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
                              Icon(
                                Icons.chevron_right_rounded,
                                color: _textSecondary,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

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
                                onTap: () =>
                                    setState(() => _selectedTabIndex = 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _selectedTabIndex == 0
                                        ? const Color(0xFF4FA976)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.profileOverview,
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
                                onTap: () =>
                                    setState(() => _selectedTabIndex = 1),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _selectedTabIndex == 1
                                        ? const Color(0xFF4FA976)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.profileSettingsTab,
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
                      const SizedBox(height: 24),

                      // Tab Contents
                      if (_selectedTabIndex == 0) _buildOverviewTab(),
                      if (_selectedTabIndex == 1) _buildSettingsTab(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildOverviewTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Gamified Gardener Title Level Card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFE2F4EB), Color(0xFFCBEBDC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFCBD5E1).withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.profileGardenerLevel,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF2C3E35).withOpacity(0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C3E35),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'LVL ${_totalPlantsCount > 10 ? 4 : (_totalPlantsCount > 5 ? 3 : (_totalPlantsCount > 2 ? 2 : 1))}',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                _gardenerTitle,
                style: GoogleFonts.outfit(
                  color: const Color(0xFF2C3E35),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: _levelProgress,
                  backgroundColor: Colors.white.withOpacity(0.5),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF4FA976),
                  ),
                  minHeight: 8,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _nextLevelText,
                style: GoogleFonts.inter(
                  color: const Color(0xFF2C3E35).withOpacity(0.7),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Grid for Total Plants & Completed Tasks
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _cardBg,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFCBD5E1).withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
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
                          child: const Icon(
                            Icons.local_florist_rounded,
                            color: Color(0xFF4FA976),
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _totalPlantsCount.toString(),
                      style: GoogleFonts.outfit(
                        color: _primaryText,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppLocalizations.of(context)!.profileTotalPlants,
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
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFCBD5E1).withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
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
                            Icons.check_circle_rounded,
                            color: Color(0xFF4FA976),
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _completedTasksCount.toString(),
                      style: GoogleFonts.outfit(
                        color: _primaryText,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppLocalizations.of(context)!.profileCompletedTasks,
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
        const SizedBox(height: 20),

        // Care Activity
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: _cardBg,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFCBD5E1).withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.profileWeeklyActivity,
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
                children: List.generate(7, (index) {
                  return _buildActivityBar(
                    _activityDays[index],
                    _weeklyActivity[index],
                  );
                }),
              ),
            ],
          ),
        ),
        const SizedBox(height: 120), // Padding for nav bar
      ],
    );
  }

  Widget _buildActivityBar(String day, double percentage) {
    final double displayHeight = percentage > 0 ? (120 * percentage) : 6.0;

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
            height: displayHeight,
            width: 12,
            decoration: BoxDecoration(
              color: percentage > 0
                  ? const Color(0xFF4FA976)
                  : const Color(0xFFE2E8F0),
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
          AppLocalizations.of(context)!.profileGeneral,
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
            title: AppLocalizations.of(context)!.profileAppSettings,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
          _buildMenuItem(
            icon: Icons.notifications_none_rounded,
            title: AppLocalizations.of(context)!.profileNotificationPrefs,
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
          AppLocalizations.of(context)!.profileSupportLegal,
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
            title: AppLocalizations.of(context)!.profileHelpCenter,
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.description_outlined,
            title: AppLocalizations.of(context)!.profileTerms,
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
            title: AppLocalizations.of(context)!.profileSignOut,
            textColor: _primaryText,
            iconColor: _textSecondary,
            onTap: () => _showSignOutDialog(context),
          ),
          _buildMenuItem(
            icon: Icons.delete_outline_rounded,
            title: AppLocalizations.of(context)!.profileDeleteAccount,
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
            color: const Color(0xFFCBD5E1).withOpacity(0.08),
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
              child: Icon(
                icon,
                color: iconColor ?? const Color(0xFF4FA976),
                size: 20,
              ),
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
          'Çıkış Yap',
          style: GoogleFonts.outfit(
            color: _primaryText,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Hesabınızdan çıkış yapmak istediğinize emin misiniz?',
          style: GoogleFonts.inter(color: _textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'İptal',
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
              'Çıkış Yap',
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
          'Hesabı Sil',
          style: GoogleFonts.outfit(
            color: _dangerColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Bu işlem geri alınamaz. Tüm bahçe verileriniz, fotoğraflarınız ve geçmişiniz kalıcı olarak silinecektir. Devam etmek istiyor musunuz?',
          style: GoogleFonts.inter(color: _textSecondary, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'İptal',
              style: GoogleFonts.inter(
                color: _textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _dangerColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              'Sil',
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
