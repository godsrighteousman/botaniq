import 'package:botaniq/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../controllers/subscription_controller.dart';
import '../pages/subscription_page.dart';

/// Ücretsiz AI hakkı bittiğinde gösterilen ödeme duvarı önerisi.
///
/// Tasarım kasıtlı olarak birkaç davranış bilimi ilkesini kullanır:
/// - **Karşılıklılık (reciprocity):** üstteki etiket önce verilen değeri
///   ("2 ücretsiz analiz") hatırlatır, isteği ondan sonra yapar.
/// - **Kayıptan kaçınma (loss aversion) + somutluk:** jenerik "Premium'a
///   geç" yerine, kullanıcının az önce ne yapmaya çalıştığını (varsa
///   [contextLabel]) adıyla anar.
/// - **Çapalama (anchoring):** gerçek mağaza fiyatlarından hesaplanan
///   yıllık tasarruf yüzdesi rozet olarak gösterilir — uydurma bir rakam
///   değil, `SubscriptionController.annualSavingsPercent`'ten gelir.
///
/// Bilinçli olarak KULLANILMAYAN teknikler: sahte geri sayım/aciliyet,
/// uydurma sosyal kanıt sayıları, "vazgeç" seçeneğini gizlemek/küçültmek —
/// bunlar App Store/Play Store kurallarına aykırı ve aldatıcı karanlık
/// desenlerdir.
Future<void> showPaywallPrompt(BuildContext context, {String? contextLabel}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) => _PaywallPrompt(contextLabel: contextLabel),
  );
}

class _PaywallPrompt extends StatelessWidget {
  const _PaywallPrompt({this.contextLabel});

  final String? contextLabel;

  static const _green = Color(0xFF0ED761);
  static const _deepGreen = Color(0xFF0A7143);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final ink = theme.colorScheme.onSurface;
    final muted = theme.colorScheme.onSurfaceVariant;
    final controller = context.watch<SubscriptionController>();
    final savings = controller.annualSavingsPercent;
    final annualPrice = controller.annualPackage?.storeProduct.priceString;

    return SafeArea(
      top: false,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        padding: const EdgeInsets.fromLTRB(28, 36, 28, 24),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 48,
              offset: const Offset(0, 14),
            ),
          ],
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [_green, _deepGreen],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _green.withValues(alpha: 0.3),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.eco_rounded,
                    color: Colors.white,
                    size: 34,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              // Karşılıklılık: önce verilen değeri hatırlat.
              Center(
                child: Text(
                  l10n.paywallEyebrow,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: _deepGreen,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.paywallTitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  color: ink,
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                (contextLabel != null && contextLabel!.trim().isNotEmpty)
                    ? l10n.paywallBodyWithContext(contextLabel!.trim())
                    : l10n.paywallBodyGeneric,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: muted,
                  fontSize: 14.5,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 28),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.4,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _BenefitRow(
                      icon: Icons.search_rounded,
                      label: l10n.paywallBenefitScan,
                      ink: ink,
                    ),
                    const SizedBox(height: 14),
                    _BenefitRow(
                      icon: Icons.chat_bubble_rounded,
                      label: l10n.paywallBenefitChat,
                      ink: ink,
                    ),
                    const SizedBox(height: 14),
                    _BenefitRow(
                      icon: Icons.notifications_active_rounded,
                      label: l10n.paywallBenefitReminders,
                      ink: ink,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              if (annualPrice != null) ...[
                Center(
                  child: Text(
                    l10n.subscriptionPerYear(annualPrice),
                    style: GoogleFonts.outfit(
                      color: ink,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
              if (savings != null && savings > 0) ...[
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _green.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      l10n.paywallAnnualBadge(savings),
                      style: GoogleFonts.inter(
                        color: _deepGreen,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SubscriptionPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _green,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    l10n.paywallCta,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  l10n.paywallDismiss,
                  style: GoogleFonts.inter(
                    color: muted,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}

class _BenefitRow extends StatelessWidget {
  const _BenefitRow({required this.icon, required this.label, required this.ink});

  final IconData icon;
  final String label;
  final Color ink;

  static const _green = Color(0xFF0ED761);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: _green.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFF0A7143), size: 15),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: ink,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
