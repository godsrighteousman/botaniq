import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1542838132-92c53300491e?q=80&w=3174&auto=format&fit=crop',
              fit: BoxFit.cover,
            ),
          ),

          // Gradient Overlay to ensure text readability
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.95),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.3, 0.65, 1.0],
                ),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row (Logo and Help Button)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.eco,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'BOTANIQ',
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.help_outline,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // AI Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.badgeBackground,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.verified,
                          color: AppColors.primary,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'AI-POWERED CARE',
                          style: GoogleFonts.inter(
                            color: AppColors.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Title Statement
                  Text.rich(
                    TextSpan(
                      text: 'Take Care\nof Your Plants\n',
                      style: GoogleFonts.outfit(
                        fontSize: 48,
                        height: 1.1,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1,
                      ),
                      children: const [
                        TextSpan(
                          text: 'Like a Pro',
                          style: TextStyle(color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Subtitle
                  Text(
                    'Smart schedules and instant\nidentification for your urban\njungle.',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: AppColors.textMain.withOpacity(0.9),
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Feature Cards Row
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        _FeatureChip(
                          icon: Icons.document_scanner_outlined,
                          label: 'AI Scan',
                          iconColor: AppColors.primary,
                        ),
                        SizedBox(width: 12),
                        _FeatureChip(
                          icon: Icons.water_drop_outlined,
                          label: 'Smart Water',
                          iconColor: AppColors.primary,
                        ),
                        SizedBox(width: 12),
                        _FeatureChip(
                          icon: Icons.wb_sunny_outlined,
                          label: 'Light Tracking',
                          iconColor: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),

                  // CTA Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Navigate to Main Tab layout / Login
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Start Your Journey',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Social Proof (Avatars)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _AvatarStack(),
                      const SizedBox(width: 12),
                      Text(
                        'Join 50,000+ plant parents',
                        style: GoogleFonts.inter(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Terms & Privacy
                  Center(
                    child: Text.rich(
                      const TextSpan(
                        text: 'BY CONTINUING, YOU AGREE TO OUR ',
                        children: [
                          TextSpan(
                            text: 'TERMS OF\nSERVICE',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: ' & '),
                          TextSpan(
                            text: 'PRIVACY POLICY',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: AppColors.textSecondary.withOpacity(0.6),
                        fontSize: 10,
                        height: 1.5,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;

  const _FeatureChip({
    required this.icon,
    required this.label,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.chipBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 76,
      height: 28,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: _buildAvatar('https://i.pravatar.cc/100?img=15'),
          ),
          Positioned(
            left: 24,
            child: _buildAvatar('https://i.pravatar.cc/100?img=22'),
          ),
          Positioned(
            left: 48,
            child: _buildAvatar('https://i.pravatar.cc/100?img=5'),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(String url) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.darkBackground, width: 2),
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
      ),
    );
  }
}
