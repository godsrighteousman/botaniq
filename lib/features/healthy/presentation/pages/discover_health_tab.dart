import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiscoverHealthTab extends StatelessWidget {
  const DiscoverHealthTab({super.key});

  final Color _cardBg = Colors.white;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      children: [
        _buildSectionTitle('Trend Sağlık Tüyoları'),
        const SizedBox(height: 16),
        _buildTipCard(
          title: 'Kışa Hazırlık: Nem Dengesini Korumak',
          subtitle: 'Soğuk aylarda bitkilerinizi kaloriferin kuru havasından nasıl korursunuz?',
          imageUrl: 'https://images.unsplash.com/photo-1497250681960-ef046c08a56e?auto=format&fit=crop&q=80&w=600',
        ),
        const SizedBox(height: 32),
        _buildSectionTitle('Haftanın Hastası & Şifası'),
        const SizedBox(height: 16),
        _buildWeeklySpotlight(),
        const SizedBox(height: 100),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.outfit(
        color: const Color(0xFF2C3E35),
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildTipCard({required String title, required String subtitle, required String imageUrl}) {
    return Container(
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(28),
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
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            child: Image.network(
              imageUrl,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 160,
                width: double.infinity,
                color: const Color(0xFFF1F5F9),
                child: const Icon(Icons.image_not_supported_outlined, color: Color(0xFF8B9E93), size: 40),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    color: const Color(0xFF2C3E35),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF6E6E73),
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklySpotlight() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF4FA976).withOpacity(0.1),
            const Color(0xFF86D5A6).withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.star_rounded, color: Color(0xFF4FA976), size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Yaprak Biti İstilası',
                  style: GoogleFonts.outfit(
                    color: const Color(0xFF2C3E35),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Erken evre müdahalesi ve doğal Neem Yağı kürü.',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF6E6E73),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
