import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:botaniq/l10n/app_localizations.dart';
import 'ai_chat_page.dart';
import 'light_meter_page.dart';

class DoctorTab extends StatefulWidget {
  final VoidCallback? onHealthChanged;

  const DoctorTab({super.key, this.onHealthChanged});

  @override
  State<DoctorTab> createState() => _DoctorTabState();
}

class _DoctorTabState extends State<DoctorTab> {
  final Color _primaryGreen = const Color(0xFF4FA976);
  List<Map<String, dynamic>> _userPlants = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserPlants();
  }

  Future<void> _loadUserPlants() async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) return;

      final data = await Supabase.instance.client
          .from('plants')
          .select('id, custom_name, name, species, image_url, health_status')
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      if (mounted) {
        setState(() {
          _userPlants = List<Map<String, dynamic>>.from(data);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildConsultationBanner(context),
          const SizedBox(height: 32),
          Text(
            l10n.clinicQuickTools,
            style: GoogleFonts.outfit(
              color: const Color(0xFF2C3E35),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          _buildQuickToolsGrid(context),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildConsultationBanner(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () => _showConsultationBottomSheet(context),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          image: const DecorationImage(
            image: NetworkImage(
              'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?auto=format&fit=crop&q=80&w=800',
            ),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3B4D43).withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: LinearGradient(
              colors: [
                Colors.black.withValues(alpha: 0.1),
                Colors.black.withValues(alpha: 0.6),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                l10n.clinicDoctorHero,
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.psychology_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.clinicStartConsultation,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showConsultationBottomSheet(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.65,
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                l10n.clinicChoosePlant,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  color: const Color(0xFF2C3E35),
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.clinicChoosePlantSubtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: const Color(0xFF6E6E73),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              // Yeni fotoğraf çek seçeneği
              _buildNewPhotoOption(context),
              const SizedBox(height: 16),
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(),
                )
              else if (_userPlants.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    l10n.clinicNoGardenPlants,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF8B9E93),
                      fontSize: 14,
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: _userPlants.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final plant = _userPlants[index];
                      return _buildPlantPatientOption(
                        context,
                        plantId: plant['id'].toString(),
                        name:
                            plant['custom_name'] ??
                            plant['name'] ??
                            plant['species'] ??
                            l10n.plantUnknown,
                        imageUrl: plant['image_url'],
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNewPhotoOption(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () async {
        final navigator = Navigator.of(this.context);
        Navigator.pop(context);
        await navigator.push(
          MaterialPageRoute(
            builder: (context) => AiChatPage(plantName: l10n.plantUnknown),
          ),
        );
        if (!mounted) return;
        widget.onHealthChanged?.call();
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _primaryGreen.withValues(alpha: 0.1),
              _primaryGreen.withValues(alpha: 0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _primaryGreen.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _primaryGreen.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                Icons.add_a_photo_rounded,
                color: _primaryGreen,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.clinicNewPhoto,
                    style: GoogleFonts.outfit(
                      color: const Color(0xFF2C3E35),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l10n.clinicNewPhotoSubtitle,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF8B9E93),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: _primaryGreen,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlantPatientOption(
    BuildContext context, {
    required String plantId,
    required String name,
    String? imageUrl,
  }) {
    return GestureDetector(
      onTap: () async {
        final navigator = Navigator.of(this.context);
        Navigator.pop(context);
        await navigator.push(
          MaterialPageRoute(
            builder: (context) => AiChatPage(
              plantId: plantId,
              plantName: name,
              plantImageUrl: imageUrl,
            ),
          ),
        );
        if (!mounted) return;
        widget.onHealthChanged?.call();
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFCBD5E1).withValues(alpha: 0.16),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: imageUrl != null
                  ? Image.network(
                      imageUrl,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => _buildPlaceholderAvatar(),
                    )
                  : _buildPlaceholderAvatar(),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                name,
                style: GoogleFonts.outfit(
                  color: const Color(0xFF2C3E35),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _primaryGreen.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.chat_bubble_outline_rounded,
                color: _primaryGreen,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderAvatar() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Icon(
        Icons.local_florist,
        color: Color(0xFF8B9E93),
        size: 24,
      ),
    );
  }

  Widget _buildQuickToolsGrid(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 0.85,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildToolCard(
          title: l10n.clinicPestAnalysis,
          icon: Icons.bug_report_rounded,
          color: const Color(0xFFEF7C56),
          subtitle: l10n.clinicVisualDiagnosis,
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AiChatPage(plantName: l10n.clinicPestAnalysis),
              ),
            );
            widget.onHealthChanged?.call();
          },
        ),
        _buildToolCard(
          title: l10n.clinicLightMeter,
          icon: Icons.wb_sunny_rounded,
          color: const Color(0xFFE2A04A),
          subtitle: l10n.clinicSensorSimulation,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LightMeterPage()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildToolCard({
    required String title,
    required IconData icon,
    required Color color,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const Spacer(),
            Text(
              title,
              style: GoogleFonts.outfit(
                color: const Color(0xFF2C3E35),
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: GoogleFonts.inter(
                color: const Color(0xFF8B9E93),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
