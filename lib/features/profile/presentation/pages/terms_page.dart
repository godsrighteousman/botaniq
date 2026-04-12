import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  final Color _lightBg = const Color(0xFFF9FAF9);
  final Color _primaryText = const Color(0xFF2C3E35);
  final Color _textSecondary = const Color(0xFF6E6E73);

  @override
  Widget build(BuildContext context) {
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
          'Terms & Policies',
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
                'Last updated: Oct 2026',
                style: GoogleFonts.inter(
                  color: _textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('1. Terms of Use'),
              _buildParagraph(
                'By accessing or using the Botaniq application, you agree to be bound by these Terms of Use and all applicable laws and regulations. If you do not agree with any part of these terms, you may not use our services.',
              ),
              _buildSectionTitle('2. User Privacy'),
              _buildParagraph(
                'Your privacy is deeply important to us. We only collect the minimal personal data necessary to provide you with tailored plant care schedules. We do not sell your personal data to third parties. For more information, please read our detailed Privacy Policy available on our website.',
              ),
              _buildSectionTitle('3. Plant Data'),
              _buildParagraph(
                'The plant care instructions, species identification, and diagnosis information provided by the app are for informational purposes only. While we strive to provide highly accurate AI-driven results, we cannot guarantee absolute correctness, and we are not liable for any damaged plants.',
              ),
              _buildSectionTitle('4. Premium Subscriptions'),
              _buildParagraph(
                'Botaniq Premium offers advanced identification, unlimited plant tracking, and specialized disease diagnosis. Subscriptions are billed on a recurring basis as per your app store agreement. You may cancel at any time, but no refunds will be issued for partial periods.',
              ),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  'Enjoy peace of mind and happier plants.',
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
