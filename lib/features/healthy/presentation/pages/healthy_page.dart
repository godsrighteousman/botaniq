import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:botaniq/l10n/app_localizations.dart';
import 'doctor_tab.dart';
import 'hospital_tab.dart';
import 'discover_health_tab.dart';

class HealthyPage extends StatefulWidget {
  final int initialTabIndex;

  const HealthyPage({super.key, this.initialTabIndex = 0});

  @override
  State<HealthyPage> createState() => _HealthyPageState();
}

class _HealthyPageState extends State<HealthyPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _hospitalRefreshVersion = 0;

  final Color _primaryGreen = const Color(0xFF4FA976);
  final Color _bgHint = const Color(0xFFF9FAF9);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialTabIndex.clamp(0, 2),
    );
    _tabController.addListener(_handleTabChange);
  }

  @override
  void didUpdateWidget(covariant HealthyPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    final target = widget.initialTabIndex.clamp(0, 2);
    if (target != oldWidget.initialTabIndex && _tabController.index != target) {
      _tabController.animateTo(target);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (_tabController.index == 1 && !_tabController.indexIsChanging) {
      _refreshHospital();
    }
  }

  void _refreshHospital() {
    if (!mounted) return;
    setState(() => _hospitalRefreshVersion++);
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
                children: [
                  DoctorTab(onHealthChanged: _refreshHospital),
                  HospitalTab(refreshVersion: _hospitalRefreshVersion),
                  const DiscoverHealthTab(),
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
            AppLocalizations.of(context)!.healthyTitle,
            style: GoogleFonts.outfit(
              color: const Color(0xFF2C3E35),
              fontSize: 32,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            AppLocalizations.of(context)!.healthySubtitle,
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
        tabs: [
          Tab(text: AppLocalizations.of(context)!.healthyTabDoctor),
          Tab(text: AppLocalizations.of(context)!.healthyTabHospital),
          Tab(text: AppLocalizations.of(context)!.healthyTabDiscover),
        ],
      ),
    );
  }
}
