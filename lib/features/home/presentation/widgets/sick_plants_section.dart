import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:botaniq/l10n/app_localizations.dart';
import '../../../healthy/presentation/pages/ai_chat_page.dart';

/// Anasayfada gösterilecek "Bitki Kliniği / Hasta Bitkiler" bölümü.
/// Sadece hasta bitki olduğunda gözükür ve premium bir kart tasarımı sunar.
class SickPlantsSection extends StatelessWidget {
  final List<Map<String, dynamic>> sickPlants;
  final VoidCallback onRefresh;

  const SickPlantsSection({
    super.key,
    required this.sickPlants,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (sickPlants.isEmpty) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bölüm Başlığı
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    l10n.homeSickPlants,
                    style: GoogleFonts.outfit(
                      color: const Color(0xFF1B3A2A),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Canlı / Yanıp sönen kırmızı nokta
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEF7C56),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF7C56).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  l10n.homeSickCount(sickPlants.length),
                  style: GoogleFonts.inter(
                    color: const Color(0xFFEF7C56),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Hasta Bitkiler Listesi (Yatay Kaydırılabilir)
        SizedBox(
          height: 165,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            clipBehavior: Clip.none,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            itemCount: sickPlants.length,
            separatorBuilder: (_, _a) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final plant = sickPlants[index];
              return _SickPlantCard(
                plant: plant,
                onTap: () {
                  final name = plant['name'] ?? l10n.clinicUnknown;
                  final sickPlantId = plant['id'];
                  final plantId = plant['plant_id']?.toString();
                  final imageUrl = plant['image_url']?.toString();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AiChatPage(
                        plantId: plantId,
                        plantName: name,
                        plantImageUrl: imageUrl,
                        sickPlantId: sickPlantId,
                      ),
                    ),
                  ).then((_) => onRefresh());
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SickPlantCard extends StatelessWidget {
  final Map<String, dynamic> plant;
  final VoidCallback onTap;

  const _SickPlantCard({required this.plant, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final name = plant['name'] ?? l10n.clinicUnknown;
    final diagnosis = plant['diagnosis'] ?? l10n.clinicPendingDiagnosis;
    final urgency = plant['urgency'] ?? 'Orta';
    final recoveryProgress =
        (plant['recovery_progress'] as num?)?.toDouble() ?? 0.0;

    Color urgencyColor;
    switch (urgency) {
      case 'Kritik':
        urgencyColor = const Color(0xFFEF7C56);
        break;
      case 'Düşük':
        urgencyColor = const Color(0xFF4FA976);
        break;
      default:
        urgencyColor = const Color(0xFFE2A04A);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 250,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: urgencyColor.withOpacity(0.2), width: 1),
          boxShadow: [
            BoxShadow(
              color: urgencyColor.withOpacity(0.05),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Üst kısım: İkon + İsim + Aciliyet
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tatlı Hasta Bitki İkonu (Yaprak + Yara Bandı)
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: urgencyColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text('🌿', style: TextStyle(fontSize: 24)),
                      ),
                    ),
                    Positioned(
                      right: -4,
                      top: -4,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Text('🩹', style: TextStyle(fontSize: 13)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.outfit(
                          color: const Color(0xFF1B3A2A),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: urgencyColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          _localizedUrgency(l10n, urgency.toString()),
                          style: GoogleFonts.inter(
                            color: urgencyColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Orta kısım: Teşhis
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                diagnosis,
                style: GoogleFonts.inter(
                  color: const Color(0xFF5C7165),
                  fontSize: 12,
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Alt kısım: İyileşme ilerlemesi
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.clinicRecovery,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF7A8F82),
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      '${(recoveryProgress * 100).toInt()}%',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF0ED761),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: recoveryProgress,
                    backgroundColor: const Color(0xFFE8F5EE),
                    color: const Color(0xFF0ED761),
                    minHeight: 5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _localizedUrgency(AppLocalizations l10n, String urgency) {
    switch (urgency.toLowerCase()) {
      case 'kritik':
      case 'critical':
        return l10n.clinicUrgencyCritical;
      case 'düşük':
      case 'dusuk':
      case 'low':
        return l10n.clinicUrgencyLow;
      default:
        return l10n.clinicUrgencyMedium;
    }
  }
}
