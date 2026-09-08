import 'package:botaniq/l10n/app_localizations.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/config/legal_config.dart';
import '../../../profile/presentation/pages/terms_page.dart';
import '../controllers/subscription_controller.dart';

const _green = Color(0xFF0ED761);
const _deepGreen = Color(0xFF123E2A);
const _gold = Color(0xFFF5B74A);

/// Premium içeriğinin (hero, plan seçici, karşılaştırma tablosu, satın alma
/// akışı) tamamı — hem [SubscriptionPage] hem de Ayarlar sayfası içine
/// gömülü olarak kullanılabilsin diye paylaşılan tek bir widget'a taşındı.
/// Böylece kullanıcı Ayarlar'dan ayrı bir sayfaya geçmeden doğrudan planları
/// görüp satın alabiliyor.
class SubscriptionPanel extends StatefulWidget {
  const SubscriptionPanel({super.key});

  @override
  State<SubscriptionPanel> createState() => _SubscriptionPanelState();
}

class _SubscriptionPanelState extends State<SubscriptionPanel>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entrance = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 420),
  )..forward();

  @override
  void dispose() {
    _entrance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<SubscriptionController>();

    return FadeTransition(
      opacity: CurvedAnimation(parent: _entrance, curve: Curves.easeOut),
      child: SlideTransition(
        position:
            Tween<Offset>(
              begin: const Offset(0, 0.03),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: _entrance, curve: Curves.easeOutCubic),
            ),
        child: _buildContent(context, controller, l10n),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    SubscriptionController controller,
    AppLocalizations l10n,
  ) {
    if (controller.isPremium) {
      return _ActiveSubscriptionContent(
        controller: controller,
        onManage: () => _openManagement(context, controller.managementUrl),
        onRestore: () => _restore(context, controller),
      );
    }

    switch (controller.status) {
      case SubscriptionStatus.initial:
      case SubscriptionStatus.signedOut:
        // Geçici/aktif olmayan durumlar — sonsuz dönen bir gösterge yerine
        // boş bırakılır (özellikle gömülü kullanıldığında pumpAndSettle'ı
        // sonsuza dek bekletecek bir animasyon istemiyoruz).
        return const SizedBox.shrink();
      case SubscriptionStatus.loading:
        return const SizedBox(
          height: 420,
          child: Center(child: CircularProgressIndicator(color: _green)),
        );
      case SubscriptionStatus.ready:
        return _PaywallContent(
          controller: controller,
          onPurchase: () => _purchase(context, controller),
          onRestore: () => _restore(context, controller),
        );
      case SubscriptionStatus.unsupported:
        return _StatusCard(
          icon: Icons.devices_other_rounded,
          message: l10n.subscriptionUnsupported,
        );
      case SubscriptionStatus.missingConfiguration:
        return _StatusCard(
          icon: Icons.key_off_rounded,
          message: l10n.subscriptionMissingConfiguration,
        );
      case SubscriptionStatus.productsUnavailable:
        return _StatusCard(
          icon: Icons.inventory_2_outlined,
          message: l10n.subscriptionProductsUnavailable,
          actionLabel: l10n.subscriptionRetry,
          onAction: controller.refresh,
        );
      case SubscriptionStatus.failed:
        return _StatusCard(
          icon: Icons.cloud_off_rounded,
          message: _errorMessage(l10n, controller.lastErrorCode),
          debugDetail: kDebugMode ? controller.lastErrorDetail : null,
          actionLabel: l10n.subscriptionRetry,
          onAction: controller.refresh,
        );
    }
  }

  Future<void> _purchase(
    BuildContext context,
    SubscriptionController controller,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final result = await controller.purchaseSelected();
    if (!context.mounted) return;

    switch (result) {
      case SubscriptionActionResult.success:
        _showMessage(context, l10n.subscriptionPurchaseSuccess);
        return;
      case SubscriptionActionResult.cancelled:
        return;
      case SubscriptionActionResult.pending:
        _showMessage(context, l10n.subscriptionPaymentPending);
        return;
      case SubscriptionActionResult.noActiveEntitlement:
        _showMessage(context, l10n.subscriptionErrorGeneric);
        return;
      case SubscriptionActionResult.failed:
        _showMessage(context, _errorMessage(l10n, controller.lastErrorCode));
        return;
    }
  }

  Future<void> _restore(
    BuildContext context,
    SubscriptionController controller,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final result = await controller.restorePurchases();
    if (!context.mounted) return;

    final message = switch (result) {
      SubscriptionActionResult.success => l10n.subscriptionRestoreSuccess,
      SubscriptionActionResult.noActiveEntitlement =>
        l10n.subscriptionNothingToRestore,
      SubscriptionActionResult.pending => l10n.subscriptionPaymentPending,
      SubscriptionActionResult.cancelled => null,
      SubscriptionActionResult.failed => _errorMessage(
        l10n,
        controller.lastErrorCode,
      ),
    };
    if (message != null) _showMessage(context, message);
  }

  Future<void> _openManagement(
    BuildContext context,
    String? managementUrl,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final uri = managementUrl == null ? null : Uri.tryParse(managementUrl);
    if (uri == null ||
        !await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        _showMessage(context, l10n.subscriptionErrorGeneric);
      }
    }
  }

  static String _errorMessage(
    AppLocalizations l10n,
    PurchasesErrorCode? errorCode,
  ) {
    return switch (errorCode) {
      PurchasesErrorCode.networkError ||
      PurchasesErrorCode.offlineConnectionError =>
        l10n.subscriptionErrorNetwork,
      PurchasesErrorCode.purchaseNotAllowedError ||
      PurchasesErrorCode.insufficientPermissionsError =>
        l10n.subscriptionErrorNotAllowed,
      PurchasesErrorCode.storeProblemError ||
      PurchasesErrorCode.productNotAvailableForPurchaseError ||
      PurchasesErrorCode.productRequestTimeout => l10n.subscriptionErrorStore,
      _ => l10n.subscriptionErrorGeneric,
    };
  }

  static void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: _deepGreen,
        ),
      );
  }
}

class _PaywallContent extends StatelessWidget {
  const _PaywallContent({
    required this.controller,
    required this.onPurchase,
    required this.onRestore,
  });

  final SubscriptionController controller;
  final VoidCallback onPurchase;
  final VoidCallback onRestore;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final monthly = controller.monthlyPackage!;
    final annual = controller.annualPackage!;
    final isAnnualSelected = controller.selectedPackage == annual;

    return Column(
      children: [
        _HeroCard(l10n: l10n),
        const SizedBox(height: 18),
        _BenefitsCard(l10n: l10n),
        const SizedBox(height: 20),
        _PlanToggle(
          isAnnualSelected: isAnnualSelected,
          annualBadge: l10n.subscriptionBestValue,
          monthlyLabel: l10n.subscriptionMonthlyPlan,
          annualLabel: l10n.subscriptionAnnualPlan,
          onSelectMonthly: () => controller.selectPackage(monthly),
          onSelectAnnual: () => controller.selectPackage(annual),
        ),
        const SizedBox(height: 14),
        _PricePreviewCard(
          key: ValueKey(controller.selectedPackage?.identifier),
          priceLabel: isAnnualSelected
              ? l10n.subscriptionPerYear(annual.storeProduct.priceString)
              : l10n.subscriptionPerMonth(monthly.storeProduct.priceString),
          detail: isAnnualSelected
              ? _annualDetailLabel(l10n, controller, annual)
              : null,
          savings: isAnnualSelected && controller.annualSavingsPercent != null
              ? l10n.subscriptionSavePercent(controller.annualSavingsPercent!)
              : null,
        ),
        const SizedBox(height: 18),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: FilledButton(
            onPressed: controller.isBusy ? null : onPurchase,
            style: FilledButton.styleFrom(
              backgroundColor: _green,
              foregroundColor: _deepGreen,
              disabledBackgroundColor: _green.withValues(alpha: 0.45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: controller.isPurchasing
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: _deepGreen,
                    ),
                  )
                : Text(
                    l10n.subscriptionContinue,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 14),
        _TrustRow(l10n: l10n),
        const SizedBox(height: 22),
        _ComparisonTable(l10n: l10n),
        const SizedBox(height: 18),
        _RestoreAndLegal(controller: controller, onRestore: onRestore),
      ],
    );
  }

  static String? _annualDetailLabel(
    AppLocalizations l10n,
    SubscriptionController controller,
    Package annual,
  ) {
    final parts = <String>[];
    final perMonth = annual.storeProduct.pricePerMonthString;
    if (perMonth != null) parts.add(l10n.subscriptionPerMonth(perMonth));
    final perDay = controller.annualDailyPriceLabel;
    if (perDay != null) parts.add(l10n.subscriptionPerDay(perDay));
    if (parts.isEmpty) return null;
    return parts.join(' · ');
  }
}

/// İki ayrı yığılmış kart yerine, ay/yıl arasında kayan bir gösterge ile
/// geçiş yapan modern bir segment kontrolü.
class _PlanToggle extends StatelessWidget {
  const _PlanToggle({
    required this.isAnnualSelected,
    required this.annualBadge,
    required this.monthlyLabel,
    required this.annualLabel,
    required this.onSelectMonthly,
    required this.onSelectAnnual,
  });

  final bool isAnnualSelected;
  final String annualBadge;
  final String monthlyLabel;
  final String annualLabel;
  final VoidCallback onSelectMonthly;
  final VoidCallback onSelectAnnual;

  @override
  Widget build(BuildContext context) {
    final track = Theme.of(context).colorScheme.surfaceContainerHighest;
    final ink = Theme.of(context).colorScheme.onSurface;

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: track.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            alignment: isAnnualSelected
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: Container(
                height: 46,
                margin: const EdgeInsets.symmetric(horizontal: 1),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _PlanToggleSegment(
                  label: monthlyLabel,
                  selected: !isAnnualSelected,
                  ink: ink,
                  onTap: onSelectMonthly,
                ),
              ),
              Expanded(
                child: _PlanToggleSegment(
                  label: annualLabel,
                  badge: annualBadge,
                  selected: isAnnualSelected,
                  ink: ink,
                  onTap: onSelectAnnual,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PlanToggleSegment extends StatelessWidget {
  const _PlanToggleSegment({
    required this.label,
    required this.selected,
    required this.ink,
    required this.onTap,
    this.badge,
  });

  final String label;
  final bool selected;
  final Color ink;
  final VoidCallback onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: SizedBox(
          height: 46,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    color: selected ? ink : ink.withValues(alpha: 0.55),
                    fontSize: 13.5,
                    fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                  ),
                ),
                if (badge != null) ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: _gold.withValues(alpha: selected ? 0.25 : 0.14),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Text(
                      badge!,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF8A5A00),
                        fontSize: 7.5,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Seçili plana göre fiyatı büyük şekilde gösteren, plan değişince
/// birbirine geçiş yapan (cross-fade) tek kart.
class _PricePreviewCard extends StatelessWidget {
  const _PricePreviewCard({
    super.key,
    required this.priceLabel,
    this.detail,
    this.savings,
  });

  final String priceLabel;
  final String? detail;
  final String? savings;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 260),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SizeTransition(
          sizeFactor: animation,
          alignment: Alignment.topCenter,
          child: child,
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: _green.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _green.withValues(alpha: 0.35)),
        ),
        child: Column(
          children: [
            Text(
              priceLabel,
              style: GoogleFonts.outfit(
                color: _deepGreen,
                fontSize: 24,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.4,
              ),
            ),
            if (detail != null) ...[
              const SizedBox(height: 3),
              Text(
                detail!,
                style: GoogleFonts.inter(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 11.5,
                ),
              ),
            ],
            if (savings != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF09843C).withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  savings!,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF09843C),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _TrustRow extends StatelessWidget {
  const _TrustRow({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;
    final items = [
      (Icons.lock_outline_rounded, l10n.subscriptionTrustSecure),
      (Icons.event_repeat_rounded, l10n.subscriptionTrustCancel),
      (Icons.flash_on_rounded, l10n.subscriptionTrustInstant),
    ];
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 18,
      runSpacing: 8,
      children: [
        for (final item in items)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(item.$1, size: 14, color: _deepGreen),
              const SizedBox(width: 5),
              Text(
                item.$2,
                style: GoogleFonts.inter(
                  color: muted,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class _ComparisonTable extends StatelessWidget {
  const _ComparisonTable({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final ink = Theme.of(context).colorScheme.onSurface;
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;
    final rows = <(String, String?, String?)>[
      (
        l10n.subscriptionComparisonRowScan,
        l10n.subscriptionComparisonLimited,
        l10n.subscriptionComparisonUnlimited,
      ),
      (
        l10n.subscriptionComparisonRowChat,
        l10n.subscriptionComparisonLimited,
        l10n.subscriptionComparisonUnlimited,
      ),
      (l10n.subscriptionComparisonRowGarden, null, null),
      (l10n.subscriptionComparisonRowLeaderboard, null, null),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: _surfaceDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.subscriptionComparisonTitle,
            style: GoogleFonts.outfit(
              color: ink,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  l10n.subscriptionComparisonColumnFeature,
                  style: GoogleFonts.inter(
                    color: muted,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  l10n.subscriptionFree,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: muted,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  l10n.premium,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: _deepGreen,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          for (final row in rows) ...[
            const Divider(height: 24, color: Color(0xFFEDF2EE)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    row.$1,
                    style: GoogleFonts.inter(
                      color: ink,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                  ),
                ),
                Expanded(flex: 2, child: Center(child: _cell(row.$2))),
                Expanded(
                  flex: 2,
                  child: Center(child: _cell(row.$3, premium: true)),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _cell(String? label, {bool premium = false}) {
    if (label == null) {
      return Icon(
        Icons.check_rounded,
        size: 17,
        color: premium ? _green : const Color(0xFF9AA79F),
      );
    }
    return Text(
      label,
      textAlign: TextAlign.center,
      style: GoogleFonts.inter(
        color: premium ? _deepGreen : const Color(0xFF9AA79F),
        fontSize: 10.5,
        fontWeight: premium ? FontWeight.w800 : FontWeight.w600,
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 26),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0D3926), Color(0xFF19583A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            right: -40,
            top: -40,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [_gold.withValues(alpha: 0.22), Colors.transparent],
                ),
              ),
            ),
          ),
          Positioned(
            right: -22,
            bottom: -28,
            child: Icon(
              Icons.spa_rounded,
              size: 150,
              color: _green.withValues(alpha: 0.12),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.auto_awesome_rounded,
                    color: _gold,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n.subscriptionHeroEyebrow,
                    style: GoogleFonts.inter(
                      color: _gold,
                      fontSize: 11,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                l10n.subscriptionHeroTitle,
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 29,
                  height: 1.08,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.6,
                ),
              ),
              const SizedBox(height: 10),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 390),
                child: Text(
                  l10n.subscriptionHeroSubtitle,
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.72),
                    fontSize: 13,
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BenefitsCard extends StatelessWidget {
  const _BenefitsCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: _surfaceDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.subscriptionBenefitsTitle,
            style: GoogleFonts.outfit(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 15),
          _BenefitRow(
            icon: Icons.document_scanner_outlined,
            label: l10n.subscriptionBenefitIdentification,
          ),
          const SizedBox(height: 12),
          _BenefitRow(
            icon: Icons.event_available_rounded,
            label: l10n.subscriptionBenefitCare,
          ),
          const SizedBox(height: 12),
          _BenefitRow(
            icon: Icons.psychology_alt_outlined,
            label: l10n.subscriptionBenefitInsights,
          ),
        ],
      ),
    );
  }
}

class _BenefitRow extends StatelessWidget {
  const _BenefitRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: _green.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: _deepGreen, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 13,
              height: 1.35,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Icon(Icons.check_circle_rounded, color: _green, size: 19),
      ],
    );
  }
}

class _RestoreAndLegal extends StatelessWidget {
  const _RestoreAndLegal({required this.controller, required this.onRestore});

  final SubscriptionController controller;
  final VoidCallback onRestore;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        TextButton(
          onPressed: controller.isBusy ? null : onRestore,
          child: Text(
            controller.isRestoring
                ? l10n.subscriptionRestoring
                : l10n.subscriptionRestorePurchases,
            style: GoogleFonts.inter(
              color: _deepGreen,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            l10n.subscriptionAutoRenewDisclosure,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 9.5,
              height: 1.45,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          children: [
            _LegalLink(
              label: l10n.subscriptionTermsLink,
              destination: _LegalDestination.terms,
            ),
            Text(
              '•',
              style: GoogleFonts.inter(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            _LegalLink(
              label: l10n.subscriptionPrivacyLink,
              destination: _LegalDestination.privacy,
            ),
          ],
        ),
      ],
    );
  }
}

enum _LegalDestination { terms, privacy }

class _LegalLink extends StatelessWidget {
  const _LegalLink({required this.label, required this.destination});

  final String label;
  final _LegalDestination destination;

  Future<void> _open(BuildContext context) async {
    if (destination == _LegalDestination.terms) {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const TermsPage()),
      );
      return;
    }

    final uri = Uri.parse(LegalConfig.privacyUrl);
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    // Tarayıcı açılamazsa kullanıcı yine de metne erişebilsin.
    if (!opened && context.mounted) {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const TermsPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _open(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: _deepGreen,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}

class _ActiveSubscriptionContent extends StatelessWidget {
  const _ActiveSubscriptionContent({
    required this.controller,
    required this.onManage,
    required this.onRestore,
  });

  final SubscriptionController controller;
  final VoidCallback onManage;
  final VoidCallback onRestore;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final entitlement = controller.premiumEntitlement;
    final expirationDate = controller.expirationDate;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final formattedDate = expirationDate == null
        ? null
        : DateFormat.yMMMd(locale).format(expirationDate);

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(26),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF0C3A25), Color(0xFF187046)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: _green.withValues(alpha: 0.17),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.workspace_premium_rounded,
                  color: _gold,
                  size: 34,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.subscriptionActiveTitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.subscriptionActiveSubtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 12,
                ),
              ),
              if (formattedDate != null) ...[
                const SizedBox(height: 13),
                Text(
                  entitlement?.willRenew ?? false
                      ? l10n.subscriptionRenewsOn(formattedDate)
                      : l10n.subscriptionExpiresOn(formattedDate),
                  style: GoogleFonts.inter(
                    color: _green,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 18),
        _BenefitsCard(l10n: l10n),
        if (controller.managementUrl != null) ...[
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: FilledButton.tonalIcon(
              onPressed: onManage,
              icon: const Icon(Icons.open_in_new_rounded),
              label: Text(l10n.subscriptionManage),
              style: FilledButton.styleFrom(
                backgroundColor: _deepGreen,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
        ],
        _RestoreAndLegal(controller: controller, onRestore: onRestore),
      ],
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.icon,
    required this.message,
    this.debugDetail,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String message;
  final String? debugDetail;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.all(28),
      decoration: _surfaceDecoration(context),
      child: Column(
        children: [
          Icon(icon, size: 46, color: _deepGreen),
          const SizedBox(height: 18),
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Theme.of(context).colorScheme.onSurface,
              height: 1.5,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (debugDetail != null && debugDetail!.trim().isNotEmpty) ...[
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.withValues(alpha: 0.25)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DEBUG (yalnızca geliştirme derlemesinde görünür)',
                    style: GoogleFonts.inter(
                      color: Colors.red.shade700,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  SelectableText(
                    debugDetail!,
                    style: GoogleFonts.inter(
                      color: Colors.red.shade700,
                      fontSize: 11,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: 20),
            FilledButton(
              onPressed: onAction,
              style: FilledButton.styleFrom(backgroundColor: _deepGreen),
              child: Text(actionLabel!),
            ),
          ],
        ],
      ),
    );
  }
}

BoxDecoration _surfaceDecoration(BuildContext context) {
  return BoxDecoration(
    color: Theme.of(context).colorScheme.surface,
    borderRadius: BorderRadius.circular(22),
    boxShadow: [
      BoxShadow(
        color: _deepGreen.withValues(alpha: 0.06),
        blurRadius: 22,
        offset: const Offset(0, 10),
      ),
    ],
  );
}
