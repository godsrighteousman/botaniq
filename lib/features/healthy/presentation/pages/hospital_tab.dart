import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/services/sick_plant_service.dart';
import 'ai_chat_page.dart';

class HospitalTab extends StatefulWidget {
  final int refreshVersion;

  const HospitalTab({super.key, this.refreshVersion = 0});

  @override
  State<HospitalTab> createState() => _HospitalTabState();
}

class _HospitalTabState extends State<HospitalTab> {
  final Color _primaryGreen = const Color(0xFF4FA976);
  final Color _cardBg = Colors.white;

  List<Map<String, dynamic>> _sickPlants = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSickPlants();
  }

  @override
  void didUpdateWidget(covariant HospitalTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.refreshVersion != widget.refreshVersion) {
      _loadSickPlants();
    }
  }

  Future<void> _loadSickPlants() async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) {
        if (mounted) setState(() => _isLoading = false);
        return;
      }

      final data = await Supabase.instance.client
          .from('sick_plants')
          .select()
          .eq('user_id', userId)
          .eq('status', 'active')
          .order('created_at', ascending: false);

      if (mounted) {
        setState(() {
          _sickPlants = List<Map<String, dynamic>>.from(data);
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Hasta bitkiler yükleme hatası: $e");
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_sickPlants.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: _loadSickPlants,
      color: _primaryGreen,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        itemCount: _sickPlants.length + 1, // +1 for header
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF7C56).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${_sickPlants.length} Hasta',
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
              ],
            );
          }

          final plant = _sickPlants[index - 1];
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _buildPatientCard(plant),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: _primaryGreen.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.favorite_rounded,
                color: _primaryGreen,
                size: 48,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Tüm Bitkileriniz Sağlıklı! 🌿',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                color: const Color(0xFF2C3E35),
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Klinikte hasta bitki bulunmuyor.\nBir bitkinin sağlığından şüphe duyarsanız,\nDoktor sekmesinden danışabilirsiniz.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color(0xFF8B9E93),
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientCard(Map<String, dynamic> plant) {
    final name = plant['name'] ?? 'Bilinmeyen';
    final species = (plant['species'] ?? '').toString();
    final diagnosis = plant['diagnosis'] ?? 'Teşhis bekleniyor';
    final prescription = plant['prescription'] ?? 'Tedavi belirlenmedi';
    final urgency = plant['urgency'] ?? 'Orta';
    final recoveryProgress =
        (plant['recovery_progress'] as num?)?.toDouble() ?? 0.0;
    final sickPlantId = plant['id'];
    final plantId = plant['plant_id']?.toString();
    final imageUrl = plant['image_url']?.toString();

    Color urgencyColor;
    switch (urgency) {
      case 'Kritik':
        urgencyColor = const Color(0xFFEF7C56);
        break;
      case 'Düşük':
        urgencyColor = _primaryGreen;
        break;
      default:
        urgencyColor = const Color(0xFFE2A04A);
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AiChatPage(
                  plantId: plantId,
                  plantName: name,
                  plantImageUrl: imageUrl,
                  sickPlantId: sickPlantId,
                ),
          ),
        ).then((_) => _loadSickPlants()); // Refresh on return
      },
      child: Container(
        decoration: BoxDecoration(
          color: _cardBg,
          borderRadius: BorderRadius.circular(28),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: urgencyColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(
                      Icons.local_hospital_rounded,
                      color: urgencyColor,
                      size: 28,
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
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
                        if (species.isNotEmpty) ...[
                          Text(
                            species,
                            style: GoogleFonts.inter(
                              color: _primaryGreen,
                              fontSize: 11,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 3),
                        ],
                        Text(
                          diagnosis,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF6E6E73),
                            fontSize: 13,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
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
                      const Icon(
                        Icons.receipt_long_rounded,
                        color: Color(0xFF8B9E93),
                        size: 16,
                      ),
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
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'İyileşme Durumu',
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
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _markAsRecovered(sickPlantId),
                          icon: const Icon(
                            Icons.check_circle_outline,
                            size: 18,
                          ),
                          label: Text(
                            'İyileşti',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: _primaryGreen,
                            side: BorderSide(
                              color: _primaryGreen.withOpacity(0.3),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AiChatPage(
                                  plantId: plantId,
                                  plantName: name,
                                  plantImageUrl: imageUrl,
                                  sickPlantId: sickPlantId,
                                ),
                              ),
                            );
                            await _loadSickPlants();
                          },
                          icon: const Icon(Icons.chat_rounded, size: 18),
                          label: Text(
                            'Devam Et',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _primaryGreen,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
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

  Future<void> _markAsRecovered(String sickPlantId) async {
    try {
      await SickPlantService.markRecovered(sickPlantId);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('🎉 Bitkiniz sağlığına kavuştu!'),
            backgroundColor: _primaryGreen,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
        _loadSickPlants();
      }
    } catch (e) {
      debugPrint("İyileşme kaydı hatası: $e");
    }
  }
}
