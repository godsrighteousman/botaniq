import 'package:botaniq/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../profile/presentation/pages/terms_page.dart';
import '../controllers/subscription_controller.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  static const _background = Color(0xFFF4F8F5);
  static const _surface = Colors.white;
  static const _ink = Color(0xFF173425);
  static const _muted = Color(0xFF718278);
  static const _green = Color(0xFF0ED761);
  static const _deepGreen = Color(0xFF123E2A);
  static const _gold = Color(0xFFF5B74A);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<SubscriptionController>();

    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: Column(
          children: [
            _Header(title: l10n.subscriptionPageTitle),
            Expanded(
              child: RefreshIndicator(
                color: _green,
                onRefresh: controller.refresh,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 620),
                      child: _buildContent(context, controller, l10n),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
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
      case SubscriptionStatus.loading:
        return const SizedBox(
          height: 520,
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

class _Header extends StatelessWidget {
  const _Header({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 20, 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.maybePop(context),
            icon: const Icon(Icons.close_rounded, color: SubscriptionPage._ink),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                color: SubscriptionPage._ink,
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
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

    return Column(
      children: [
        _HeroCard(l10n: l10n),
        const SizedBox(height: 18),
        _BenefitsCard(l10n: l10n),
        const SizedBox(height: 18),
        _PlanCard(
          title: l10n.subscriptionAnnualPlan,
          priceLabel: l10n.subscriptionPerYear(annual.storeProduct.priceString),
          detail: annual.storeProduct.pricePerMonthString == null
              ? null
              : l10n.subscriptionPerMonth(
                  annual.storeProduct.pricePerMonthString!,
                ),
          selected: controller.selectedPackage == annual,
          badge: l10n.subscriptionBestValue,
          savings: controller.annualSavingsPercent == null
              ? null
              : l10n.subscriptionSavePercent(controller.annualSavingsPercent!),
          onTap: () => controller.selectPackage(annual),
        ),
        const SizedBox(height: 12),
        _PlanCard(
          title: l10n.subscriptionMonthlyPlan,
          priceLabel: l10n.subscriptionPerMonth(
            monthly.storeProduct.priceString,
          ),
          selected: controller.selectedPackage == monthly,
          onTap: () => controller.selectPackage(monthly),
        ),
        const SizedBox(height: 18),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: FilledButton(
            onPressed: controller.isBusy ? null : onPurchase,
            style: FilledButton.styleFrom(
              backgroundColor: SubscriptionPage._green,
              foregroundColor: SubscriptionPage._deepGreen,
              disabledBackgroundColor: SubscriptionPage._green.withValues(
                alpha: 0.45,
              ),
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
                      color: SubscriptionPage._deepGreen,
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
        _RestoreAndLegal(controller: controller, onRestore: onRestore),
      ],
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
      child: Stack(
        children: [
          Positioned(
            right: -22,
            bottom: -28,
            child: Icon(
              Icons.spa_rounded,
              size: 150,
              color: SubscriptionPage._green.withValues(alpha: 0.12),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.auto_awesome_rounded,
                    color: SubscriptionPage._gold,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n.subscriptionHeroEyebrow,
                    style: GoogleFonts.inter(
                      color: SubscriptionPage._gold,
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
      decoration: _surfaceDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.subscriptionBenefitsTitle,
            style: GoogleFonts.outfit(
              color: SubscriptionPage._ink,
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
            color: SubscriptionPage._green.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: SubscriptionPage._deepGreen, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: SubscriptionPage._ink,
              fontSize: 13,
              height: 1.35,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Icon(
          Icons.check_circle_rounded,
          color: SubscriptionPage._green,
          size: 19,
        ),
      ],
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.title,
    required this.priceLabel,
    required this.selected,
    required this.onTap,
    this.detail,
    this.badge,
    this.savings,
  });

  final String title;
  final String priceLabel;
  final String? detail;
  final String? badge;
  final String? savings;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? SubscriptionPage._green.withValues(alpha: 0.07)
          : SubscriptionPage._surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected
                  ? SubscriptionPage._green
                  : const Color(0xFFE1E9E4),
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 23,
                height: 23,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected
                        ? SubscriptionPage._green
                        : const Color(0xFFAEBAB3),
                    width: 2,
                  ),
                  color: selected
                      ? SubscriptionPage._green
                      : Colors.transparent,
                ),
                child: selected
                    ? const Icon(
                        Icons.check_rounded,
                        size: 15,
                        color: SubscriptionPage._deepGreen,
                      )
                    : null,
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.inter(
                            color: SubscriptionPage._ink,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        if (badge != null) ...[
                          const SizedBox(width: 8),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: SubscriptionPage._gold.withValues(
                                  alpha: 0.2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                badge!,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF8A5A00),
                                  fontSize: 8,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (detail != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        detail!,
                        style: GoogleFonts.inter(
                          color: SubscriptionPage._muted,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    priceLabel,
                    style: GoogleFonts.inter(
                      color: SubscriptionPage._ink,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  if (savings != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      savings!,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF09843C),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
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
              color: SubscriptionPage._deepGreen,
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
              color: SubscriptionPage._muted,
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
            _LegalLink(label: l10n.subscriptionTermsLink),
            Text('•', style: GoogleFonts.inter(color: SubscriptionPage._muted)),
            _LegalLink(label: l10n.subscriptionPrivacyLink),
          ],
        ),
      ],
    );
  }
}

class _LegalLink extends StatelessWidget {
  const _LegalLink({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const TermsPage()),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: SubscriptionPage._deepGreen,
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
                  color: SubscriptionPage._green.withValues(alpha: 0.17),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.workspace_premium_rounded,
                  color: SubscriptionPage._gold,
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
                    color: SubscriptionPage._green,
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
                backgroundColor: SubscriptionPage._deepGreen,
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
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 72),
      padding: const EdgeInsets.all(28),
      decoration: _surfaceDecoration(),
      child: Column(
        children: [
          Icon(icon, size: 46, color: SubscriptionPage._deepGreen),
          const SizedBox(height: 18),
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: SubscriptionPage._ink,
              height: 1.5,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: 20),
            FilledButton(
              onPressed: onAction,
              style: FilledButton.styleFrom(
                backgroundColor: SubscriptionPage._deepGreen,
              ),
              child: Text(actionLabel!),
            ),
          ],
        ],
      ),
    );
  }
}

BoxDecoration _surfaceDecoration() {
  return BoxDecoration(
    color: SubscriptionPage._surface,
    borderRadius: BorderRadius.circular(22),
    boxShadow: [
      BoxShadow(
        color: SubscriptionPage._deepGreen.withValues(alpha: 0.06),
        blurRadius: 22,
        offset: const Offset(0, 10),
      ),
    ],
  );
}
