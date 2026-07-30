import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'add_plant_wizard.dart';
import '../../../../core/services/openai_service.dart';
import '../../../../core/services/watering_schedule_service.dart';
import '../../../../core/services/care_notification_service.dart';
import 'package:botaniq/l10n/app_localizations.dart';

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

class _PlantDetailPageState extends State<PlantDetailPage>
    with TickerProviderStateMixin {
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
  late final AnimationController _careAnimationController;
  late final AnimationController _toastAnimationController;
  _CareAnimationType? _careAnimationType;
  OverlayEntry? _successToastEntry;
  String? _localizedContentLanguage;
  bool _isLocalizingContent = false;

  @override
  void initState() {
    super.initState();
    _localPlantData = Map<String, dynamic>.from(widget.plantData);
    _careAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 950),
    );
    _toastAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );
    _checkAndFetchDetails();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final languageCode = Localizations.localeOf(context).languageCode;
    if (_localizedContentLanguage != languageCode && !_isLocalizingContent) {
      Future<void>.microtask(_localizeVisiblePlantContent);
    }
  }

  Future<void> _localizeVisiblePlantContent() async {
    if (!mounted || _isLocalizingContent) return;
    final languageCode = Localizations.localeOf(context).languageCode;
    _isLocalizingContent = true;
    final localized = await OpenAIService.localizePlantDetails(_localPlantData);
    if (!mounted) return;
    setState(() {
      if (localized != null) _localPlantData.addAll(localized);
      _localizedContentLanguage = languageCode;
      _isLocalizingContent = false;
    });
  }

  Future<void> _checkAndFetchDetails() async {
    // Sadece eğer bitki hakkında detaylı açıklama vs. yoksa OpenAI'den çekelim
    if (_localPlantData['description'] == null) {
      if (!mounted) return;
      setState(() => _isLoadingDetails = true);

      // 1. Eger catalog_id varsa veritabanından çek
      final catalogId = _localPlantData['catalog_id'];
      if (catalogId != null) {
        try {
          final catData = await Supabase.instance.client
              .from('plant_catalog')
              .select()
              .eq('id', catalogId)
              .maybeSingle();
          if (catData != null && mounted) {
            setState(() {
              _localPlantData.addAll(catData);
              _localizedContentLanguage = null;
              _isLoadingDetails = false;
            });
            await _localizeVisiblePlantContent();
            return;
          }
        } catch (e) {
          debugPrint('Failed to fetch from catalog by id: $e');
        }
      }

      // 2. catalog_id yoksa veya bulunamadıysa, ismine göre katalog araması dene
      try {
        final name =
            _localPlantData['name'] ??
            _localPlantData['custom_name'] ??
            _localPlantData['species'] ??
            '';
        if (name.isNotEmpty) {
          final catData = await Supabase.instance.client
              .from('plant_catalog')
              .select()
              .or('name.ilike.%$name%,species.ilike.%$name%')
              .limit(1)
              .maybeSingle();
          if (catData != null && mounted) {
            setState(() {
              _localPlantData.addAll(catData);
              _localizedContentLanguage = null;
              _isLoadingDetails = false;
            });
            await _localizeVisiblePlantContent();
            return;
          }
        }
      } catch (e) {
        debugPrint('Failed to lookup fallback catalog by name: $e');
      }

      // 3. Katalogda yoksa OpenAI ile detayları oluştur
      final name =
          _localPlantData['name'] ??
          _localPlantData['custom_name'] ??
          _localPlantData['species'] ??
          'Unknown Plant';
      final details = await OpenAIService.getPlantDetailsByName(name);

      if (details != null && mounted) {
        setState(() {
          _localPlantData.addAll(details);
          _localizedContentLanguage = null;
          _isLoadingDetails = false;
        });
        await _localizeVisiblePlantContent();
      } else if (mounted) {
        setState(() => _isLoadingDetails = false);
      }
    }
  }

  @override
  void dispose() {
    _successToastEntry?.remove();
    _successToastEntry = null;
    _toastAnimationController.dispose();
    _careAnimationController.dispose();
    super.dispose();
  }

  void _playCareAnimation(_CareAnimationType type) {
    if (MediaQuery.maybeOf(context)?.disableAnimations ?? false) return;
    setState(() => _careAnimationType = type);
    _careAnimationController.forward(from: 0);
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

      // 2. Bugüne kadar bekleyen eski sulama görevlerini kapat.
      await Supabase.instance.client
          .from('care_tasks')
          .update({
            'is_completed': true,
            'completed_at': now.toUtc().toIso8601String(),
          })
          .eq('plant_id', plantId)
          .eq('task_type', 'water')
          .eq('is_completed', false)
          .lte('due_date', now.toUtc().toIso8601String());

      // 3. Gerçek sulama geçmişini kaydet.
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId != null) {
        await Supabase.instance.client.from('care_tasks').insert({
          'plant_id': plantId,
          'user_id': userId,
          'task_type': 'water',
          'due_date': now.toUtc().toIso8601String(),
          'is_completed': true,
          'completed_at': now.toUtc().toIso8601String(),
        });
      }

      if (mounted) {
        setState(() {
          _localPlantData['last_watered_at'] = now.toIso8601String().substring(
            0,
            10,
          );
          _isWatered = true;
          _isLoadingWater = false;
        });
        _playCareAnimation(_CareAnimationType.water);
        HapticFeedback.heavyImpact();
        _showSuccessSnack(AppLocalizations.of(context)!.plantWaterSuccess);
        CareNotificationService.instance.refreshSchedules();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingWater = false);
        _showErrorSnack(
          AppLocalizations.of(context)!.plantWaterError(e.toString()),
        );
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
        _playCareAnimation(_CareAnimationType.fertilizer);
        HapticFeedback.heavyImpact();
        _showSuccessSnack(AppLocalizations.of(context)!.plantFertilizeSuccess);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingFertilize = false);
        _showErrorSnack(
          AppLocalizations.of(context)!.plantFertilizeError(e.toString()),
        );
      }
    }
  }

  void _showSuccessSnack(String msg) {
    _successToastEntry?.remove();
    _toastAnimationController.stop();
    final overlay = Overlay.of(context);
    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (overlayContext) {
        return Positioned.fill(
          child: IgnorePointer(
            child: AnimatedBuilder(
              animation: _toastAnimationController,
              builder: (context, child) {
                final timeline = _toastAnimationController.value;
                final visibility = timeline < 0.16
                    ? Curves.easeOutCubic.transform(timeline / 0.16)
                    : timeline < 0.72
                    ? 1.0
                    : 1 -
                          Curves.easeInCubic.transform(
                            ((timeline - 0.72) / 0.28)
                                .clamp(0.0, 1.0)
                                .toDouble(),
                          );
                final scale = 0.86 + (0.14 * visibility);

                return Center(
                  child: Transform.scale(
                    scale: scale,
                    child: Opacity(
                      opacity: visibility.clamp(0.0, 1.0).toDouble(),
                      child: child,
                    ),
                  ),
                );
              },
              child: Material(
                color: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 330),
                      margin: const EdgeInsets.symmetric(horizontal: 28),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 18,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF20352A).withValues(alpha: 0.82),
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.22),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.22),
                            blurRadius: 34,
                            offset: const Offset(0, 14),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFF86D5A6,
                              ).withValues(alpha: 0.22),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(
                                  0xFF86D5A6,
                                ).withValues(alpha: 0.55),
                              ),
                            ),
                            child: const Icon(
                              Icons.check_rounded,
                              color: Color(0xFFA8E7BE),
                              size: 25,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Flexible(
                            child: Text(
                              msg,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
    _successToastEntry = entry;
    overlay.insert(entry);
    _toastAnimationController
        .forward(from: 0)
        .orCancel
        .then((_) {
          if (!identical(_successToastEntry, entry)) return;
          entry.remove();
          _successToastEntry = null;
        })
        .catchError((Object _) {});
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

  Future<void> _confirmAndDeletePlant() async {
    final l10n = AppLocalizations.of(context)!;
    final plantId = _localPlantData['id']?.toString();
    if (plantId == null || plantId.isEmpty) return;

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        icon: const Icon(
          Icons.delete_outline_rounded,
          color: Color(0xFFE96565),
          size: 32,
        ),
        title: Text(
          l10n.deletePlantTitle,
          textAlign: TextAlign.center,
          style: GoogleFonts.outfit(
            color: _primaryText,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          l10n.deletePlantMessage,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(color: _textSecondary, height: 1.45),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFE96565),
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.deletePlantAction),
          ),
        ],
      ),
    );
    if (shouldDelete != true || !mounted) return;

    try {
      final client = Supabase.instance.client;
      var deleted = false;
      try {
        final result = await client.rpc(
          'delete_own_plant',
          params: {'target_plant_id': plantId},
        );
        deleted = result == true;
      } on PostgrestException catch (error) {
        if (error.code != 'PGRST202' && error.code != '42883') rethrow;
        final userId = client.auth.currentUser?.id;
        if (userId == null) return;
        await client
            .from('sick_plants')
            .delete()
            .eq('plant_id', plantId)
            .eq('user_id', userId);
        final removed = await client
            .from('plants')
            .delete()
            .eq('id', plantId)
            .eq('user_id', userId)
            .select('id');
        deleted = removed.isNotEmpty;
      }

      if (!deleted) {
        throw Exception(l10n.deletePlantNotFound);
      }

      await _removeOwnedPlantImage();
      await CareNotificationService.instance.refreshSchedules();
      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (error) {
      if (!mounted) return;
      _showErrorSnack(l10n.deletePlantError(error.toString()));
    }
  }

  Future<void> _removeOwnedPlantImage() async {
    final imageUrl = (_localPlantData['image_url'] ?? '').toString();
    final userId = Supabase.instance.client.auth.currentUser?.id;
    const marker = '/storage/v1/object/public/plant-images/';
    final markerIndex = imageUrl.indexOf(marker);
    if (userId == null || markerIndex < 0) return;

    final encodedPath = imageUrl.substring(markerIndex + marker.length);
    final path = Uri.decodeComponent(encodedPath.split('?').first);
    if (!path.startsWith('${userId}_')) return;
    try {
      await Supabase.instance.client.storage.from('plant-images').remove([
        path,
      ]);
    } catch (error) {
      debugPrint('Silinen bitkinin görseli kaldırılamadı: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final String name =
        _localPlantData['custom_name'] ??
        _localPlantData['name'] ??
        l10n.plantUnknown;
    final String species =
        _localPlantData['species'] ??
        _localPlantData['category'] ??
        l10n.plantSpeciesFallback;
    final String imageUrl =
        (_localPlantData['image_url'] ?? _localPlantData['image'] ?? '')
            .toString();
    final String difficulty =
        _localPlantData['difficulty'] ?? l10n.plantDifficultyMedium;

    return Scaffold(
      backgroundColor: _lightBg,
      body: Stack(
        children: [
          CustomScrollView(
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
                      _buildSectionTitle(l10n.plantAbout),
                      const SizedBox(height: 12),
                      _buildAboutSection(),
                      const SizedBox(height: 32),
                      _buildSectionTitle(l10n.plantLocationEnvironment),
                      const SizedBox(height: 16),
                      _buildPlacementSection(),
                      const SizedBox(height: 32),
                      _buildSectionTitle(l10n.plantCareProtocol),
                      const SizedBox(height: 16),
                      _buildCareRequirements(),
                      if (widget.isFromGarden) ...[
                        const SizedBox(height: 32),
                        _buildSectionTitle(l10n.plantCareHistory),
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
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _careAnimationController,
                builder: (context, child) {
                  final type = _careAnimationType;
                  if (type == null || !_careAnimationController.isAnimating) {
                    return const SizedBox.shrink();
                  }
                  return CustomPaint(
                    painter: _CareCelebrationPainter(
                      progress: Curves.easeOutCubic.transform(
                        _careAnimationController.value,
                      ),
                      type: type,
                    ),
                  );
                },
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
                  ? Icons.delete_outline_rounded
                  : Icons.favorite_border,
              color: widget.isFromGarden
                  ? const Color(0xFFE96565)
                  : const Color(0xFF3B4D43),
              size: 20,
            ),
            onPressed: widget.isFromGarden ? _confirmAndDeletePlant : null,
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
    final l10n = AppLocalizations.of(context)!;
    final healthStatus = (_localPlantData['health_status'] ?? '')
        .toString()
        .toLowerCase();
    final isSick = healthStatus == 'sick' || healthStatus == 'hasta';
    final healthColor = isSick ? const Color(0xFFEF7C56) : _accentGreen;

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
              color: healthColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isSick ? Icons.healing_rounded : Icons.eco,
                  color: healthColor,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  isSick ? l10n.plantInClinic : l10n.plantHealthy,
                  style: GoogleFonts.inter(
                    color: healthColor,
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
    final l10n = AppLocalizations.of(context)!;
    final double itemWidth = (MediaQuery.of(context).size.width - 48 - 16) / 2;
    final bool isToxicToPets = _localPlantData['is_toxic_to_pets'] == true;
    final String toxicity =
        _localPlantData['toxicity'] ??
        (isToxicToPets ? l10n.plantToxicPets : l10n.plantNonToxic);
    final String environment =
        _localPlantData['environment'] ?? l10n.plantIndoor;
    final String sunlight =
        _localPlantData['sunlight'] ??
        _localPlantData['light_needs'] ??
        l10n.plantBrightIndirect;
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _buildCharacteristicBadge(
          itemWidth,
          Icons.speed_rounded,
          l10n.plantDifficulty,
          difficulty,
          _accentGreen,
        ),
        _buildCharacteristicBadge(
          itemWidth,
          Icons.pets_rounded,
          l10n.plantToxicity,
          toxicity,
          isToxicToPets ? Colors.redAccent : Colors.teal,
        ),
        _buildCharacteristicBadge(
          itemWidth,
          Icons.home_work_outlined,
          l10n.plantEnvironment,
          environment,
          Colors.purpleAccent,
        ),
        _buildCharacteristicBadge(
          itemWidth,
          Icons.wb_sunny_outlined,
          l10n.plantLightNeed,
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
    final l10n = AppLocalizations.of(context)!;
    if (_isLoadingDetails) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }
    final String desc =
        _localPlantData['description'] ?? l10n.plantInfoUnavailable;
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
    final l10n = AppLocalizations.of(context)!;
    if (_isLoadingDetails) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }
    final String climate =
        _localPlantData['ideal_climate'] ?? l10n.plantInfoUnavailable;
    final String humidityStr =
        _localPlantData['humidity'] ?? l10n.plantInfoUnavailable;
    final String tempRange =
        _localPlantData['temperature_range'] ?? l10n.plantInfoUnavailable;
    return Column(
      children: [
        _buildCareTile(
          icon: Icons.thermostat_rounded,
          title: l10n.plantIdealClimate,
          subtitle: climate,
        ),
        const SizedBox(height: 12),
        _buildCareTile(
          icon: Icons.water_outlined,
          title: l10n.plantHumidity,
          subtitle: humidityStr,
        ),
        const SizedBox(height: 12),
        _buildCareTile(
          icon: Icons.landscape_rounded,
          title: l10n.plantTemperatureRange,
          subtitle: tempRange,
        ),
      ],
    );
  }

  Widget _buildCareRequirements() {
    final l10n = AppLocalizations.of(context)!;
    if (_isLoadingDetails) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }
    final String waterProtocol =
        _localPlantData['watering_protocol'] ??
        _localPlantData['water_needs'] ??
        l10n.plantInfoUnavailable;
    final String feedProtocol =
        _localPlantData['feeding_protocol'] ?? l10n.plantInfoUnavailable;
    final String soilProtocol =
        _localPlantData['soil_protocol'] ?? l10n.plantInfoUnavailable;
    final watering = WateringScheduleService.fromPlant(_localPlantData);
    final interval = l10n.wateringInterval(watering.intervalDays);
    return Column(
      children: [
        _buildCareTile(
          icon: Icons.repeat_one_rounded,
          title: l10n.plantWateringFrequency,
          subtitle: l10n.plantWateringFrequencyValue(interval),
        ),
        const SizedBox(height: 12),
        _buildCareTile(
          icon: Icons.history_rounded,
          title: l10n.plantNextWatering,
          subtitle:
              '${_localizedLastWatered(l10n, watering)}\n'
              '${_localizedWateringStatus(l10n, watering)}',
        ),
        const SizedBox(height: 12),
        _buildCareTile(
          icon: Icons.water_drop_rounded,
          title: l10n.plantWateringProtocol,
          subtitle: waterProtocol,
        ),
        const SizedBox(height: 12),
        _buildCareTile(
          icon: Icons.grass_rounded,
          title: l10n.plantSoilProtocol,
          subtitle: soilProtocol,
        ),
        const SizedBox(height: 12),
        _buildCareTile(
          icon: Icons.science_rounded,
          title: l10n.plantFeedingProtocol,
          subtitle: feedProtocol,
        ),
        const SizedBox(height: 12),
        _buildCareTile(
          icon: Icons.content_cut_rounded,
          title: l10n.plantPruningCleaning,
          subtitle:
              _localPlantData['care_protocol'] ?? l10n.plantPruningFallback,
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

  String _localizedWateringStatus(
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

  String _localizedLastWatered(
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

  // ─── Bottom Action Bar ────────────────────────────────────────────────────
  Widget _buildCareHistorySection() {
    final l10n = AppLocalizations.of(context)!;
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
                    l10n.plantHistoryEmpty,
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
                            isWater
                                ? l10n.plantWateringTask
                                : l10n.plantFertilizingTask,
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
    final l10n = AppLocalizations.of(context)!;
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
                    label: _isWatered
                        ? l10n.plantWateredAction
                        : l10n.plantWaterNowAction,
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
                    label: _isFertilized
                        ? l10n.plantFertilizedAction
                        : l10n.plantFertilizeAction,
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
                    label: l10n.plantAddGardenAction,
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

enum _CareAnimationType { water, fertilizer }

class _CareCelebrationPainter extends CustomPainter {
  const _CareCelebrationPainter({required this.progress, required this.type});

  final double progress;
  final _CareAnimationType type;

  @override
  void paint(Canvas canvas, Size size) {
    final origin = Offset(
      size.width * (type == _CareAnimationType.water ? 0.32 : 0.68),
      size.height - 138,
    );
    final fade = (1 - progress).clamp(0.0, 1.0).toDouble();

    if (type == _CareAnimationType.water) {
      _paintWater(canvas, origin, fade);
    } else {
      _paintFertilizer(canvas, origin, fade);
    }
  }

  void _paintWater(Canvas canvas, Offset origin, double fade) {
    const colors = [Color(0xFF63B3FF), Color(0xFF3D8FE8), Color(0xFF9DD8FF)];
    for (var index = 0; index < 24; index++) {
      final lane = index - 11.5;
      final phase = (progress + index * 0.035).clamp(0.0, 1.0).toDouble();
      final horizontal = lane * 8.5 * phase;
      final lift = (78 + (index % 5) * 20) * phase;
      final gravity = 42 * phase * phase;
      final center = origin + Offset(horizontal, -lift + gravity);
      final radius = 2.8 + (index % 3) * 0.9;
      final paint = Paint()
        ..color = colors[index % colors.length].withValues(alpha: fade * 0.95);
      canvas.drawCircle(center, radius, paint);
      canvas.drawCircle(
        center.translate(-radius * 0.35, -radius * 0.45),
        radius * 0.35,
        Paint()..color = Colors.white.withValues(alpha: fade * 0.75),
      );
    }

    final ripplePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = const Color(0xFF4A90E2).withValues(alpha: fade * 0.65);
    canvas.drawOval(
      Rect.fromCenter(
        center: origin,
        width: 24 + 70 * progress,
        height: 8 + 18 * progress,
      ),
      ripplePaint,
    );
  }

  void _paintFertilizer(Canvas canvas, Offset origin, double fade) {
    const dotColors = [
      Color(0xFF8B5A2B),
      Color(0xFFA66A32),
      Color(0xFFD29A54),
      Color(0xFF6F4524),
    ];

    for (var index = 0; index < 28; index++) {
      final lane = index - 13.5;
      final phase = (progress + index * 0.025).clamp(0.0, 1.0).toDouble();
      final horizontal = lane * 7.5 * phase;
      final lift = (68 + (index % 6) * 17) * phase;
      final gravity = 50 * phase * phase;
      final center = origin + Offset(horizontal, -lift + gravity);
      canvas.drawCircle(
        center,
        2.5 + (index % 3) * 0.8,
        Paint()
          ..color = dotColors[index % dotColors.length].withValues(
            alpha: fade * 0.9,
          ),
      );
    }

    for (var index = 0; index < 9; index++) {
      final direction = index - 4;
      final phase = (progress + index * 0.045).clamp(0.0, 1.0).toDouble();
      final position =
          origin +
          Offset(
            direction * 23 * phase,
            -(84 + (index % 3) * 24) * phase + 48 * phase * phase,
          );
      final textPainter = TextPainter(
        text: TextSpan(
          text: '💩',
          style: TextStyle(fontSize: (22 + (index % 3) * 4).toDouble()),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(
        canvas,
        position - Offset(textPainter.width / 2, textPainter.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CareCelebrationPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.type != type;
  }
}
