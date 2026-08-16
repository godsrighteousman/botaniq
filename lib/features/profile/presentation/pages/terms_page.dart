import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:botaniq/l10n/app_localizations.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  final Color _lightBg = const Color(0xFFF9FAF9);
  final Color _primaryText = const Color(0xFF2C3E35);
  final Color _textSecondary = const Color(0xFF6E6E73);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: _lightBg,
      appBar: AppBar(
        backgroundColor: _lightBg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF2C3E35),
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.termsTitle,
          style: GoogleFonts.outfit(
            color: const Color(0xFF2C3E35),
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.termsUpdated,
                style: GoogleFonts.inter(
                  color: _textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle(l10n.termsUseTitle),
              _buildParagraph(l10n.termsUseBody),
              _buildSectionTitle(l10n.termsPrivacyTitle),
              _buildParagraph(l10n.termsPrivacyBody),
              _buildSectionTitle(l10n.termsContentTitle),
              _buildParagraph(l10n.termsContentBody),
              _buildSectionTitle(l10n.termsRetentionTitle),
              _buildParagraph(l10n.termsRetentionBody),
              _buildSectionTitle(l10n.termsPlantTitle),
              _buildParagraph(l10n.termsPlantBody),
              _buildSectionTitle(l10n.termsLiabilityTitle),
              _buildParagraph(l10n.termsLiabilityBody),
              _buildSectionTitle(l10n.termsPremiumTitle),
              _buildParagraph(l10n.termsPremiumBody),
              _buildSectionTitle(l10n.termsLawTitle),
              _buildParagraph(l10n.termsLawBody),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  l10n.termsClosing,
                  style: GoogleFonts.inter(
                    color: _primaryText,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: GoogleFonts.outfit(
          color: _primaryText,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: _textSecondary,
          fontSize: 15,
          height: 1.6,
        ),
      ),
    );
  }
}
