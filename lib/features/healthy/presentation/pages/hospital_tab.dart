import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HospitalTab extends StatelessWidget {
  const HospitalTab({super.key});

  final Color _primaryGreen = const Color(0xFF4FA976);
  final Color _cardBg = Colors.white;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Bitki Kliniği',
              style: GoogleFonts.outfit(
                color: const Color(0xFF2C3E35),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFEF7C56).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '2 Hasta',
                style: GoogleFonts.inter(
                  color: const Color(0xFFEF7C56),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildPatientCard(
          name: 'Monstera Deliciosa',
          issue: 'Yapraklarda Sararma',
          urgency: 'Orta',
          urgencyColor: const Color(0xFFE2A04A),
          imageUrl: 'https://images.unsplash.com/photo-1614594975525-e45190c55d0b?auto=format&fit=crop&q=80&w=400',
          prescription: 'Demir Takviyesi, Azaltılmış Sulama',
          recoveryProgress: 0.6,
        ),
        const SizedBox(height: 20),
        _buildPatientCard(
          name: 'Fiddle Leaf Fig',
          issue: 'Kök Çürümesi Şüphesi',
          urgency: 'Kritik',
          urgencyColor: const Color(0xFFEF7C56),
          imageUrl: 'https://images.unsplash.com/photo-1597055905001-c888d3f6d7ab?auto=format&fit=crop&q=80&w=400',
          prescription: 'Saksı Değişimi, Mantar İlacı',
          recoveryProgress: 0.2,
        ),
        const SizedBox(height: 100),
      ],
    );
  }

  Widget _buildPatientCard({
    required String name,
    required String issue,
    required String urgency,
    required Color urgencyColor,
    required String imageUrl,
    required String prescription,
    required double recoveryProgress,
  }) {
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.local_florist, color: Color(0xFF8B9E93), size: 32),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: GoogleFonts.outfit(
                                color: const Color(0xFF2C3E35),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: urgencyColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              urgency,
                              style: GoogleFonts.inter(
                                color: urgencyColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        issue,
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
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.receipt_long_rounded, color: Color(0xFF8B9E93), size: 16),
                    const SizedBox(width: 6),
                    Text(
                      'Reçete:',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF8B9E93),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  prescription,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF2C3E35),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'İyileşme Grafiği',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF8B9E93),
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${(recoveryProgress * 100).toInt()}%',
                      style: GoogleFonts.inter(
                        color: _primaryGreen,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: recoveryProgress,
                    backgroundColor: const Color(0xFFF1F5F9),
                    color: _primaryGreen,
                    minHeight: 8,
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
