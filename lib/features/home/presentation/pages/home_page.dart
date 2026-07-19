import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'photo_instruction_page.dart';
import 'schedule_page.dart';
import 'search_plant_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../discover/presentation/pages/discover_page.dart';
import '../../../garden/presentation/pages/garden_page.dart';
import '../../../healthy/presentation/pages/healthy_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color _accentGreen = const Color(0xFF86D5A6);
  final Color _lightBg = const Color(0xFFF9FAF9);
  final Color _cardBg = Colors.white;
  final Color _textSecondary = const Color(0xFF8A8A8E);

  bool _wateringEnabled = true;
  bool _fertilizingEnabled = false;
  int _currentIndex = 0;
  final bool _hasPlants = true;

  late DateTime _selectedDate;
  final List<DateTime> _weekDays = [];

  final List<Map<String, dynamic>> _tasks = [
    {
      'id': '1',
      'plantName': 'Monstera Deliciosa',
      'taskType': 'Watering',
      'amount': '250ml',
      'instruction':
          'Water thoroughly until water drains out of the bottom hole. Avoid getting water on the leaves.',
      'image':
          'https://images.unsplash.com/photo-1485955900006-10f4d324d411?auto=format&fit=crop&q=80&w=400',
      'isCompleted': false,
    },
    {
      'id': '2',
      'plantName': 'Fiddle Leaf Fig',
      'taskType': 'Fertilize',
      'amount': 'Liquid Fertilizer',
      'instruction':
          'Use a balanced liquid fertilizer diluted to half strength. Apply to moist soil.',
      'image':
          'https://images.unsplash.com/photo-1601985705806-5b9a71f6004f?auto=format&fit=crop&q=80&w=400',
      'isCompleted': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    for (int i = 0; i < 7; i++) {
      _weekDays.add(DateTime.now().add(Duration(days: i)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _lightBg,
      body: _buildBody(),
      floatingActionButton: _buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeTab();
      case 1:
        return const GardenPage();
      case 2:
        return const HealthyPage();
      case 3:
        return const ProfilePage();
      default:
        return _buildHomeTab();
    }
  }

  Widget _buildHomeTab() {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: _buildHeader(),
              ),
              const SizedBox(height: 32),
              _buildCalendarDays(),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: _buildTodayTasks(),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: _buildWeatherCard(),
              ),
              const SizedBox(height: 24),
              _hasPlants ? _buildMyPlantsSection() : _buildEmptyStateCard(),
              const SizedBox(height: 32),
              _buildQuickAddActions(),
              const SizedBox(height: 32),
              _buildSmartCareSection(),
              const SizedBox(height: 100), // padding for bottom nav
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good morning,',
              style: GoogleFonts.inter(
                color: _textSecondary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'My Garden',
              style: GoogleFonts.outfit(
                color: const Color(0xFF2C3E35),
                fontSize: 32,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        Row(
          children: [
            _buildActionIcon(
              Icons.calendar_today_rounded,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SchedulePage()),
                );
              },
            ),
            const SizedBox(width: 12),
            _buildActionIcon(Icons.history_edu_outlined, onTap: () {}),
          ],
        ),
      ],
    );
  }

  Widget _buildActionIcon(IconData icon, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: _cardBg,
          shape: BoxShape.circle,

          boxShadow: [
            BoxShadow(
              color: const Color(0xFFCBD5E1).withOpacity(0.02 * 4),
              blurRadius: 16,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: const Color(0xFF3B4D43), size: 20),
      ),
    );
  }

  Widget _buildWeatherCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(30),

        boxShadow: [
          BoxShadow(
            color: const Color(0xFFCBD5E1).withOpacity(0.02 * 4),
            blurRadius: 30,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFF3D4),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.wb_sunny_rounded,
                    color: Color(0xFFFFB347),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'San Francisco',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF2C3E35),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Sunny, perfect for watering',
                        style: GoogleFonts.inter(
                          color: _textSecondary,
                          fontSize: 13,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '72°',
            style: GoogleFonts.outfit(
              color: const Color(0xFF2C3E35),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyStateCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _accentGreen.withOpacity(0.15),
            _accentGreen.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(38),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: _accentGreen.withOpacity(0.15),
                      blurRadius: 40,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.local_florist_rounded,
                    color: _accentGreen.withOpacity(0.8),
                    size: 40,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: -4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: _accentGreen,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 14),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Your garden is empty',
            style: GoogleFonts.outfit(
              color: const Color(0xFF2C3E35),
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start building your green sanctuary\nby adding your first plant.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF6E6E73),
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PhotoInstructionPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _accentGreen,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              child: Text(
                'Add First Plant',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyPlantsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Plants',
              style: GoogleFonts.outfit(
                color: const Color(0xFF2C3E35),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() => _currentIndex = 1);
              },
              child: Text(
                'View All',
                style: GoogleFonts.inter(
                  color: _accentGreen,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 240,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            clipBehavior: Clip.none,
            children: [
              _buildHomePlantCard(
                'Monstera',
                'Swiss Cheese',
                'https://images.unsplash.com/photo-1614594975525-e45190c55d0b?auto=format&fit=crop&q=80&w=400',
                'Water in 2 days',
                Colors.blue,
              ),
              const SizedBox(width: 16),
              _buildHomePlantCard(
                'Ficus',
                'Rubber Plant',
                'https://images.unsplash.com/photo-1597055905001-c888d3f6d7ab?auto=format&fit=crop&q=80&w=400',
                'Water today',
                Colors.redAccent,
              ),
              const SizedBox(width: 16),
              _buildHomePlantCard(
                'Sansevieria',
                'Snake Plant',
                'https://images.unsplash.com/photo-1593482892290-f54927ae1b7e?auto=format&fit=crop&q=80&w=400',
                'Good',
                _accentGreen,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHomePlantCard(
    String name,
    String species,
    String imageUrl,
    String status,
    Color statusColor,
  ) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFCBD5E1).withOpacity(0.04 * 4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.outfit(
                    color: const Color(0xFF2C3E35),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  species,
                  style: GoogleFonts.inter(color: _textSecondary, fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.water_drop_rounded,
                        color: statusColor,
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          status,
                          style: GoogleFonts.inter(
                            color: statusColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmartCareSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Smart Care Reminders',
              style: GoogleFonts.outfit(
                color: const Color(0xFF2C3E35),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Icon(Icons.tune_rounded, color: Color(0xFF6B7D73), size: 22),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildReminderCard(
                icon: Icons.water_drop_rounded,
                iconColor: const Color(0xFF4A90E2),
                title: 'Watering',
                subtitle: 'Soil tracking',
                value: _wateringEnabled,
                onChanged: (val) {
                  setState(() {
                    _wateringEnabled = val;
                  });
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildReminderCard(
                icon: Icons.eco_rounded,
                iconColor: const Color(0xFFE2A04A),
                title: 'Fertilizing',
                subtitle: 'Nutrient alerts',
                value: _fertilizingEnabled,
                onChanged: (val) {
                  setState(() {
                    _fertilizingEnabled = val;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReminderCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(30),

        boxShadow: [
          BoxShadow(
            color: const Color(0xFFCBD5E1).withOpacity(0.02 * 4),
            blurRadius: 30,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              SizedBox(
                height: 32,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Switch(
                    value: value,
                    onChanged: onChanged,
                    activeThumbColor: Colors.white,
                    activeTrackColor: _accentGreen,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: const Color(0xFFE5E5EA),
                    splashRadius: 0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: GoogleFonts.inter(
              color: const Color(0xFF2C3E35),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.inter(color: _textSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAddActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add to your garden',
          style: GoogleFonts.outfit(
            color: const Color(0xFF2C3E35),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildPremiumQuickActionCard(
                title: 'Scan Plant',
                subtitle: 'Use camera',
                icon: Icons.document_scanner_rounded,
                backgroundGradient: [
                  const Color(0xFF4FA976),
                  const Color(0xFF86D5A6),
                ],
                iconColor: const Color(0xFF4FA976),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PhotoInstructionPage(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildPremiumQuickActionCard(
                title: 'Manually Search',
                subtitle: 'Find in catalog',
                icon: Icons.search_rounded,
                backgroundGradient: [
                  const Color(0xFF2C3E35),
                  const Color(0xFF435A4D),
                ],
                iconColor: const Color(0xFF2C3E35),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchPlantPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPremiumQuickActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required List<Color> backgroundGradient,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: backgroundGradient,
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: backgroundGradient.first.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -16,
              bottom: -16,
              child: Icon(
                icon,
                size: 90,
                color: Colors.white.withOpacity(0.15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: iconColor, size: 24),
                  ),
                  const Spacer(),
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAB() {
    return Semantics(
      button: true,
      label: 'Add Plant',
      child: Container(
        height: 60,
        width: 60,
        margin: const EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: _accentGreen.withOpacity(0.4),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PhotoInstructionPage(),
              ),
            );
          },
          backgroundColor: _accentGreen,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          child: const Icon(
            Icons.document_scanner_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: _cardBg,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFCBD5E1).withOpacity(0.04 * 4),
            blurRadius: 40,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(Icons.home_filled, 'Home', 0),
            _buildNavItem(Icons.local_florist_outlined, 'Garden', 1),
            const SizedBox(width: 48), // Space for FAB
            _buildNavItem(Icons.medical_services_outlined, 'Clinic', 2),
            _buildNavItem(Icons.person_outline, 'Profile', 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _currentIndex == index;
    Color color = isSelected ? _accentGreen : _textSecondary.withOpacity(0.6);

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 26),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                color: color,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _markTaskDone(String id) {
    setState(() {
      final taskIndex = _tasks.indexWhere((task) => task['id'] == id);
      if (taskIndex != -1) {
        _tasks[taskIndex]['isCompleted'] = true;
      }
    });
  }

  Widget _buildCalendarDays() {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: _weekDays.length,
        itemBuilder: (context, index) {
          final date = _weekDays[index];
          final isSelected =
              date.day == _selectedDate.day &&
              date.month == _selectedDate.month &&
              date.year == _selectedDate.year;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = date;
              });
            },
            child: Container(
              width: 60,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: isSelected ? _accentGreen : _cardBg,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : Colors.black.withOpacity(0.05),
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: _accentGreen.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('EEE').format(date),
                    style: GoogleFonts.inter(
                      color: isSelected ? Colors.white : _textSecondary,
                      fontSize: 13,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    date.day.toString(),
                    style: GoogleFonts.outfit(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTodayTasks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today Task',
          style: GoogleFonts.outfit(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        if (_tasks.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Text(
                'No tasks for today!',
                style: GoogleFonts.inter(color: _textSecondary, fontSize: 16),
              ),
            ),
          )
        else
          ..._tasks.map((task) => _buildTaskCard(task)),
      ],
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    bool isCompleted = task['isCompleted'];

    return GestureDetector(
      onTap: () => _showTaskDetails(context, task),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isCompleted ? _lightBg.withOpacity(0.5) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isCompleted
                ? Colors.transparent
                : Colors.black.withOpacity(0.05),
          ),
          boxShadow: isCompleted
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    spreadRadius: 0,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Row(
          children: [
            Opacity(
              opacity: isCompleted ? 0.5 : 1.0,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(task['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task['plantName'],
                    style: GoogleFonts.outfit(
                      color: isCompleted ? _textSecondary : Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        task['taskType'] == 'Watering'
                            ? Icons.water_drop
                            : Icons.eco,
                        color: isCompleted ? _textSecondary : _accentGreen,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          '${task['taskType']} - ${task['amount']}',
                          style: GoogleFonts.inter(
                            color: isCompleted
                                ? _textSecondary
                                : const Color(0xFF6E6E73),
                            fontSize: 13,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted ? _accentGreen : _lightBg,
                border: Border.all(
                  color: isCompleted
                      ? _accentGreen
                      : Colors.black.withOpacity(0.1),
                ),
              ),
              child: isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 18)
                  : const Icon(
                      Icons.chevron_right,
                      color: Colors.black54,
                      size: 20,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTaskDetails(BuildContext context, Map<String, dynamic> task) {
    if (task['isCompleted']) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            color: _cardBg,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: NetworkImage(task['image']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task['plantName'],
                          style: GoogleFonts.outfit(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _accentGreen.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            task['taskType'],
                            style: GoogleFonts.inter(
                              color: _accentGreen,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Instructions',
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                task['instruction'],
                style: GoogleFonts.inter(
                  color: _textSecondary,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _lightBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black.withOpacity(0.05)),
                ),
                child: Row(
                  children: [
                    Icon(
                      task['taskType'] == 'Watering'
                          ? Icons.water_drop
                          : Icons.eco,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Required: ${task['amount']}',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _lightBg,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Remind later',
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 16,
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
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          _markTaskDone(task['id']);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _accentGreen,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Done',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
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
