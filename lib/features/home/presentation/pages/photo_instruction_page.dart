import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:botaniq/l10n/app_localizations.dart';

import 'plant_scanner_page.dart';

class PhotoInstructionPage extends StatelessWidget {
  const PhotoInstructionPage({super.key});

  final Color _accentGreen = const Color(0xFF86D5A6); // Match new theme
  final Color _lightBg = const Color(0xFFF9FAF9);
  final Color _cardBg = Colors.white;
  final Color _primaryText = const Color(0xFF2C3E35);
  final Color _textSecondary = const Color(0xFF8B9E93);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: _lightBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      _buildHeroIllustration(),
                      const SizedBox(height: 40),
                      Text(
                        l10n.photoWholeSpecimen,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          color: _primaryText,
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.photoWholeSpecimenSubtitle,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: _textSecondary,
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 48),
                      Row(
                        children: [
                          Expanded(
                            child: _buildExampleCard(
                              imagePath:
                                  'https://images.unsplash.com/photo-1485955900006-10f4d324d411?auto=format&fit=crop&q=80&w=400',
                              isCorrect: true,
                              label: l10n.photoCorrect,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildExampleCard(
                              imagePath:
                                  'https://images.unsplash.com/photo-1601985705806-5b9a71f6004f?auto=format&fit=crop&q=80&w=400',
                              isCorrect: false,
                              label: l10n.photoTooClose,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ), // Spacer before bottom action area
                    ],
                  ),
                ),
              ),
            ),
            _buildBottomAction(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _cardBg,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFCBD5E1).withOpacity(0.04 * 4),
                    blurRadius: 16,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.close_rounded,
                color: Color(0xFF3B4D43),
                size: 22,
              ),
            ),
          ),
          Text(
            AppLocalizations.of(context)!.photoInstructions,
            style: GoogleFonts.outfit(
              color: _primaryText,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 44), // Placeholder to balance the row
        ],
      ),
    );
  }

  Widget _buildHeroIllustration() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer decorative circle
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            color: _accentGreen.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
        ),
        // Middle decorative circle
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: _accentGreen.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
        ),
        // Inner white circle containing the icon
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: _cardBg,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: _accentGreen.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.camera_alt_rounded,
              size: 36,
              color: _accentGreen,
            ),
          ),
        ),
        // Floating sparkles
        Positioned(
          top: 10,
          right: 20,
          child: Icon(
            Icons.star_rounded,
            color: const Color(0xFFFCD34D),
            size: 24,
          ),
        ),
        Positioned(
          bottom: 20,
          left: 10,
          child: Icon(
            Icons.star_rounded,
            color: const Color(0xFFFCD34D),
            size: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildExampleCard({
    required String imagePath,
    required bool isCorrect,
    required String label,
  }) {
    final statusColor = isCorrect
        ? const Color(0xFF4FA976)
        : const Color(0xFFE96565);
    final statusBgColor = isCorrect
        ? const Color(0xFF4FA976).withOpacity(0.15)
        : const Color(0xFFE96565).withOpacity(0.15);
    final iconData = isCorrect ? Icons.check_rounded : Icons.close_rounded;

    return Container(
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFCBD5E1).withOpacity(0.04 * 4),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(imagePath, height: 140, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 12.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(iconData, color: statusColor, size: 16),
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    color: _primaryText,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(color: _lightBg),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PlantScannerPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _primaryText,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            shadowColor: _primaryText.withOpacity(0.4),
          ),
          child: Text(
            AppLocalizations.of(context)!.photoOpenCamera,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
