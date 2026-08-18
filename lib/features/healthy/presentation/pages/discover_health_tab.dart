import 'package:botaniq/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ai_chat_page.dart';

/// Klinik > Keşfet sekmesi.
///
/// Bilinçli olarak tek bir amaca odaklanır: kullanıcının önceden bir bitki
/// seçmesine gerek kalmadan AI Bitki Doktoru'yla sohbete başlayabileceği
/// tam sayfa bir giriş noktası. Önceki "İpuçları / Haftanın Bitkisi" içerik
/// listesi kaldırıldı; bu ekranın tek görevi sohbeti başlatmak.
class DiscoverHealthTab extends StatelessWidget {
  const DiscoverHealthTab({super.key});

  static const _green = Color(0xFF4FA976);
  static const _greenDeep = Color(0xFF2E6B4F);

  void _openChat(BuildContext context, {String? initialPrompt}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AiChatPage(
          isGeneralChat: true,
          initialPrompt: initialPrompt,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final ink = theme.colorScheme.onSurface;
    final muted = theme.colorScheme.onSurfaceVariant;

    final quickTopics = <String>[
      l10n.chatQuestionYellowing,
      l10n.chatQuestionWatering,
      l10n.chatQuestionFertilizer,
      l10n.chatQuestionTreatment,
    ];

    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 92,
                height: 92,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [_green, _greenDeep],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _green.withValues(alpha: 0.28),
                      blurRadius: 28,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.eco_rounded,
                  color: Colors.white,
                  size: 44,
                ),
              ),
              const SizedBox(height: 28),
              Text(
                l10n.healthyGeneralChatTitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  color: ink,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                l10n.healthyGeneralChatSubtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: muted,
                  fontSize: 14.5,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => _openChat(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _green,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.chat_bubble_rounded, size: 20),
                      const SizedBox(width: 10),
                      Text(
                        l10n.chatStartConversation,
                        style: GoogleFonts.inter(
                          fontSize: 15.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 36),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  l10n.chatQuickTopics,
                  style: GoogleFonts.outfit(
                    color: ink,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (final topic in quickTopics)
                    _TopicChip(
                      label: topic,
                      ink: ink,
                      onTap: () => _openChat(context, initialPrompt: topic),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopicChip extends StatelessWidget {
  const _TopicChip({
    required this.label,
    required this.ink,
    required this.onTap,
  });

  final String label;
  final Color ink;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: ink,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
