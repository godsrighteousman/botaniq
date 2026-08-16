import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:botaniq/l10n/app_localizations.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../auth/presentation/pages/login_options_page.dart';
import '../../../localization/presentation/widgets/language_picker_sheet.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Map<String, dynamic>> _onboardingData(AppLocalizations l10n) => [
    {
      'title': l10n.onboardingOneTitle,
      'highlight': l10n.onboardingOneHighlight,
      'subtitle': l10n.onboardingOneSubtitle,
      'image': 'assets/images/onboarding_1.png',
      'badge': l10n.onboardingOneBadge,
      'features': [
        {
          'icon': Icons.document_scanner_outlined,
          'label': l10n.onboardingAiScan,
        },
        {'icon': Icons.water_drop_outlined, 'label': l10n.onboardingSmartWater},
        {
          'icon': Icons.wb_sunny_outlined,
          'label': l10n.onboardingLightTracking,
        },
      ],
    },
    {
      'title': l10n.onboardingTwoTitle,
      'highlight': l10n.onboardingTwoHighlight,
      'subtitle': l10n.onboardingTwoSubtitle,
      'image': 'assets/images/onboarding_2.png',
      'badge': l10n.onboardingTwoBadge,
      'features': [
        {'icon': Icons.camera_alt_outlined, 'label': l10n.onboardingSnapPhoto},
        {'icon': Icons.search_outlined, 'label': l10n.onboardingAccurateResult},
        {
          'icon': Icons.library_books_outlined,
          'label': l10n.onboardingPlantWiki,
        },
      ],
    },
    {
      'title': l10n.onboardingThreeTitle,
      'highlight': l10n.onboardingThreeHighlight,
      'subtitle': l10n.onboardingThreeSubtitle,
      'image': 'assets/images/onboarding_3.png',
      'badge': l10n.onboardingThreeBadge,
      'features': [
        {
          'icon': Icons.notifications_active_outlined,
          'label': l10n.onboardingReminders,
        },
        {
          'icon': Icons.thermostat_outlined,
          'label': l10n.onboardingClimateData,
        },
        {'icon': Icons.eco_outlined, 'label': l10n.onboardingHealthyGrowth},
      ],
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    final pageCount = _onboardingData(AppLocalizations.of(context)!).length;
    if (_currentPage < pageCount - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _openLoginOptions();
    }
  }

  void _openLoginOptions() {
    // Keep the root auth gate in the navigator. Social/email sign-in pages
    // return to the first route after creating a session; replacing this route
    // would leave LoginOptionsPage as the root even though auth succeeded.
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginOptionsPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final onboardingData = _onboardingData(l10n);
    final isCompact = MediaQuery.sizeOf(context).height < 740;
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Stack(
        children: [
          // Main PageView for looping backgrounds and texts
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: onboardingData.length,
            itemBuilder: (context, index) {
              final data = onboardingData[index];
              return _buildPageContent(data, isCompact: isCompact);
            },
          ),

          // Top Row (Logo and Help Button) - Static over the pages
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(11),
                          child: Image.asset(
                            'assets/images/botaniq_app_icon_v2.png',
                            width: 38,
                            height: 38,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            'BOTANIQ',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        tooltip: l10n.selectLanguage,
                        onPressed: () async {
                          await showAndApplyLanguagePicker(context);
                        },
                        style: IconButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.white.withValues(alpha: 0.12),
                          minimumSize: const Size.square(44),
                        ),
                        icon: const Icon(Icons.translate_rounded, size: 20),
                      ),
                      const SizedBox(width: 4),
                      TextButton(
                        onPressed: _openLoginOptions,
                        child: Text(
                          l10n.skip,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Bottom Controls (Dots, Button, Social Proof)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(24, 0, 24, isCompact ? 22 : 38),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withValues(alpha: 0.0),
                    Colors.black.withValues(alpha: 0.8),
                    Colors.black.withValues(alpha: 1.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Page Indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        onboardingData.length,
                        (index) => GestureDetector(
                          onTap: () => _pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 280),
                            curve: Curves.easeOutCubic,
                          ),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 240),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: _currentPage == index ? 28 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _currentPage == index
                                  ? AppColors.primary
                                  : Colors.white.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: isCompact ? 18 : 26),

                    // CTA Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _nextPage,
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
                              _currentPage == onboardingData.length - 1
                                  ? l10n.getStarted
                                  : l10n.continueLabel,
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
                    SizedBox(height: isCompact ? 14 : 20),

                    // Social Proof (Avatars)
                    if (_currentPage == 0) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.14),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.groups_2_outlined,
                              color: AppColors.primary,
                              size: 17,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            l10n.onboardingCommunity,
                            style: GoogleFonts.inter(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      Text(
                        l10n.onboardingAgreement,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: AppColors.textSecondary.withValues(alpha: 0.6),
                          fontSize: 10,
                          height: 1.5,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent(
    Map<String, dynamic> data, {
    required bool isCompact,
  }) {
    return Stack(
      children: [
        // Background Image
        Positioned.fill(child: Image.asset(data['image'], fit: BoxFit.cover)),

        // Gradient Overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withValues(alpha: 0.1),
                  Colors.black.withValues(alpha: 0.6),
                  Colors.black.withValues(alpha: 0.95),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.2, 0.6, 1.0],
              ),
            ),
          ),
        ),

        // Content
        SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24, 70, 24, isCompact ? 180 : 210),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        data['badge'],
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
                SizedBox(height: isCompact ? 14 : 20),

                // Title Statement
                Text.rich(
                  TextSpan(
                    text: data['title'],
                    style: GoogleFonts.outfit(
                      fontSize: isCompact ? 38 : 46,
                      height: 1.1,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                    ),
                    children: [
                      TextSpan(
                        text: data['highlight'],
                        style: const TextStyle(color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isCompact ? 10 : 14),

                // Subtitle
                Text(
                  data['subtitle'],
                  style: GoogleFonts.inter(
                    fontSize: isCompact ? 14 : 16,
                    color: AppColors.textMain.withValues(alpha: 0.9),
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: isCompact ? 14 : 20),

                // Feature Cards Row
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: (data['features'] as List).map<Widget>((feature) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: _FeatureChip(
                          icon: feature['icon'],
                          label: feature['label'],
                          iconColor: AppColors.primary,
                        ),
                      );
                    }).toList(),
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
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
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
