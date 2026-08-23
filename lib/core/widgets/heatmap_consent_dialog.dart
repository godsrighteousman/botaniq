import 'package:botaniq/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/heatmap_service.dart';

/// Kullanıcıya, uygulamaya ilk girişte — ve yalnızca bir kez — etkileşim
/// ısı haritası veri toplamaya izin verip vermeyeceğini açıkça sorar.
///
/// Daha önce sorulduysa hiçbir şey yapmaz (bir daha asla otomatik açılmaz).
/// Kullanıcı burada ne seçerse seçsin tercihini istediği an Ayarlar'daki
/// anahtardan değiştirebilir — bu diyalog sadece ilk, açık rızayı alır.
Future<void> maybeShowHeatmapConsentDialog(BuildContext context) async {
  if (await HeatmapService.instance.hasAskedConsent) return;
  if (!context.mounted) return;

  final l10n = AppLocalizations.of(context)!;
  final theme = Theme.of(context);

  final allowed = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) => AlertDialog(
      backgroundColor: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      icon: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0xFF0ED761).withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.grid_on_rounded,
          color: Color(0xFF0A7143),
          size: 24,
        ),
      ),
      title: Text(
        l10n.heatmapConsentTitle,
        textAlign: TextAlign.center,
        style: GoogleFonts.outfit(
          color: theme.colorScheme.onSurface,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: Text(
        l10n.heatmapConsentBody,
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          color: theme.colorScheme.onSurfaceVariant,
          fontSize: 13,
          height: 1.5,
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 50,
              child: FilledButton(
                onPressed: () => Navigator.pop(dialogContext, true),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF0ED761),
                  foregroundColor: const Color(0xFF0A7143),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  l10n.heatmapConsentAllow,
                  style: GoogleFonts.inter(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(
                l10n.heatmapConsentDecline,
                style: GoogleFonts.inter(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  await HeatmapService.instance.markConsentAsked();
  await HeatmapService.instance.setOptIn(allowed ?? false);
}
