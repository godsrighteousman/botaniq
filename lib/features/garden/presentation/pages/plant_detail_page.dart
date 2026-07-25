import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'add_plant_wizard.dart';
import '../../../../core/services/openai_service.dart';

class PlantDetailPage extends StatefulWidget {
  final Map<String, dynamic> plantData;
  final bool isFromGarden;

  const PlantDetailPage({
    super.key,
    required this.plantData,
    this.isFromGarden = false,
  });

  @override
  State<PlantDetailPage> createState() => _PlantDetailPageState();
}

class _PlantDetailPageState extends State<PlantDetailPage> {
  final Color _accentGreen = const Color(0xFF86D5A6);
  final Color _lightBg = const Color(0xFFF9FAF9);
  final Color _cardBg = Colors.white;
  final Color _primaryText = const Color(0xFF2C3E35);
  final Color _textSecondary = const Color(0xFF8B9E93);

  // Bakım aksiyonu durumları
  bool _isWatered = false;
  bool _isFertilized = false;
  bool _isLoadingWater = false;
  bool _isLoadingFertilize = false;
  late Map<String, dynamic> _localPlantData;
  bool _isLoadingDetails = false;

  @override
  void initState() {
    super.initState();
    _localPlantData = Map<String, dynamic>.from(widget.plantData);
    _checkAndFetchDetails();
  }

  Future<void> _checkAndFetchDetails() async {
    // Sadece eğer bitki hakkında detaylı açıklama vs. yoksa OpenAI'den çekelim
    if (_localPlantData['description'] == null) {
      if (!mounted) return;
      setState(() => _isLoadingDetails = true);
      final name =
          _localPlantData['name'] ??
          _localPlantData['custom_name'] ??
          _localPlantData['species'] ??
          'Unknown Plant';
      final details = await OpenAIService.getPlantDetailsByName(name);

      if (details != null && mounted) {
        setState(() {
          _localPlantData.addAll(details);
          _isLoadingDetails = false;
        });

        // Eğer veritabanına kaydetmek istersek (opsiyonel) - şimdilik sadece UI'da tutuyoruz
        /*
        final id = _localPlantData['id']?.toString();
        if (id != null) {
          // Tabloda uygun kolonlar olmadığı sürece save edilemez.
        }
        */
      } else if (mounted) {
        setState(() => _isLoadingDetails = false);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  // ─── Water Now ───────────────────────────────────────────────────────────
  Future<void> _waterNow() async {
    final plantId = _localPlantData['id']?.toString();
    if (plantId == null || _isWatered || _isLoadingWater) return;

    setState(() => _isLoadingWater = true);
    HapticFeedback.mediumImpact();

    try {
      final now = DateTime.now();

      // 1. plants.last_watered_at güncelle
      await Supabase.instance.client
          .from('plants')
          .update({'last_watered_at': now.toIso8601String().substring(0, 10)})
          .eq('id', plantId);

      // 2. En yakın bekleyen sulama görevini tamamlandı yap veya yeni kayıt oluştur
      final pendingTasks = await Supabase.instance.client
          .from('care_tasks')
          .select('id')
          .eq('plant_id', plantId)
          .eq('task_type', 'water')
          .eq('is_completed', false)
          .order('due_date')
          .limit(1);

      if (pendingTasks.isNotEmpty) {
        await Supabase.instance.client
            .from('care_tasks')
            .update({
              'is_completed': true,
              'completed_at': now.toIso8601String(),
            })
            .eq('id', pendingTasks.first['id']);
      } else {
        final userId = Supabase.instance.client.auth.currentUser?.id;
        if (userId != null) {
          await Supabase.instance.client.from('care_tasks').insert({
            'plant_id': plantId,
            'user_id': userId,
            'task_type': 'water',
            'due_date': now.toIso8601String(),
            'is_completed': true,
            'completed_at': now.toIso8601String(),
          });
        }
      }

      if (mounted) {
        setState(() {
          _isWatered = true;
          _isLoadingWater = false;
        });
        HapticFeedback.heavyImpact();
        _showSuccessSnack('💧 Bitkini suladın! Harika iş!');
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingWater = false);
        _showErrorSnack('Sulama kaydedilemedi: $e');
      }
    }
  }

  // ─── Fertilize ───────────────────────────────────────────────────────────
  Future<void> _fertilizeNow() async {
    final plantId = _localPlantData['id']?.toString();
    if (plantId == null || _isFertilized || _isLoadingFertilize) return;

    setState(() => _isLoadingFertilize = true);
    HapticFeedback.mediumImpact();

    try {
      final now = DateTime.now();

      final pendingTasks = await Supabase.instance.client
          .from('care_tasks')
          .select('id')
          .eq('plant_id', plantId)
          .eq('task_type', 'fertilize')
          .eq('is_completed', false)
          .order('due_date')
          .limit(1);

      if (pendingTasks.isNotEmpty) {
        await Supabase.instance.client
            .from('care_tasks')
            .update({
              'is_completed': true,
              'completed_at': now.toIso8601String(),
            })
            .eq('id', pendingTasks.first['id']);
      } else {
        final userId = Supabase.instance.client.auth.currentUser?.id;
        if (userId != null) {
          await Supabase.instance.client.from('care_tasks').insert({
            'plant_id': plantId,
            'user_id': userId,
            'task_type': 'fertilize',
            'due_date': now.toIso8601String(),
            'is_completed': true,
            'completed_at': now.toIso8601String(),
          });
        }
      }

      if (mounted) {
        setState(() {
          _isFertilized = true;
          _isLoadingFertilize = false;
        });
        HapticFeedback.heavyImpact();
        _showSuccessSnack('🌱 Gübre verildi! Bitkin teşekkür eder!');
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingFertilize = false);
        _showErrorSnack('Gübre kaydedilemedi: $e');
      }
    }
  }

  void _showSuccessSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                msg,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF4FA976),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showErrorSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String name =
        _localPlantData['custom_name'] ??
        _localPlantData['name'] ??
        'Unknown Plant';
    final String species =
        _localPlantData['species'] ??
        _localPlantData['category'] ??
        'Plant Species';
    final String imageUrl =
        (_localPlantData['image_url'] ?? _localPlantData['image'] ?? '')
            .toString();
    final String difficulty = _localPlantData['difficulty'] ?? 'Medium';

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
                  _buildSectionTitle('Hakkında'),
                  const SizedBox(height: 12),
                  _buildAboutSection(),
                  const SizedBox(height: 32),
                  _buildSectionTitle('Konum & Ortam'),
                  const SizedBox(height: 16),
                  _buildPlacementSection(),
                  const SizedBox(height: 32),
                  _buildSectionTitle('Bakım Protokolü'),
                  const SizedBox(height: 16),
                  _buildCareRequirements(),
                  if (widget.isFromGarden) ...[
                    const SizedBox(height: 32),
                    _buildSectionTitle('Son 10 Günlük Bakım Geçmişi'),
                    const SizedBox(height: 16),
                    _buildCareHistorySection(),
                  ],
                  const SizedBox(height: 120),
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
              widget.isFromGarden
                  ? Icons.settings_outlined
                  : Icons.favorite_border,
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
            imageUrl.isNotEmpty
                ? Image.network(imageUrl, fit: BoxFit.cover)
                : Container(color: _accentGreen.withOpacity(0.2)),
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
        if (widget.isFromGarden)
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
    final bool isToxicToPets = _localPlantData['is_toxic_to_pets'] == true;
    final String toxicity =
        _localPlantData['toxicity'] ??
        (isToxicToPets ? 'Toxic to pets' : 'Non-toxic');
    final String environment = _localPlantData['environment'] ?? 'Indoor';
    final String sunlight =
        _localPlantData['sunlight'] ??
        _localPlantData['light_needs'] ??
        'Bright Indirect';
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _buildCharacteristicBadge(
          itemWidth,
          Icons.speed_rounded,
          'Zorluk Seviyesi',
          difficulty,
          _accentGreen,
        ),
        _buildCharacteristicBadge(
          itemWidth,
          Icons.pets_rounded,
          'Toksisite',
          toxicity,
          isToxicToPets ? Colors.redAccent : Colors.teal,
        ),
        _buildCharacteristicBadge(
          itemWidth,
          Icons.home_work_outlined,
          'Yetişme Ortamı',
          environment,
          Colors.purpleAccent,
        ),
        _buildCharacteristicBadge(
          itemWidth,
          Icons.wb_sunny_outlined,
          'Işık İhtiyacı',
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
            color: const Color(0xFFCBD5E1).withOpacity(0.16),
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
    if (_isLoadingDetails) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }
    final String desc =
        _localPlantData['description'] ??
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
    if (_isLoadingDetails) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }
    final String climate =
        _localPlantData['ideal_climate'] ?? 'Warm & Humid (18°C - 24°C)';
    final String humidityStr =
        _localPlantData['humidity'] ?? 'Moderate to High';
    final String tempRange = _localPlantData['temperature_range'] ?? '18-24°C';
    return Column(
      children: [
        _buildCareTile(
          icon: Icons.thermostat_rounded,
          title: 'İdeal İklim',
          subtitle: climate,
        ),
        const SizedBox(height: 12),
        _buildCareTile(
          icon: Icons.water_outlined,
          title: 'Nem Oranı',
          subtitle: humidityStr,
        ),
        const SizedBox(height: 12),
        _buildCareTile(
          icon: Icons.landscape_rounded,
          title: 'Sıcaklık Aralığı',
          subtitle: tempRange,
        ),
      ],
    );
  }

  Widget _buildCareRequirements() {
    if (_isLoadingDetails) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }
    final String waterProtocol =
        _localPlantData['watering_protocol'] ??
        _localPlantData['water_needs'] ??
        'Water every 7-10 days. Allow the top inch of soil to dry out between waterings.';
    final String feedProtocol =
        _localPlantData['feeding_protocol'] ??
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

  // ─── Bottom Action Bar ────────────────────────────────────────────────────
  Widget _buildCareHistorySection() {
    if (!widget.isFromGarden) return const SizedBox.shrink();
    final plantId = _localPlantData['id']?.toString();
    if (plantId == null) return const SizedBox.shrink();

    final tenDaysAgo = DateTime.now().subtract(const Duration(days: 10));

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: Supabase.instance.client
          .from('care_tasks')
          .select()
          .eq('plant_id', plantId)
          .eq('is_completed', true)
          .gte('completed_at', tenDaysAgo.toIso8601String())
          .order('completed_at', ascending: false)
          .then((data) => List<Map<String, dynamic>>.from(data)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text(
            'Error loading history: ${snapshot.error}',
            style: TextStyle(color: Colors.red),
          );
        }

        final history = snapshot.data ?? [];

        if (history.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _cardBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                Icon(Icons.history_rounded, color: _textSecondary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Son 10 güne ait bakım geçmişi bulunmuyor.',
                    style: GoogleFonts.inter(color: _textSecondary),
                  ),
                ),
              ],
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            children: history.map((task) {
              final taskType = task['task_type'] as String?;
              final completedAt = task['completed_at'] != null
                  ? DateTime.parse(task['completed_at'])
                  : null;
              final isWater = taskType == 'water';

              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isWater
                            ? const Color(0xFF4A90E2).withOpacity(0.1)
                            : const Color(0xFF4FA976).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isWater
                            ? Icons.water_drop_rounded
                            : Icons.science_rounded,
                        color: isWater
                            ? const Color(0xFF4A90E2)
                            : const Color(0xFF4FA976),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isWater ? 'Sulama' : 'Gübreleme',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              color: _primaryText,
                            ),
                          ),
                          if (completedAt != null)
                            Text(
                              '${completedAt.day}/${completedAt.month}/${completedAt.year} ${completedAt.hour.toString().padLeft(2, '0')}:${completedAt.minute.toString().padLeft(2, '0')}',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: _textSecondary,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.check_circle_rounded,
                      color: isWater
                          ? const Color(0xFF4A90E2)
                          : const Color(0xFF4FA976),
                      size: 16,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
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
      child: widget.isFromGarden
          ? Row(
              children: [
                // Sulama butonu
                Expanded(
                  child: _buildCareButton(
                    label: _isWatered ? 'Sulandı ✓' : 'Şimdi Sula',
                    icon: _isWatered
                        ? Icons.check_circle_rounded
                        : Icons.water_drop_rounded,
                    isDone: _isWatered,
                    isLoading: _isLoadingWater,
                    doneColor: const Color(0xFF4A90E2),
                    onTap: _waterNow,
                  ),
                ),
                const SizedBox(width: 8),
                // Gübre butonu
                Expanded(
                  child: _buildCareButton(
                    label: _isFertilized ? 'Gübre Verildi ✓' : 'Gübre Ver',
                    icon: _isFertilized
                        ? Icons.check_circle_rounded
                        : Icons.science_rounded,
                    isDone: _isFertilized,
                    isLoading: _isLoadingFertilize,
                    doneColor: const Color(0xFF4FA976),
                    onTap: _fertilizeNow,
                  ),
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: _buildCareButton(
                    label: 'Bahçeme Ekle',
                    icon: Icons.add_rounded,
                    isDone: false,
                    isLoading: false,
                    doneColor: _accentGreen,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddPlantWizard(
                            plantData: widget.plantData,
                            imagePath:
                                (_localPlantData['image_url'] ??
                                        _localPlantData['image'] ??
                                        '')
                                    .toString(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildCareButton({
    required String label,
    required IconData icon,
    required bool isDone,
    required bool isLoading,
    required Color doneColor,
    required VoidCallback onTap,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      height: 56,
      decoration: BoxDecoration(
        color: isDone ? doneColor.withOpacity(0.12) : _primaryText,
        borderRadius: BorderRadius.circular(28),
        border: isDone ? Border.all(color: doneColor, width: 2) : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: isDone || isLoading ? null : onTap,
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isDone ? doneColor : Colors.white,
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        color: isDone ? doneColor : Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        label,
                        style: GoogleFonts.inter(
                          color: isDone ? doneColor : Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
