import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'photo_instruction_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../garden/presentation/pages/garden_page.dart';
import '../../../healthy/presentation/pages/healthy_page.dart';
import '../../../subscription/presentation/controllers/subscription_controller.dart';
import '../../../subscription/presentation/pages/subscription_page.dart';
import '../../../../core/services/care_notification_service.dart';
import 'package:botaniq/l10n/app_localizations.dart';

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
  Color get _textSecondary => Theme.of(context).colorScheme.onSurfaceVariant;

  int _currentIndex = 0;
  int _clinicInitialTabIndex = 0;
  int _clinicNavigationVersion = 0;
  late final HomeController _homeController;
  late final SubscriptionController _subscriptionController;
  Timer? _launchPaywallTimer;

  @override
  void initState() {
    super.initState();
    _homeController = HomeController();
    _subscriptionController = context.read<SubscriptionController>();
    _subscriptionController.addListener(_maybeShowLaunchPaywall);
    CareNotificationService.instance.destination.addListener(
      _handleNotificationDestination,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleNotificationDestination();
      CareNotificationService.instance.requestPermissionOnceAndRefresh();
      _maybeShowLaunchPaywall();
    });
  }

  @override
  void dispose() {
    _launchPaywallTimer?.cancel();
    CareNotificationService.instance.destination.removeListener(
      _handleNotificationDestination,
    );
    _subscriptionController.removeListener(_maybeShowLaunchPaywall);
    _homeController.dispose();
    super.dispose();
  }

  /// Uygulama açılışında, abonelik ürünleri yüklenip kullanıcının premium
  /// olmadığı kesinleştiğinde (ve bu süreçte daha önce gösterilmediyse), 5
  /// saniyelik bir bekleme sonrası tam ekran ödeme duvarını otomatik olarak
  /// açar — kullanıcı önce Ana Sayfa'yı görebilsin diye. Kapatma butonu her
  /// zaman görünür kalır — kullanıcı istediği an vazgeçebilir.
  void _maybeShowLaunchPaywall() {
    if (!mounted || _launchPaywallTimer != null) return;
    if (!_subscriptionController.shouldShowLaunchPaywall) return;
    _launchPaywallTimer = Timer(
      const Duration(seconds: 5),
      _fireLaunchPaywall,
    );
  }

  void _fireLaunchPaywall() {
    _launchPaywallTimer = null;
    if (!mounted) return;
    // 5 saniyelik bekleme sırasında kullanıcı premium olmuş veya paywall
    // başka bir yoldan zaten gösterilmiş olabilir — ateşleme anında tekrar
    // kontrol ediyoruz, sadece zamanlama başında değil.
    if (!_subscriptionController.shouldShowLaunchPaywall) return;
    _subscriptionController.markLaunchPaywallShown();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const SubscriptionPage(),
          fullscreenDialog: true,
        ),
      );
    });
  }

  void _handleNotificationDestination() {
    final destination = CareNotificationService.instance.consumeDestination();
    if (!mounted || destination == null) return;
    setState(() {
      if (destination == CareNotificationDestination.garden) {
        _currentIndex = 1;
      } else {
        _clinicInitialTabIndex = 1;
        _clinicNavigationVersion++;
        _currentIndex = 2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
        return HealthyPage(
          key: ValueKey(_clinicNavigationVersion),
          initialTabIndex: _clinicInitialTabIndex,
        );
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
    final l10n = AppLocalizations.of(context)!;
    return Semantics(
      button: true,
      label: l10n.scanPlant,
      child: Container(
        height: 60,
        width: 60,
        margin: const EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: _accentGreen.withValues(alpha: 0.4),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PhotoInstructionPage(),
              ),
            );
            if (!mounted) return;
            await _homeController.refresh();
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
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
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
            _buildNavItem(Icons.home_filled, l10n.navHome, 0),
            _buildNavItem(Icons.local_florist_outlined, l10n.navGarden, 1),
            const SizedBox(width: 48), // FAB boşluğu
            _buildNavItem(Icons.medical_services_outlined, l10n.navClinic, 2),
            _buildNavItem(Icons.person_outline, l10n.navProfile, 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? _accentGreen : _textSecondary.withValues(alpha: 0.6);

    return GestureDetector(
      onTap: () async {
        if (_currentIndex == index) return;

        setState(() => _currentIndex = index);
        if (index == 0) {
          await _homeController.refresh();
        }
      },
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
                    ? _accentGreen.withValues(alpha: 0.1)
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
