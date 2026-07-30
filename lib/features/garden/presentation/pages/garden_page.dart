import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'search_history_page.dart';
import 'plant_detail_page.dart';
import '../../../../core/services/watering_schedule_service.dart';
import 'package:botaniq/l10n/app_localizations.dart';

class GardenPage extends StatefulWidget {
  const GardenPage({super.key});

  @override
  State<GardenPage> createState() => _GardenPageState();
}

class _GardenPageState extends State<GardenPage> {
  final Color _accentGreen = const Color(0xFF86D5A6);
  final Color _lightBg = const Color(0xFFF9FAF9);
  final Color _cardBg = Colors.white;
  final Color _primaryText = const Color(0xFF2C3E35);
  final Color _textSecondary = const Color(0xFF8A8A8E);

  List<Map<String, dynamic>> _plants = [];
  bool _isLoading = true;
  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    _fetchPlants();
  }

  Future<void> _fetchPlants() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;
    try {
      final data = await Supabase.instance.client
          .from('plants')
          .select()
          .eq('user_id', user.id)
          .order('created_at', ascending: false)
          .timeout(const Duration(seconds: 5));
      if (mounted) {
        setState(() {
          _plants = List<Map<String, dynamic>>.from(data);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  List<Map<String, dynamic>> get _filteredPlants {
    if (_selectedFilter == 'needsWater') {
      return _plants
          .where((plant) => WateringScheduleService.fromPlant(plant).isDue)
          .toList();
    }
    if (_selectedFilter == 'indoor') {
      return _plants
          .where(
            (p) =>
                (p['light_condition'] ?? '').toString().toLowerCase().contains(
                  'indirect',
                ) ||
                (p['room'] ?? '') != 'Balcony',
          )
          .toList();
    }
    return _plants;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _lightBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.gardenTitle,
                    style: GoogleFonts.outfit(
                      color: _primaryText,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchHistoryPage(),
                        ),
                      );
                      _fetchPlants();
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: _accentGreen,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: _accentGreen.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.history_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Filter Chips
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  _buildFilterChip(
                    'all',
                    AppLocalizations.of(context)!.gardenAllPlants,
                  ),
                  const SizedBox(width: 12),
                  _buildFilterChip(
                    'needsWater',
                    AppLocalizations.of(context)!.gardenNeedsWater,
                  ),
                  const SizedBox(width: 12),
                  _buildFilterChip(
                    'indoor',
                    AppLocalizations.of(context)!.gardenIndoor,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Plant Grid
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF86D5A6),
                      ),
                    )
                  : _filteredPlants.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.local_florist_outlined,
                              size: 56,
                              color: _accentGreen.withOpacity(0.5),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _selectedFilter == 'all'
                                  ? AppLocalizations.of(context)!.gardenNoPlants
                                  : AppLocalizations.of(
                                      context,
                                    )!.gardenNoPlantsCategory,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                color: _textSecondary,
                                fontSize: 16,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                      ).copyWith(bottom: 120),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.68,
                          ),
                      physics: const BouncingScrollPhysics(),
                      itemCount: _filteredPlants.length,
                      itemBuilder: (context, index) {
                        return _buildPlantCard(context, _filteredPlants[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String value, String label) {
    final isSelected = _selectedFilter == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = value),
      child: Container(
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
      ),
    );
  }

  Widget _buildPlantCard(BuildContext context, Map<String, dynamic> plant) {
    final l10n = AppLocalizations.of(context)!;
    final name =
        plant['custom_name'] ?? plant['name'] ?? l10n.gardenMyPlantFallback;
    final species = plant['species'] ?? '';
    final imageUrl = (plant['image_url'] ?? '') as String;
    final healthStatus = (plant['health_status'] ?? '')
        .toString()
        .toLowerCase();
    final isSick = healthStatus == 'sick' || healthStatus == 'hasta';
    final watering = WateringScheduleService.fromPlant(plant);
    final status = _wateringStatus(l10n, watering);
    final statusColor = watering.isDue
        ? Colors.redAccent
        : watering.isDueTomorrow
        ? Colors.orange
        : _accentGreen;

    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PlantDetailPage(plantData: plant, isFromGarden: true),
          ),
        );
        await _fetchPlants();
      },
      child: Container(
        decoration: BoxDecoration(
          color: _cardBg,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFCBD5E1).withOpacity(0.16),
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
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    imageUrl.isNotEmpty
                        ? Image.network(
                            imageUrl,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) =>
                                const _PlantPlaceholder(),
                          )
                        : const _PlantPlaceholder(),
                    if (isSick)
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEF7C56),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.14),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Text(
                            l10n.gardenClinicBadge,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                  ],
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
                  const SizedBox(height: 6),
                  Text(
                    '${_lastWateredLabel(l10n, watering)} • '
                    '${l10n.wateringInterval(watering.intervalDays)}',
                    style: GoogleFonts.inter(
                      color: _textSecondary,
                      fontSize: 9,
                      height: 1.25,
                    ),
                    maxLines: 2,
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
      ),
    );
  }

  String _wateringStatus(
    AppLocalizations l10n,
    PlantWateringSchedule watering,
  ) {
    if (watering.lastWateredAt == null) return l10n.wateringNeverDue;
    if (watering.isOverdue) {
      return l10n.wateringOverdue(watering.daysUntilDue.abs());
    }
    if (watering.isDueToday) return l10n.wateringDueToday;
    if (watering.isDueTomorrow) return l10n.wateringDueTomorrow;
    return l10n.wateringDueInDays(watering.daysUntilDue);
  }

  String _lastWateredLabel(
    AppLocalizations l10n,
    PlantWateringSchedule watering,
  ) {
    final date = watering.lastWateredAt;
    if (date == null) return l10n.wateringNever;
    final formatted =
        '${date.day.toString().padLeft(2, '0')}.'
        '${date.month.toString().padLeft(2, '0')}.${date.year}';
    return l10n.wateringLastDate(formatted);
  }
}

class _PlantPlaceholder extends StatelessWidget {
  const _PlantPlaceholder();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFE8F5EE),
      child: const Icon(
        Icons.local_florist_outlined,
        color: Color(0xFF86D5A6),
        size: 48,
      ),
    );
  }
}
