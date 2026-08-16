import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:botaniq/l10n/app_localizations.dart';

import '../pages/photo_instruction_page.dart';

/// Hızlı eylem kartı — bitki tarama (scan plant) CTA'sı.
/// Gradient arka plan ve büyük ikon ile premium görünüm.
class QuickActionsCard extends StatelessWidget {
  const QuickActionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            l10n.homeQuickActions,
            style: GoogleFonts.outfit(
              color: const Color(0xFF1B3A2A),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 14),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PhotoInstructionPage(),
              ),
            );
          },
          child: Container(
            height: 130,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF0ED761), Color(0xFF0ABF55)],
              ),
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0ED761).withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Arka plan dekoratif ikon
                Positioned(
                  right: -12,
                  bottom: -12,
                  child: Icon(
                    Icons.document_scanner_rounded,
                    size: 100,
                    color: Colors.white.withValues(alpha: 0.12),
                  ),
                ),
                // İçerik
                Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.document_scanner_rounded,
                          color: Color(0xFF0ED761),
                          size: 22,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        l10n.scanPlant,
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.homeIdentifyCamera,
                        style: GoogleFonts.inter(
                          color: Colors.white.withValues(alpha: 0.8),
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
        ),
      ],
    );
  }
}
