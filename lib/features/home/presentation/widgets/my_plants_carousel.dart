import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:botaniq/l10n/app_localizations.dart';

import '../models/home_models.dart';
import '../../../garden/presentation/pages/plant_detail_page.dart';

/// Kullanıcının bitkilerini yatay kaydırılabilir carousel olarak gösterir.
/// Glassmorphism tarzı kartlar ile premium görünüm sağlar.
class MyPlantsCarousel extends StatelessWidget {
  final List<PlantSummary> plants;
  final VoidCallback onViewAllTap;

  const MyPlantsCarousel({
    super.key,
    required this.plants,
    required this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Başlık satırı
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.homeMyPlants,
                style: GoogleFonts.outfit(
                  color: const Color(0xFF1B3A2A),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: onViewAllTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0ED761).withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    l10n.homeViewAll,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF0ED761),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Carousel
        SizedBox(
          height: 230,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            clipBehavior: Clip.none,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            itemCount: plants.length,
            separatorBuilder: (_, _a) => const SizedBox(width: 14),
            itemBuilder: (context, index) =>
                _PlantCard(plant: plants[index]),
          ),
        ),
      ],
    );
  }
}

class _PlantCard extends StatelessWidget {
  final PlantSummary plant;

  const _PlantCard({required this.plant});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlantDetailPage(plantData: plant.rawData),
          ),
        );
      },
      child: Container(
        width: 155,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: const Color(0xFFE8F5EE),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0ED761).withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Resim
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                child: Image.network(
                  plant.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _a, _b) => Container(
                    color: const Color(0xFFE8F5EE),
                    child: const Center(
                      child: Icon(
                        Icons.local_florist_outlined,
                        color: Color(0xFF86D5A6),
                        size: 36,
                      ),
                    ),
                  ),
                  loadingBuilder: (_, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: const Color(0xFFE8F5EE),
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xFF0ED761),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Bilgi
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plant.name,
                    style: GoogleFonts.outfit(
                      color: const Color(0xFF1B3A2A),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (plant.species.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      plant.species,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF7A8F82),
                        fontSize: 11,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 10),
                  // Sulama durumu rozeti
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: plant.statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.water_drop_rounded,
                          color: plant.statusColor,
                          size: 11,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            plant.wateringStatus,
                            style: GoogleFonts.inter(
                              color: plant.statusColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
