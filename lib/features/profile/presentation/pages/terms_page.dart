import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:botaniq/l10n/app_localizations.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final lightBg = theme.scaffoldBackgroundColor;
    final primaryText = theme.colorScheme.onSurface;
    final textSecondary = theme.colorScheme.onSurfaceVariant;
    return Scaffold(
      backgroundColor: lightBg,
      appBar: AppBar(
        backgroundColor: lightBg,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: primaryText,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.termsTitle,
          style: GoogleFonts.outfit(
            color: primaryText,
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
                  color: textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle(l10n.termsUseTitle, primaryText),
              _buildParagraph(l10n.termsUseBody, textSecondary),
              _buildSectionTitle(l10n.termsPrivacyTitle, primaryText),
              _buildParagraph(l10n.termsPrivacyBody, textSecondary),
              _buildSectionTitle(l10n.termsContentTitle, primaryText),
              _buildParagraph(l10n.termsContentBody, textSecondary),
              _buildSectionTitle(l10n.termsRetentionTitle, primaryText),
              _buildParagraph(l10n.termsRetentionBody, textSecondary),
              _buildSectionTitle(l10n.termsPlantTitle, primaryText),
              _buildParagraph(l10n.termsPlantBody, textSecondary),
              _buildSectionTitle(l10n.termsLiabilityTitle, primaryText),
              _buildParagraph(l10n.termsLiabilityBody, textSecondary),
              _buildSectionTitle(l10n.termsPremiumTitle, primaryText),
              _buildParagraph(l10n.termsPremiumBody, textSecondary),
              _buildSectionTitle(l10n.termsLawTitle, primaryText),
              _buildParagraph(l10n.termsLawBody, textSecondary),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  l10n.termsClosing,
                  style: GoogleFonts.inter(
                    color: primaryText,
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

  Widget _buildSectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: GoogleFonts.outfit(
          color: color,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildParagraph(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Text(
        text,
        style: GoogleFonts.inter(color: color, fontSize: 15, height: 1.6),
      ),
    );
  }
}
