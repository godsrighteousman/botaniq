import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../controllers/home_controller.dart';
import '../models/home_models.dart';
import 'home_header.dart';
import 'horizontal_calendar.dart';
import 'task_list_section.dart';
import 'weather_card.dart';
import 'empty_garden_card.dart';
import 'my_plants_carousel.dart';
import 'quick_actions_card.dart';
import 'sick_plants_section.dart';

/// Home tab'ının ana içerik widget'ı.
/// HomeController'dan gelen verileri dinler ve tüm alt bileşenleri compose eder.
class HomeScreen extends StatefulWidget {
  final HomeController controller;
  final VoidCallback onViewAllPlants;

  const HomeScreen({
    super.key,
    required this.controller,
    required this.onViewAllPlants,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController get _ctrl => widget.controller;

  @override
  void initState() {
    super.initState();
    // Tüm notifier'ları dinle
    _ctrl.isLoading.addListener(_rebuild);
    _ctrl.userName.addListener(_rebuild);
    _ctrl.selectedDate.addListener(_rebuild);
    _ctrl.filteredTasks.addListener(_rebuild);
    _ctrl.overdueTasks.addListener(_rebuild);
    _ctrl.tomorrowTasks.addListener(_rebuild);
    _ctrl.plants.addListener(_rebuild);
    _ctrl.sickPlants.addListener(_rebuild);
    _ctrl.daysWithTasks.addListener(_rebuild);
    _ctrl.locationName.addListener(_rebuild);
    _ctrl.weatherTemp.addListener(_rebuild);
    _ctrl.weatherCondition.addListener(_rebuild);
    _ctrl.weatherTip.addListener(_rebuild);
  }

  @override
  void dispose() {
    _ctrl.isLoading.removeListener(_rebuild);
    _ctrl.userName.removeListener(_rebuild);
    _ctrl.selectedDate.removeListener(_rebuild);
    _ctrl.filteredTasks.removeListener(_rebuild);
    _ctrl.overdueTasks.removeListener(_rebuild);
    _ctrl.tomorrowTasks.removeListener(_rebuild);
    _ctrl.plants.removeListener(_rebuild);
    _ctrl.sickPlants.removeListener(_rebuild);
    _ctrl.daysWithTasks.removeListener(_rebuild);
    _ctrl.locationName.removeListener(_rebuild);
    _ctrl.weatherTemp.removeListener(_rebuild);
    _ctrl.weatherCondition.removeListener(_rebuild);
    _ctrl.weatherTip.removeListener(_rebuild);
    super.dispose();
  }

  void _rebuild() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _ctrl.refresh,
        color: const Color(0xFF0ED761),
        backgroundColor: Colors.white,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                child: HomeHeader(
                  userName: _ctrl.userName.value,
                  onNotificationsTap: () =>
                      _showNotificationsBottomSheet(context),
                  onSignOutTap: () => _showSignOutDialog(context),
                ),
              ),
            ),

            // Hava durumu
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: WeatherCard(
                  locationName: _ctrl.locationName.value,
                  temperature: _ctrl.weatherTemp.value,
                  condition: _ctrl.weatherCondition.value,
                  tip: _ctrl.weatherTip.value,
                ),
              ),
            ),

            // Dinamik takvim
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 24),
                child: HorizontalCalendar(
                  days: _ctrl.weekDays,
                  selectedDate: _ctrl.selectedDate.value,
                  daysWithTasks: _ctrl.daysWithTasks.value,
                  onDateSelected: _ctrl.selectDate,
                ),
              ),
            ),

            // Görev listesi
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
                child: TaskListSection(
                  sectionTitle:
                      _ctrl.taskSectionTitle(_ctrl.selectedDate.value),
                  overdueTasks: _ctrl.overdueTasks.value,
                  tasks: _ctrl.filteredTasks.value,
                  tomorrowTasks: _ctrl.tomorrowTasks.value,
                  showTomorrow: _isTodaySelected(),
                  onTaskTap: (task) => _showTaskDetails(context, task),
                ),
              ),
            ),

            // Bitki bölümü (empty state veya carousel)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
                child: _ctrl.isLoading.value
                    ? _buildLoadingShimmer()
                    : _ctrl.hasPlants
                        ? MyPlantsCarousel(
                            plants: _ctrl.plants.value,
                            onViewAllTap: widget.onViewAllPlants,
                          )
                        : const EmptyGardenCard(),
              ),
            ),

            // Hasta Bitkiler Bölümü (Sadece hasta bitki olduğunda gözükür)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
                child: SickPlantsSection(
                  sickPlants: _ctrl.sickPlants.value,
                  onRefresh: _ctrl.refresh,
                ),
              ),
            ),

            // Hızlı eylem
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
                child: _ctrl.hasPlants
                    ? const QuickActionsCard()
                    : const SizedBox.shrink(),
              ),
            ),

            // Alt boşluk
            const SliverToBoxAdapter(
              child: SizedBox(height: 120),
            ),
          ],
        ),
      ),
    );
  }

  bool _isTodaySelected() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final sel = _ctrl.selectedDate.value;
    final selected = DateTime(sel.year, sel.month, sel.day);
    return selected == today;
  }

  Widget _buildLoadingShimmer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFE8F5EE)),
      ),
      child: Column(
        children: [
          const SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(
              color: Color(0xFF0ED761),
              strokeWidth: 3,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Loading plants...',
            style: GoogleFonts.inter(
              color: const Color(0xFF7A8F82),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ── Dialogs & Bottom Sheets ──

  void _showNotificationsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Notifications',
                    style: GoogleFonts.outfit(
                      color: const Color(0xFF1B3A2A),
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F9F6),
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFE8F5EE)),
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        color: Color(0xFF5C7165),
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildNotificationItem(
                'Watering Time',
                'Your indoor plants need watering.',
                '10 min ago',
                Icons.water_drop_rounded,
                const Color(0xFF5A9FFE),
              ),
              const SizedBox(height: 12),
              _buildNotificationItem(
                'Welcome!',
                'Welcome to Botaniq. Start by adding your first plant.',
                '1 day ago',
                Icons.emoji_nature_rounded,
                const Color(0xFF0ED761),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNotificationItem(
    String title,
    String body,
    String time,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F9F6),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8F5EE)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    color: const Color(0xFF1B3A2A),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF5C7165),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF7A8F82),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          'Sign Out',
          style: GoogleFonts.outfit(
            color: const Color(0xFF1B3A2A),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to sign out?',
          style: GoogleFonts.inter(color: const Color(0xFF5C7165)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: const Color(0xFF5C7165),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await Supabase.instance.client.auth.signOut();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1B3A2A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
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

  void _showTaskDetails(BuildContext context, CareTask task) {
    if (task.isCompleted) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: const Color(0xFFE8F5EE),
                      image: task.imageUrl.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(task.imageUrl),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: task.imageUrl.isEmpty
                        ? const Icon(
                            Icons.local_florist_outlined,
                            color: Color(0xFF86D5A6),
                            size: 28,
                          )
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.plantName,
                          style: GoogleFonts.outfit(
                            color: const Color(0xFF1B3A2A),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0ED761).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                task.taskType,
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF0ED761),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            if (task.isOverdue) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF6B6B)
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Overdue',
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFFFF6B6B),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Talimatlar
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Instructions',
                  style: GoogleFonts.outfit(
                    color: const Color(0xFF1B3A2A),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  task.instruction,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF5C7165),
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Gerekli miktar
              if (task.amount.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F9F6),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFE8F5EE)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        task.taskType.toLowerCase() == 'water'
                            ? Icons.water_drop_rounded
                            : Icons.eco_rounded,
                        color: const Color(0xFF5C7165),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Required: ${task.amount}',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF1B3A2A),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 32),

              // Aksiyon butonları
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF5F9F6),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: Text(
                          'Later',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF1B3A2A),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () {
                          _ctrl.markTaskDone(task.id);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF0ED761),
                                Color(0xFF0ABF55),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Mark as Done',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
