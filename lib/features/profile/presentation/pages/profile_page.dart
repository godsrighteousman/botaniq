import 'package:botaniq/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../onboarding/presentation/pages/onboarding_page.dart';
import 'edit_profile_page.dart';
import 'notifications_settings_page.dart';
import 'settings_page.dart';
import 'terms_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const _background = Color(0xFFF5F9F6);
  static const _surface = Colors.white;
  static const _ink = Color(0xFF20352A);
  static const _muted = Color(0xFF7A8F82);
  static const _green = Color(0xFF0ED761);
  static const _deepGreen = Color(0xFF174B32);
  static const _softGreen = Color(0xFFDDF8E8);
  static const _warm = Color(0xFFFFF3D8);
  static const _danger = Color(0xFFE96565);

  int _selectedTabIndex = 0;
  String _fullName = 'Bahçıvan';
  String _email = '';
  String _avatarUrl = 'https://i.pravatar.cc/150?img=68';
  bool _isLoading = true;

  int _totalPlantsCount = 0;
  int _completedTasksCount = 0;
  List<double> _weeklyActivity = List.filled(7, 0);
  List<String> _activityDays = const [
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
      await Future.wait([_fetchProfile(user), _fetchStatistics(user.id)]);
    }
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  Future<Map<String, dynamic>?> _profileRow(
    String table,
    String columns,
    String userId,
  ) async {
    try {
      return await Supabase.instance.client
          .from(table)
          .select(columns)
          .eq('id', userId)
          .maybeSingle()
          .timeout(const Duration(seconds: 5));
    } catch (_) {
      return null;
    }
  }

  Future<void> _fetchProfile(User user) async {
    final rows = await Future.wait([
      _profileRow('users', 'full_name, avatar_url', user.id),
      _profileRow('profiles', 'full_name, avatar_url', user.id),
    ]);
    final profile = rows[0] ?? rows[1];
    final metadataName = user.userMetadata?['full_name']?.toString().trim();
    final storedName = profile?['full_name']?.toString().trim();
    final storedAvatar = profile?['avatar_url']?.toString().trim();

    if (!mounted) {
      return;
    }
    setState(() {
      if (storedName != null && storedName.isNotEmpty) {
        _fullName = storedName;
      } else if (metadataName != null && metadataName.isNotEmpty) {
        _fullName = metadataName;
      }
      if (storedAvatar != null && storedAvatar.isNotEmpty) {
        _avatarUrl = storedAvatar;
      }
    });
  }

  Future<void> _fetchStatistics(String userId) async {
    List<dynamic> plants = const [];
    List<dynamic> completedTasks = const [];

    try {
      plants = await Supabase.instance.client
          .from('plants')
          .select('id')
          .eq('user_id', userId)
          .timeout(const Duration(seconds: 5));
    } catch (error) {
      debugPrint('Bitki istatistiği getirilemedi: $error');
    }

    try {
      completedTasks = await Supabase.instance.client
          .from('care_tasks')
          .select('id, completed_at')
          .eq('user_id', userId)
          .eq('is_completed', true)
          .timeout(const Duration(seconds: 5));
    } catch (_) {
      try {
        completedTasks = await Supabase.instance.client
            .from('care_tasks')
            .select('id')
            .eq('user_id', userId)
            .eq('is_completed', true)
            .timeout(const Duration(seconds: 5));
      } catch (error) {
        debugPrint('Bakım istatistiği getirilemedi: $error');
      }
    }

    if (!mounted) {
      return;
    }

    final now = DateTime.now();
    final startOfPeriod = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(const Duration(days: 6));
    final counts = List.filled(7, 0);

    for (final task in completedTasks) {
      if (task is! Map<String, dynamic>) {
        continue;
      }
      final completedAt = task['completed_at']?.toString();
      if (completedAt == null || completedAt.isEmpty) {
        continue;
      }
      final parsed = DateTime.tryParse(completedAt)?.toLocal();
      if (parsed == null) {
        continue;
      }
      final taskDay = DateTime(parsed.year, parsed.month, parsed.day);
      final difference = taskDay.difference(startOfPeriod).inDays;
      if (difference >= 0 && difference < counts.length) {
        counts[difference]++;
      }
    }

    final localeCode = Localizations.localeOf(context).languageCode;
    const turkishDays = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'];
    const englishDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final labels = <String>[];
    for (var index = 0; index < 7; index++) {
      final day = startOfPeriod.add(Duration(days: index));
      final source = localeCode == 'tr' ? turkishDays : englishDays;
      labels.add(source[day.weekday - 1]);
    }

    var maxCount = 1;
    for (final count in counts) {
      if (count > maxCount) {
        maxCount = count;
      }
    }

    setState(() {
      _totalPlantsCount = plants.length;
      _completedTasksCount = completedTasks.length;
      _activityDays = labels;
      _weeklyActivity = counts.map((count) => count / maxCount).toList();
    });
  }

  AppLocalizations get _l10n => AppLocalizations.of(context)!;

  String get _gardenerTitle {
    if (_totalPlantsCount == 0) {
      return _l10n.profileTitleNew;
    }
    if (_totalPlantsCount <= 2) {
      return _l10n.profileTitleSprout;
    }
    if (_totalPlantsCount <= 5) {
      return _l10n.profileTitleLeaf;
    }
    if (_totalPlantsCount <= 10) {
      return _l10n.profileTitleSkilled;
    }
    return _l10n.profileTitleMaster;
  }

  String get _nextLevelText {
    if (_totalPlantsCount == 0) {
      return _l10n.profileNextLevelStart;
    }
    if (_totalPlantsCount <= 2) {
      return _l10n.profileNextLevelLeaf(3 - _totalPlantsCount);
    }
    if (_totalPlantsCount <= 5) {
      return _l10n.profileNextLevelSkilled(6 - _totalPlantsCount);
    }
    if (_totalPlantsCount <= 10) {
      return _l10n.profileNextLevelMaster(11 - _totalPlantsCount);
    }
    return _l10n.profileNextLevelMax;
  }

  double get _levelProgress {
    if (_totalPlantsCount == 0) {
      return 0;
    }
    if (_totalPlantsCount <= 2) {
      return _totalPlantsCount / 3;
    }
    if (_totalPlantsCount <= 5) {
      return (_totalPlantsCount - 2) / 3;
    }
    if (_totalPlantsCount <= 10) {
      return (_totalPlantsCount - 5) / 5;
    }
    return 1;
  }

  int get _level {
    if (_totalPlantsCount > 10) {
      return 5;
    }
    if (_totalPlantsCount > 5) {
      return 4;
    }
    if (_totalPlantsCount > 2) {
      return 3;
    }
    if (_totalPlantsCount > 0) {
      return 2;
    }
    return 1;
  }

  String get _initials {
    final parts = _fullName
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) {
      return 'B';
    }
    if (parts.length == 1) {
      return parts.first.characters.first.toUpperCase();
    }
    return '${parts.first.characters.first}${parts.last.characters.first}'
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        bottom: false,
        child: _isLoading
            ? _buildLoadingState()
            : RefreshIndicator(
                onRefresh: _fetchUserData,
                color: _deepGreen,
                backgroundColor: _surface,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 720),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeader(),
                            const SizedBox(height: 20),
                            _buildPassportCard(),
                            const SizedBox(height: 18),
                            _buildSegmentedControl(),
                            const SizedBox(height: 18),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 280),
                              switchInCurve: Curves.easeOutCubic,
                              switchOutCurve: Curves.easeInCubic,
                              transitionBuilder: (child, animation) {
                                final offset = Tween<Offset>(
                                  begin: const Offset(0.03, 0),
                                  end: Offset.zero,
                                ).animate(animation);
                                return FadeTransition(
                                  opacity: animation,
                                  child: SlideTransition(
                                    position: offset,
                                    child: child,
                                  ),
                                );
                              },
                              child: _selectedTabIndex == 0
                                  ? KeyedSubtree(
                                      key: const ValueKey('overview'),
                                      child: _buildOverviewTab(),
                                    )
                                  : KeyedSubtree(
                                      key: const ValueKey('settings'),
                                      child: _buildSettingsTab(),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: const BoxDecoration(
              color: _softGreen,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.eco_rounded, color: _deepGreen, size: 28),
          ),
          const SizedBox(height: 16),
          const SizedBox(
            width: 90,
            child: LinearProgressIndicator(
              minHeight: 4,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: _green,
              backgroundColor: Color(0xFFDCE7DF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _l10n.profileTitle,
                style: GoogleFonts.outfit(
                  color: _ink,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  height: 1,
                  letterSpacing: -0.7,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _l10n.profileSubtitle,
                style: GoogleFonts.inter(
                  color: _muted,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        Semantics(
          button: true,
          label: _l10n.profileSettingsTab,
          child: Material(
            color: _surface,
            borderRadius: BorderRadius.circular(18),
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () => setState(() => _selectedTabIndex = 1),
              child: const SizedBox(
                width: 48,
                height: 48,
                child: Icon(Icons.tune_rounded, color: _ink, size: 22),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPassportCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _deepGreen,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: _deepGreen.withValues(alpha: 0.18),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            right: -34,
            top: -42,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.09),
                  width: 28,
                ),
              ),
            ),
          ),
          Positioned(
            right: 25,
            bottom: -18,
            child: Transform.rotate(
              angle: -0.35,
              child: Icon(
                Icons.eco_rounded,
                color: _green.withValues(alpha: 0.16),
                size: 92,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      _l10n.profileGardenPassport,
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.62),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.7,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'LVL $_level',
                        style: GoogleFonts.outfit(
                          color: _ink,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    _buildAvatar(),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _fullName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.4,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _email,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              color: Colors.white.withValues(alpha: 0.62),
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Material(
                            color: Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(14),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(14),
                              onTap: _openEditProfile,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.edit_rounded,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      _l10n.profileEditProfile,
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    final fallback = Container(
      color: _softGreen,
      alignment: Alignment.center,
      child: Text(
        _initials,
        style: GoogleFonts.outfit(
          color: _deepGreen,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
    );

    return Container(
      width: 78,
      height: 78,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.28),
          width: 1,
        ),
      ),
      child: ClipOval(
        child: _avatarUrl.isEmpty
            ? fallback
            : Image.network(
                _avatarUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => fallback,
              ),
      ),
    );
  }

  Widget _buildSegmentedControl() {
    return Container(
      height: 52,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF1EC),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          _buildSegment(_l10n.profileOverview, 0, Icons.auto_graph_rounded),
          _buildSegment(_l10n.profileSettingsTab, 1, Icons.tune_rounded),
        ],
      ),
    );
  }

  Widget _buildSegment(String label, int index, IconData icon) {
    final selected = _selectedTabIndex == index;
    return Expanded(
      child: Semantics(
        button: true,
        selected: selected,
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => setState(() => _selectedTabIndex = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              decoration: BoxDecoration(
                color: selected ? _surface : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                boxShadow: selected
                    ? [
                        BoxShadow(
                          color: _ink.withValues(alpha: 0.07),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 17, color: selected ? _deepGreen : _muted),
                  const SizedBox(width: 7),
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      color: selected ? _ink : _muted,
                      fontSize: 13,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
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
        _buildLevelCard(),
        const SizedBox(height: 14),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 360) {
              return Column(
                children: [
                  _buildMetricCard(
                    value: _totalPlantsCount,
                    label: _l10n.profileTotalPlants,
                    icon: Icons.local_florist_rounded,
                    color: _deepGreen,
                    background: _softGreen,
                  ),
                  const SizedBox(height: 12),
                  _buildMetricCard(
                    value: _completedTasksCount,
                    label: _l10n.profileCompletedTasks,
                    icon: Icons.done_all_rounded,
                    color: const Color(0xFFB56A10),
                    background: _warm,
                  ),
                ],
              );
            }
            return Row(
              children: [
                Expanded(
                  child: _buildMetricCard(
                    value: _totalPlantsCount,
                    label: _l10n.profileTotalPlants,
                    icon: Icons.local_florist_rounded,
                    color: _deepGreen,
                    background: _softGreen,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildMetricCard(
                    value: _completedTasksCount,
                    label: _l10n.profileCompletedTasks,
                    icon: Icons.done_all_rounded,
                    color: const Color(0xFFB56A10),
                    background: _warm,
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 14),
        _buildActivityCard(),
        const SizedBox(height: 120),
      ],
    );
  }

  Widget _buildLevelCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: _softGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.workspace_premium_rounded,
                  color: _deepGreen,
                  size: 22,
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _l10n.profileGardenerLevel,
                      style: GoogleFonts.inter(
                        color: _muted,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _gardenerTitle,
                      style: GoogleFonts.outfit(
                        color: _ink,
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: LinearProgressIndicator(
              value: _levelProgress.clamp(0, 1),
              minHeight: 10,
              backgroundColor: const Color(0xFFEAF1EC),
              valueColor: const AlwaysStoppedAnimation(_green),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _nextLevelText,
            style: GoogleFonts.inter(color: _muted, fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required int value,
    required String label,
    required IconData icon,
    required Color color,
    required Color background,
  }) {
    return Container(
      height: 142,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 21),
              const Spacer(),
              Icon(
                Icons.north_east_rounded,
                color: color.withValues(alpha: 0.42),
                size: 18,
              ),
            ],
          ),
          const Spacer(),
          Text(
            '$value',
            style: GoogleFonts.outfit(
              color: color,
              fontSize: 34,
              height: 1,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              color: color.withValues(alpha: 0.72),
              fontSize: 12,
              height: 1.25,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard() {
    final hasActivity = _weeklyActivity.any((value) => value > 0);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _l10n.profileWeeklyActivity,
                      style: GoogleFonts.outfit(
                        color: _ink,
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      hasActivity
                          ? _l10n.profileActiveWeek
                          : _l10n.profileQuietWeek,
                      style: GoogleFonts.inter(
                        color: _muted,
                        fontSize: 11,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _background,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  _l10n.profileThisWeek,
                  style: GoogleFonts.inter(
                    color: _deepGreen,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(7, _buildActivityBar),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityBar(int index) {
    final percentage = _weeklyActivity[index].clamp(0.0, 1.0);
    final height = percentage > 0 ? 20 + (68 * percentage) : 9.0;
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: 92,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 320 + (index * 45)),
                curve: Curves.easeOutBack,
                width: 12,
                height: height,
                decoration: BoxDecoration(
                  color: percentage > 0 ? _green : const Color(0xFFE2EAE4),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: percentage > 0
                      ? [
                          BoxShadow(
                            color: _green.withValues(alpha: 0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : null,
                ),
              ),
            ),
          ),
          const SizedBox(height: 9),
          Text(
            _activityDays[index],
            style: GoogleFonts.inter(
              color: percentage > 0 ? _ink : _muted,
              fontSize: 10,
              fontWeight: percentage > 0 ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(_l10n.profileGeneral),
        const SizedBox(height: 10),
        _buildMenuSection([
          _ProfileMenuData(
            icon: Icons.tune_rounded,
            color: _deepGreen,
            title: _l10n.profileAppSettings,
            subtitle: _l10n.profileAppSettingsSubtitle,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsPage()),
            ),
          ),
          _ProfileMenuData(
            icon: Icons.notifications_active_outlined,
            color: const Color(0xFF6C63D8),
            title: _l10n.profileNotificationPrefs,
            subtitle: _l10n.profileNotificationPrefsSubtitle,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const NotificationsSettingsPage(),
              ),
            ),
          ),
        ]),
        const SizedBox(height: 24),
        _buildSectionTitle(_l10n.profileSupportLegal),
        const SizedBox(height: 10),
        _buildMenuSection([
          _ProfileMenuData(
            icon: Icons.support_agent_rounded,
            color: const Color(0xFF2D8BCB),
            title: _l10n.profileHelpCenter,
            subtitle: _l10n.profileHelpCenterSubtitle,
            onTap: _showComingSoon,
          ),
          _ProfileMenuData(
            icon: Icons.policy_outlined,
            color: const Color(0xFFB56A10),
            title: _l10n.profileTerms,
            subtitle: _l10n.profileTermsSubtitle,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TermsPage()),
            ),
          ),
        ]),
        const SizedBox(height: 24),
        _buildSectionTitle(_l10n.profileAccountActions),
        const SizedBox(height: 10),
        _buildMenuSection([
          _ProfileMenuData(
            icon: Icons.logout_rounded,
            color: _muted,
            title: _l10n.profileSignOut,
            onTap: () => _showSignOutDialog(context),
          ),
          _ProfileMenuData(
            icon: Icons.delete_outline_rounded,
            color: _danger,
            title: _l10n.profileDeleteAccount,
            onTap: () => _showDeleteAccountDialog(context),
            destructive: true,
          ),
        ]),
        const SizedBox(height: 120),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.inter(
          color: _muted,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.3,
        ),
      ),
    );
  }

  Widget _buildMenuSection(List<_ProfileMenuData> items) {
    return Container(
      decoration: _cardDecoration(),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          for (var index = 0; index < items.length; index++) ...[
            _buildMenuItem(items[index]),
            if (index != items.length - 1)
              const Divider(
                height: 1,
                thickness: 1,
                color: Color(0xFFEDF2EE),
                indent: 72,
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildMenuItem(_ProfileMenuData item) {
    return Material(
      color: item.destructive
          ? _danger.withValues(alpha: 0.025)
          : Colors.transparent,
      child: InkWell(
        onTap: item.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: item.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(item.icon, color: item.color, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: GoogleFonts.inter(
                        color: item.destructive ? _danger : _ink,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (item.subtitle != null) ...[
                      const SizedBox(height: 3),
                      Text(
                        item.subtitle!,
                        style: GoogleFonts.inter(
                          color: _muted,
                          fontSize: 11,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: item.destructive
                    ? _danger.withValues(alpha: 0.42)
                    : _muted.withValues(alpha: 0.48),
                size: 14,
              ),
            ],
          ),
        ),
      ),
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

  Future<void> _openEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const EditProfilePage()),
    );
    if (result == true && mounted) {
      await _fetchUserData();
    }
  }

  void _showComingSoon() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_l10n.settingsComingSoon),
        behavior: SnackBarBehavior.floating,
        backgroundColor: _deepGreen,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: _surface,
        icon: const Icon(Icons.logout_rounded, color: _deepGreen),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        title: Text(
          _l10n.profileSignOut,
          textAlign: TextAlign.center,
          style: GoogleFonts.outfit(color: _ink, fontWeight: FontWeight.w700),
        ),
        content: Text(
          _l10n.profileSignOutQuestion,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(color: _muted, height: 1.45),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(_l10n.cancel),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await Supabase.instance.client.auth.signOut();
              if (!context.mounted) {
                return;
              }
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const OnboardingPage()),
                (_) => false,
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: _deepGreen,
              foregroundColor: Colors.white,
            ),
            child: Text(_l10n.profileSignOut),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: _surface,
        icon: Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: _danger.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.shield_outlined, color: _danger),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        title: Text(
          _l10n.profileDeleteAccount,
          textAlign: TextAlign.center,
          style: GoogleFonts.outfit(
            color: _danger,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          _l10n.profileDeleteAccountWarning,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(color: _muted, height: 1.5),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          FilledButton.tonal(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(_l10n.continueAction),
          ),
        ],
      ),
    );
  }
}

class _ProfileMenuData {
  const _ProfileMenuData({
    required this.icon,
    required this.color,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.destructive = false,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final bool destructive;
}
