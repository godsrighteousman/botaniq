import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'photo_instruction_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../garden/presentation/pages/garden_page.dart';
import '../../../healthy/presentation/pages/healthy_page.dart';

import '../controllers/home_controller.dart';
import '../widgets/home_screen.dart';

/// Ana sayfa — Tab routing, bottom navigation ve FAB yönetimi.
/// Home tab içeriği [HomeScreen] widget'ına delege edilir.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _accentGreen = Color(0xFF0ED761);
  static const _textSecondary = Color(0xFF7A8F82);

  int _currentIndex = 0;
  late final HomeController _homeController;

  @override
  void initState() {
    super.initState();
    _homeController = HomeController();
  }

  @override
  void dispose() {
    _homeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F6),
      body: _buildBody(),
      floatingActionButton: _buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return HomeScreen(
          controller: _homeController,
          onViewAllPlants: () => setState(() => _currentIndex = 1),
        );
      case 1:
        return const GardenPage();
      case 2:
        return const HealthyPage();
      case 3:
        return const ProfilePage();
      default:
        return HomeScreen(
          controller: _homeController,
          onViewAllPlants: () => setState(() => _currentIndex = 1),
        );
    }
  }

  // ── FAB ──

  Widget _buildFAB() {
    return Semantics(
      button: true,
      label: 'Scan Plant',
      child: Container(
        height: 60,
        width: 60,
        margin: const EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: _accentGreen.withOpacity(0.4),
              blurRadius: 18,
              offset: const Offset(0, 6),
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
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          child: Ink(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0ED761), Color(0xFF0ABF55)],
              ),
              borderRadius: BorderRadius.circular(26),
            ),
            child: const SizedBox(
              width: 60,
              height: 60,
              child: Icon(
                Icons.document_scanner_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Bottom Navigation ──

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 30,
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
            const SizedBox(width: 48), // FAB boşluğu
            _buildNavItem(Icons.medical_services_outlined, 'Clinic', 2),
            _buildNavItem(Icons.person_outline, 'Profile', 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _currentIndex == index;
    final color =
        isSelected ? _accentGreen : _textSecondary.withOpacity(0.6);

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: isSelected
                    ? _accentGreen.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 2),
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
}
