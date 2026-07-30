import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:botaniq/l10n/app_localizations.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  final Color _accentGreen = const Color(0xFF86D5A6);
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.discoverTitle,
                  style: GoogleFonts.outfit(
                    color: _primaryText,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 24),
                // Search Bar
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _cardBg,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFCBD5E1).withOpacity(0.04 * 4),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: AppLocalizations.of(
                        context,
                      )!.discoverSearchHint,
                      hintStyle: GoogleFonts.inter(
                        color: _textSecondary,
                        fontSize: 14,
                      ),
                      icon: Icon(Icons.search_rounded, color: _textSecondary),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Latest Articles
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.discoverLatestArticles,
                      style: GoogleFonts.outfit(
                        color: _primaryText,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.discoverSeeAll,
                      style: GoogleFonts.inter(
                        color: _accentGreen,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 220,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    clipBehavior: Clip.none,
                    children: [
                      _buildArticleCard(
                        l10n.discoverMonsteraTitle,
                        l10n.discoverIndoorPlants,
                        'https://images.unsplash.com/photo-1614594975525-e45190c55d0b?auto=format&fit=crop&q=80&w=400',
                      ),
                      const SizedBox(width: 16),
                      _buildArticleCard(
                        l10n.discoverSucculentWatering,
                        l10n.discoverCacti,
                        'https://images.unsplash.com/photo-1459411552884-841db9b3cc2a?auto=format&fit=crop&q=80&w=400',
                      ),
                      const SizedBox(width: 16),
                      _buildArticleCard(
                        l10n.discoverHerbSoil,
                        l10n.discoverHerbs,
                        'https://images.unsplash.com/photo-1596704017254-9b121068fb31?auto=format&fit=crop&q=80&w=400',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Trending Guides
                Text(
                  AppLocalizations.of(context)!.discoverTrendingGuides,
                  style: GoogleFonts.outfit(
                    color: _primaryText,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                _buildGuideCard(
                  l10n.discoverPropagation,
                  l10n.discoverMinutesRead(12),
                  Icons.eco_rounded,
                ),
                const SizedBox(height: 12),
                _buildGuideCard(
                  l10n.discoverPests,
                  l10n.discoverMinutesRead(8),
                  Icons.bug_report_rounded,
                ),
                const SizedBox(height: 12),
                _buildGuideCard(
                  l10n.discoverRepotting,
                  l10n.discoverMinutesRead(15),
                  Icons.yard_rounded,
                ),

                const SizedBox(height: 120), // nav bar spacing
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildArticleCard(String title, String tag, String imageUrl) {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFCBD5E1).withOpacity(0.04 * 4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: Image.network(
              imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _accentGreen.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    tag,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF4FA976),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: _primaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuideCard(String title, String readTime, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFCBD5E1).withOpacity(0.03 * 4),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _accentGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: _accentGreen, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: _primaryText,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  readTime,
                  style: GoogleFonts.inter(color: _textSecondary, fontSize: 13),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: _textSecondary.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
