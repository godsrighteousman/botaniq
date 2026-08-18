import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:botaniq/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/locale/locale_provider.dart';
import '../../../../core/measurement/measurement_formatter.dart';
import '../../../../core/services/plant_care_action_service.dart';
import '../../domain/care_task_planner.dart';
import '../models/home_models.dart';

/// Gerçek verilerle çalışan Inbox ekranı: giriş yapan kullanıcının bugün
/// sulanması gereken bitkilerini listeler.
///
/// Veri kaynağı, ana sayfadaki görev hesaplamasıyla aynı tek doğruluk
/// kaynağını (bkz. [CareTaskPlanner.buildWateringTasks]) kullanır — sulama
/// ihtiyacı her zaman plants.last_watered_at + watering_interval_days'ten
/// türetilir, ayrı bir hesaplama icat edilmez.
class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  Color get _background => Theme.of(context).scaffoldBackgroundColor;
  Color get _surface => Theme.of(context).colorScheme.surface;
  Color get _ink => Theme.of(context).colorScheme.onSurface;
  Color get _muted => Theme.of(context).colorScheme.onSurfaceVariant;
  static const _green = Color(0xFF0ED761);

  bool _isLoading = true;
  List<CareTask> _dueTasks = const [];
  final Set<String> _wateringInProgress = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      setState(() => _isLoading = false);
      return;
    }

    setState(() => _isLoading = true);
    try {
      final plants = await Supabase.instance.client
          .from('plants')
          .select(
            'id, custom_name, name, image_url, water_requirement, '
            'last_watered_at, watering_interval_days',
          )
          .eq('user_id', user.id)
          .timeout(const Duration(seconds: 6));

      final now = DateTime.now();
      final dueTasks = CareTaskPlanner.buildWateringTasks(
        plants: plants,
        targetDate: now,
        now: now,
      );

      if (!mounted) return;
      setState(() {
        _dueTasks = dueTasks;
        _isLoading = false;
      });
    } catch (error) {
      debugPrint('Inbox yüklenemedi: $error');
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _markWatered(CareTask task) async {
    if (task.plantId.isEmpty || _wateringInProgress.contains(task.plantId)) {
      return;
    }
    setState(() => _wateringInProgress.add(task.plantId));
    try {
      await PlantCareActionService.markPlantWatered(task.plantId);
      if (!mounted) return;
      setState(() {
        _dueTasks = _dueTasks
            .where((t) => t.plantId != task.plantId)
            .toList();
        _wateringInProgress.remove(task.plantId);
      });
    } catch (error) {
      debugPrint('Sulama işaretlenemedi: $error');
      if (mounted) {
        setState(() => _wateringInProgress.remove(task.plantId));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.plantWaterError(error.toString()),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: _background,
        elevation: 0,
        foregroundColor: _ink,
        title: Text(
          l10n.inboxTitle,
          style: GoogleFonts.outfit(fontWeight: FontWeight.w700),
        ),
      ),
      body: RefreshIndicator(onRefresh: _load, child: _buildBody(l10n)),
    );
  }

  Widget _buildBody(AppLocalizations l10n) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(color: _green));
    }
    if (_dueTasks.isEmpty) {
      return ListView(
        children: [
          const SizedBox(height: 100),
          const Icon(
            Icons.check_circle_outline_rounded,
            color: _green,
            size: 44,
          ),
          const SizedBox(height: 14),
          Center(
            child: Text(
              l10n.inboxEmptyState,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: _muted),
            ),
          ),
        ],
      );
    }
    final measurements = MeasurementFormatter(
      preference: context.watch<LocaleProvider>().measurementPreference,
      formattingLocale: l10n.localeName,
    );
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
      itemCount: _dueTasks.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final task = _dueTasks[index];
        final isBusy = _wateringInProgress.contains(task.plantId);
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: task.isOverdue
                  ? const Color(0xFFFFD9D9)
                  : Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  image: task.imageUrl.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(task.imageUrl),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: task.imageUrl.isEmpty
                    ? const Icon(
                        Icons.local_florist_outlined,
                        color: Color(0xFF86D5A6),
                      )
                    : null,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.plantName.isEmpty
                          ? l10n.plantUnknown
                          : task.plantName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                        color: _ink,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      task.isOverdue
                          ? l10n.homeOverdue
                          : l10n.homeRequiredAmount(
                              measurements.displayLegacyAmount(task.amount),
                            ),
                      style: GoogleFonts.inter(
                        color: task.isOverdue
                            ? const Color(0xFFE96565)
                            : _muted,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 38,
                child: ElevatedButton(
                  onPressed: isBusy ? null : () => _markWatered(task),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _green,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isBusy
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.water_drop_rounded, size: 16),
                            const SizedBox(width: 6),
                            Text(
                              l10n.homeMarkDone,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
