import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'add_plant_wizard.dart';

class PlantDetailPage extends StatelessWidget {
  final Map<String, dynamic> plantData;
  final bool isFromGarden;

  const PlantDetailPage({
    super.key,
    required this.plantData,
    this.isFromGarden = false,
  });

  final Color _accentGreen = const Color(0xFF86D5A6);
  final Color _lightBg = const Color(0xFFF9FAF9);
  final Color _cardBg = Colors.white;
  final Color _primaryText = const Color(0xFF2C3E35);
  final Color _textSecondary = const Color(0xFF8B9E93);

  @override
  Widget build(BuildContext context) {
    final String name =
        plantData['custom_name'] ?? plantData['name'] ?? 'Unknown Plant';
    final String species =
        plantData['species'] ?? plantData['category'] ?? 'Plant Species';
    // GardenPage'den 'image_url', SearchPage'den 'image' alanı gelebilir
    final String imageUrl = (plantData['image_url'] ?? plantData['image'] ?? '')
        .toString();
    final String difficulty = plantData['difficulty'] ?? 'Medium';

    return Scaffold(
      backgroundColor: _lightBg,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context, imageUrl, name),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderInfo(name, species),
                  const SizedBox(height: 24),
                  _buildCharacteristicsGrid(context, difficulty),
                  const SizedBox(height: 32),
                  _buildSectionTitle('About'),
                  const SizedBox(height: 12),
                  _buildAboutSection(),
                  const SizedBox(height: 32),
                  _buildSectionTitle('Placement & Environment'),
                  const SizedBox(height: 16),
                  _buildPlacementSection(),
                  const SizedBox(height: 32),
                  _buildSectionTitle('Care Protocol'),
                  const SizedBox(height: 16),
                  _buildCareRequirements(),
                  const SizedBox(height: 100), // padding for bottom action bar
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildBottomActionBar(context),
    );
  }

  Widget _buildSliverAppBar(
    BuildContext context,
    String imageUrl,
    String name,
  ) {
    return SliverAppBar(
      expandedHeight: 320.0,
      pinned: true,
      elevation: 0,
      backgroundColor: _cardBg,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF3B4D43),
            size: 18,
          ),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              isFromGarden ? Icons.settings_outlined : Icons.favorite_border,
              color: const Color(0xFF3B4D43),
              size: 20,
            ),
            onPressed: () {},
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(imageUrl, fit: BoxFit.cover),
            // Gradient overlay for better text visibility if needed
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 80,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black.withOpacity(0.3), Colors.transparent],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderInfo(String name, String species) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: GoogleFonts.outfit(
                  color: _primaryText,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                species,
                style: GoogleFonts.inter(
                  color: _accentGreen,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        if (isFromGarden)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _accentGreen.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.eco, color: _accentGreen, size: 16),
                const SizedBox(width: 4),
                Text(
                  'Healthy',
                  style: GoogleFonts.inter(
                    color: _accentGreen,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildCharacteristicsGrid(BuildContext context, String difficulty) {
    final double itemWidth = (MediaQuery.of(context).size.width - 48 - 16) / 2;
    final bool isToxicToPets = plantData['is_toxic_to_pets'] == true;
    final String toxicity =
        plantData['toxicity'] ??
        (isToxicToPets ? 'Toxic to pets' : 'Non-toxic');
    final String environment = plantData['environment'] ?? 'Indoor';
    final String sunlight =
        plantData['sunlight'] ?? plantData['light_needs'] ?? 'Bright Indirect';
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _buildCharacteristicBadge(
          itemWidth,
          Icons.speed_rounded,
          'Difficulty',
          difficulty,
          _accentGreen,
        ),
        _buildCharacteristicBadge(
          itemWidth,
          Icons.pets_rounded,
          'Toxicity',
          toxicity,
          isToxicToPets ? Colors.redAccent : Colors.teal,
        ),
        _buildCharacteristicBadge(
          itemWidth,
          Icons.home_work_outlined,
          'Environment',
          environment,
          Colors.purpleAccent,
        ),
        _buildCharacteristicBadge(
          itemWidth,
          Icons.wb_sunny_outlined,
          'Sunlight',
          sunlight,
          Colors.orangeAccent,
        ),
      ],
    );
  }

  Widget _buildCharacteristicBadge(
    double width,
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFCBD5E1).withOpacity(0.04 * 4),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 16),
          Text(
            label,
            style: GoogleFonts.inter(
              color: _textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.outfit(
              color: _primaryText,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.outfit(
        color: _primaryText,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildAboutSection() {
    final String desc =
        plantData['description'] ??
        'This plant is known for its beautiful foliage and easy-care nature. '
            'It thrives in bright, indirect light and prefers its soil to dry out '
            'slightly between waterings.';
    return Text(
      desc,
      style: GoogleFonts.inter(
        color: _textSecondary,
        fontSize: 15,
        height: 1.6,
      ),
    );
  }

  Widget _buildPlacementSection() {
    final String climate =
        plantData['ideal_climate'] ?? 'Warm & Humid (18°C - 24°C)';
    final String humidityStr = plantData['humidity'] ?? 'Moderate to High';
    final String tempRange = plantData['temperature_range'] ?? '18-24°C';
    return Column(
      children: [
        _buildCareTile(
          icon: Icons.thermostat_rounded,
          title: 'Ideal Climate',
          subtitle: climate,
        ),
        const SizedBox(height: 12),
        _buildCareTile(
          icon: Icons.water_outlined,
          title: 'Humidity',
          subtitle: humidityStr,
        ),
        const SizedBox(height: 12),
        _buildCareTile(
          icon: Icons.landscape_rounded,
          title: 'Temperature Range',
          subtitle: tempRange,
        ),
      ],
    );
  }

  Widget _buildCareRequirements() {
    final String waterProtocol =
        plantData['watering_protocol'] ??
        plantData['water_needs'] ??
        'Water every 7-10 days. Allow the top inch of soil to dry out between waterings.';
    final String feedProtocol =
        plantData['feeding_protocol'] ??
        'Fertilize monthly during spring/summer with balanced liquid fertilizer.';
    return Column(
      children: [
        _buildCareTile(
          icon: Icons.water_drop_rounded,
          title: 'Watering Protocol',
          subtitle: waterProtocol,
        ),
        const SizedBox(height: 12),
        _buildCareTile(
          icon: Icons.science_rounded,
          title: 'Feeding Protocol',
          subtitle: feedProtocol,
        ),
        const SizedBox(height: 12),
        _buildCareTile(
          icon: Icons.content_cut_rounded,
          title: 'Pruning & Cleaning',
          subtitle:
              'Wipe leaves monthly. Prune dead or yellowing leaves to encourage growth.',
        ),
      ],
    );
  }

  Widget _buildCareTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _lightBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: _primaryText, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    color: _primaryText,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    color: _textSecondary,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFCBD5E1).withOpacity(0.32),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          if (isFromGarden) ...[
            Expanded(
              child: _buildActionButton(
                context,
                title: 'Water Now',
                icon: Icons.water_drop,
                isPrimary: true,
                onTap: () async {
                  final plantId = plantData['id']?.toString();
                  if (plantId == null) return;
                  final now = DateTime.now();
                  try {
                    await Supabase.instance.client
                        .from('plants')
                        .update({
                          'last_watered_at': now.toIso8601String().substring(
                            0,
                            10,
                          ),
                        })
                        .eq('id', plantId);
                    // En yakın sulama görevini tamamlandı olarak işaretle
                    await Supabase.instance.client
                        .from('care_tasks')
                        .update({
                          'is_completed': true,
                          'completed_at': now.toIso8601String(),
                        })
                        .eq('plant_id', plantId)
                        .eq('task_type', 'water')
                        .eq('is_completed', false)
                        .order('due_date')
                        .limit(1);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('✓ Plant watered! Great job!'),
                        ),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Error: $e')));
                    }
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            _buildIconActionButton(Icons.camera_alt_outlined),
          ] else ...[
            Expanded(
              child: _buildActionButton(
                context,
                title: 'Add to My Garden',
                icon: Icons.add,
                isPrimary: true,
                onTap: () {
                  // Wizard'a bitki verilerini aktar
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPlantWizard(
                        plantData: plantData,
                        imagePath:
                            (plantData['image_url'] ?? plantData['image'] ?? '')
                                .toString(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required String title,
    required IconData icon,
    required bool isPrimary,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: isPrimary ? _primaryText : _lightBg,
          borderRadius: BorderRadius.circular(28),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isPrimary ? Colors.white : _primaryText,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: GoogleFonts.inter(
                color: isPrimary ? Colors.white : _primaryText,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconActionButton(IconData icon) {
    return Container(
      height: 56,
      width: 56,
      decoration: BoxDecoration(
        color: _lightBg,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Icon(icon, color: _primaryText),
    );
  }
}
