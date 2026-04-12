import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'doctor_tab.dart';
import 'hospital_tab.dart';
import 'discover_health_tab.dart';

class HealthyPage extends StatefulWidget {
  const HealthyPage({super.key});

  @override
  State<HealthyPage> createState() => _HealthyPageState();
}

class _HealthyPageState extends State<HealthyPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final Color _primaryGreen = const Color(0xFF4FA976);
  final Color _bgHint = const Color(0xFFF9FAF9);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgHint,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const BouncingScrollPhysics(),
                children: const [
                  DoctorTab(),
                  HospitalTab(),
                  DiscoverHealthTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bakım Merkezi',
            style: GoogleFonts.outfit(
              color: const Color(0xFF2C3E35),
              fontSize: 32,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Bitkilerinin ruhuna dokun, onlarla konuş.',
            style: GoogleFonts.inter(
              color: const Color(0xFF8B9E93),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFCBD5E1).withOpacity(0.04 * 4),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: _primaryGreen.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
        ),
        labelColor: _primaryGreen,
        unselectedLabelColor: const Color(0xFF8B9E93),
        labelStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'Doctor'),
          Tab(text: 'Hastane'),
          Tab(text: 'Keşfet'),
        ],
      ),
    );
  }
}
