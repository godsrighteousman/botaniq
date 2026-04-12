import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'plant_detail_page.dart';

class GardenPage extends StatelessWidget {
  const GardenPage({super.key});

  final Color _accentGreen = const Color(0xFF86D5A6);
  final Color _lightBg = const Color(0xFFF9FAF9);
  final Color _cardBg = Colors.white;
  final Color _primaryText = const Color(0xFF2C3E35);
  final Color _textSecondary = const Color(0xFF8A8A8E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _lightBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Garden',
                    style: GoogleFonts.outfit(
                      color: _primaryText,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Container(
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
                    child: Icon(Icons.add, color: _primaryText, size: 24),
                  ),
                ],
              ),
            ),
            
            // Filters
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  _buildFilterChip('All Plants', true),
                  const SizedBox(width: 12),
                  _buildFilterChip('Needs Water', false),
                  const SizedBox(width: 12),
                  _buildFilterChip('Indoor', false),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Grid of Plants
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.symmetric(horizontal: 24.0).copyWith(bottom: 120),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildPlantCard(context, 'Monstera', 'Swiss Cheese', 'https://images.unsplash.com/photo-1614594975525-e45190c55d0b?auto=format&fit=crop&q=80&w=400', 'Water in 2 days', Colors.blue),
                  _buildPlantCard(context, 'Ficus', 'Rubber Plant', 'https://images.unsplash.com/photo-1597055905001-c888d3f6d7ab?auto=format&fit=crop&q=80&w=400', 'Water today', Colors.redAccent),
                  _buildPlantCard(context, 'Sansevieria', 'Snake Plant', 'https://images.unsplash.com/photo-1593482892290-f54927ae1b7e?auto=format&fit=crop&q=80&w=400', 'Good for 2 weeks', _accentGreen),
                  _buildPlantCard(context, 'Aloe Vera', 'Succulent', 'https://images.unsplash.com/photo-1596547609652-9fc5d8d428ce?auto=format&fit=crop&q=80&w=400', 'Good for 3 weeks', _accentGreen),
                  _buildPlantCard(context, 'Pothos', 'Devil\'s Ivy', 'https://images.unsplash.com/photo-1604762512526-b7ce049b5768?auto=format&fit=crop&q=80&w=400', 'Water tomorrow', Colors.orange),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? _accentGreen : _cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? _accentGreen : const Color(0xFFE2E8F0),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: isSelected ? Colors.white : _textSecondary,
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPlantCard(BuildContext context, String name, String species, String imageUrl, String status, Color statusColor) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlantDetailPage(
              plantData: {
                'name': name,
                'species': species,
                'image': imageUrl,
                'status': status,
              },
              isFromGarden: true,
            ),
          ),
        );
      },
      child: Container(
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
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.outfit(
                    color: _primaryText,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  species,
                  style: GoogleFonts.inter(
                    color: _textSecondary,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        status,
                        style: GoogleFonts.inter(
                          color: statusColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
