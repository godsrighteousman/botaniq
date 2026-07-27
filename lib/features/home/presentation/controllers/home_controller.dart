import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/care_task_planner.dart';
import '../models/home_models.dart';
import '../../../../core/services/weather_service.dart';

/// Home ekranının tüm state yönetimini sağlayan controller.
/// ValueNotifier tabanlı reaktif yapı ile widget'lar sadece
/// ilgilendikleri veriyi dinler.
class HomeController {
  HomeController() {
    _init();
  }

  // ── Public ValueNotifier'lar ──
  final ValueNotifier<bool> isLoading = ValueNotifier(true);
  final ValueNotifier<String> userName = ValueNotifier('');
  final ValueNotifier<DateTime> selectedDate = ValueNotifier(DateTime.now());
  final ValueNotifier<List<CareTask>> filteredTasks = ValueNotifier([]);
  final ValueNotifier<List<CareTask>> tomorrowTasks = ValueNotifier([]);
  final ValueNotifier<List<PlantSummary>> plants = ValueNotifier([]);
  final ValueNotifier<List<Map<String, dynamic>>> sickPlants = ValueNotifier(
    [],
  );
  final ValueNotifier<Map<String, bool>> daysWithTasks = ValueNotifier({});

  // Weather
  final ValueNotifier<String> locationName = ValueNotifier('');
  final ValueNotifier<double> weatherTemp = ValueNotifier(0);
  final ValueNotifier<String> weatherCondition = ValueNotifier('Sunny');
  final ValueNotifier<String> weatherTip = ValueNotifier('');

  // ── Internal ──
  List<Map<String, dynamic>> _rawPlants = [];
  final List<DateTime> weekDays = [];

  bool get hasPlants => plants.value.isNotEmpty;

  // ── Lifecycle ──

  Future<void> _init() async {
    final now = DateTime.now();
    for (int i = 0; i < 14; i++) {
      weekDays.add(now.add(Duration(days: i)));
    }

    // Görevler My Garden bitkilerinden de üretildiği için önce bitkiler yüklenir.
    await _loadUserData();
    await loadTasksForDate(now);
  }

  void dispose() {
    isLoading.dispose();
    userName.dispose();
    selectedDate.dispose();
    filteredTasks.dispose();
    tomorrowTasks.dispose();
    plants.dispose();
    sickPlants.dispose();
    daysWithTasks.dispose();
    locationName.dispose();
    weatherTemp.dispose();
    weatherCondition.dispose();
    weatherTip.dispose();
  }

  // ── Veri Yükleme ──

  Future<void> _loadUserData() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      isLoading.value = false;
      return;
    }
    final results = await Future.wait<Object?>([
      _fetchProfile(user.id),
      _fetchPlants(user.id),
      _fetchSickPlants(user.id),
    ]);

    final profile = results[0] as Map<String, dynamic>?;
    _rawPlants = results[1] as List<Map<String, dynamic>>;
    sickPlants.value = results[2] as List<Map<String, dynamic>>;

    final rawName =
        profile?['full_name'] ??
        user.userMetadata?['full_name'] ??
        user.userMetadata?['name'] ??
        user.userMetadata?['first_name'] ??
        user.userMetadata?['display_name'] ??
        user.userMetadata?['username'] ??
        '';
    String resolvedName = rawName.toString().trim();
    if (resolvedName.isEmpty) resolvedName = 'Bahçıvan';
    userName.value = resolvedName;

    plants.value = _rawPlants.map(PlantSummary.fromPlantData).toList();
    isLoading.value = false;

    final userLoc = profile?['location'] ?? '';
    _loadWeather(userLoc);
  }

  Future<Map<String, dynamic>?> _fetchProfile(String userId) async {
    try {
      return await Supabase.instance.client
          .from('profiles')
          .select('full_name, location')
          .eq('id', userId)
          .maybeSingle()
          .timeout(const Duration(seconds: 6));
    } catch (error) {
      debugPrint('Profil yüklenemedi: $error');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> _fetchPlants(String userId) async {
    try {
      final result = await Supabase.instance.client
          .from('plants')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false)
          .timeout(const Duration(seconds: 6));
      return List<Map<String, dynamic>>.from(result);
    } catch (error) {
      debugPrint('My Garden bitkileri yüklenemedi: $error');
      return const [];
    }
  }

  Future<List<Map<String, dynamic>>> _fetchSickPlants(String userId) async {
    try {
      final result = await Supabase.instance.client
          .from('sick_plants')
          .select()
          .eq('user_id', userId)
          .eq('status', 'active')
          .order('created_at', ascending: false)
          .timeout(const Duration(seconds: 6));
      return List<Map<String, dynamic>>.from(result);
    } catch (error) {
      debugPrint('Hasta bitkiler yüklenemedi: $error');
      return const [];
    }
  }

  Future<void> _loadWeather(String location) async {
    try {
      final weather = await WeatherService.getWeather(location);
      locationName.value = weather.cityName;
      weatherTemp.value = weather.temperature;
      weatherCondition.value = weather.condition;
      weatherTip.value = weather.tip;
    } catch (_) {}
  }

  // ── Tarih Seçimi ──

  void selectDate(DateTime date) {
    selectedDate.value = date;
    loadTasksForDate(date);
  }

  // ── Görev Yükleme ──

  Future<void> loadTasksForDate(DateTime date) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final now = DateTime.now();
    final today = CareTaskPlanner.startOfLocalDay(now);
    final selected = CareTaskPlanner.startOfLocalDay(date);
    final isToday = selected == today;
    var dbTasks = <CareTask>[];

    try {
      final List<dynamic> result;
      if (isToday) {
        // Geçmiş + bugün + yarın tek sorguda alınır. Yerel gün sınırı UTC
        // olarak gönderilerek timestamptz kayıtlarının günü doğru bulunur.
        final dayAfterTomorrow = today.add(const Duration(days: 2));
        result = await Supabase.instance.client
            .from('care_tasks')
            .select('*, plants(custom_name, name, image_url)')
            .eq('user_id', user.id)
            .eq('is_completed', false)
            .lt('due_date', dayAfterTomorrow.toUtc().toIso8601String())
            .order('due_date')
            .timeout(const Duration(seconds: 6));
      } else {
        final nextDay = selected.add(const Duration(days: 1));
        result = await Supabase.instance.client
            .from('care_tasks')
            .select('*, plants(custom_name, name, image_url)')
            .eq('user_id', user.id)
            .eq('is_completed', false)
            .gte('due_date', selected.toUtc().toIso8601String())
            .lt('due_date', nextDay.toUtc().toIso8601String())
            .order('due_date')
            .timeout(const Duration(seconds: 6));
      }

      dbTasks = result
          .map((r) => CareTask.fromDbRow(r as Map<String, dynamic>))
          .toList();
    } catch (error) {
      // DB erişilemese bile My Garden sulama ihtiyacı gösterilmeye devam eder.
      debugPrint('Bakım görevleri yüklenemedi: $error');
    }

    if (isToday) {
      final buckets = CareTaskPlanner.bucketTodayAndTomorrow(dbTasks, now: now);
      final tomorrow = today.add(const Duration(days: 1));
      filteredTasks.value = CareTaskPlanner.mergeByPlantAndType(
        databaseTasks: buckets.today,
        derivedTasks: _buildPlantWateringTasks(today, now),
      );
      tomorrowTasks.value = CareTaskPlanner.mergeByPlantAndType(
        databaseTasks: buckets.tomorrow,
        derivedTasks: _buildPlantWateringTasks(tomorrow, now),
      );
    } else {
      filteredTasks.value = CareTaskPlanner.mergeByPlantAndType(
        databaseTasks: dbTasks,
        derivedTasks: _buildPlantWateringTasks(selected, now),
      );
      tomorrowTasks.value = [];
    }

    _precomputeDaysWithTasks();
  }

  // ── Bitki Tabanlı Görev Hesaplama ──

  List<CareTask> _buildPlantWateringTasks(DateTime targetDate, DateTime now) {
    return CareTaskPlanner.buildWateringTasks(
      plants: _rawPlants,
      targetDate: targetDate,
      now: now,
    );
  }

  void _precomputeDaysWithTasks() {
    final Map<String, bool> result = {};
    final now = DateTime.now();
    for (final day in weekDays) {
      final key = DateFormat('yyyy-MM-dd').format(day);
      final hasDerived = _buildPlantWateringTasks(day, now).isNotEmpty;
      result[key] = hasDerived;
    }
    final selectedKey = DateFormat('yyyy-MM-dd').format(selectedDate.value);
    if (filteredTasks.value.isNotEmpty) result[selectedKey] = true;
    final tomorrowKey = DateFormat(
      'yyyy-MM-dd',
    ).format(CareTaskPlanner.startOfLocalDay(now).add(const Duration(days: 1)));
    if (tomorrowTasks.value.isNotEmpty) result[tomorrowKey] = true;
    daysWithTasks.value = result;
  }

  // ── Görev Aksiyonları ──

  Future<void> markTaskDone(CareTask task) async {
    final now = DateTime.now();
    final nowUtc = now.toUtc().toIso8601String();
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;
    final normalizedType = CareTaskPlanner.normalizedTaskType(task.taskType);
    var isPersisted = false;

    try {
      if (task.isDerived) {
        if (normalizedType == 'water' && task.plantId.isNotEmpty) {
          await Supabase.instance.client
              .from('plants')
              .update({
                'last_watered_at': now.toIso8601String().substring(0, 10),
              })
              .eq('id', task.plantId);
          isPersisted = true;

          // Sanal görev için bakım geçmişi oluşturmak ikincil bir işlemdir.
          try {
            await Supabase.instance.client.from('care_tasks').insert({
              'plant_id': task.plantId,
              'user_id': user.id,
              'task_type': 'water',
              'due_date': nowUtc,
              'is_completed': true,
              'completed_at': nowUtc,
            });
          } catch (error) {
            debugPrint('Sulama geçmişi eklenemedi: $error');
          }
        }
      } else {
        final sourceIds = task.sourceTaskIds.isEmpty
            ? <String>[task.id]
            : task.sourceTaskIds;
        await Future.wait(
          sourceIds
              .where((id) => id.isNotEmpty)
              .map(
                (id) => Supabase.instance.client
                    .from('care_tasks')
                    .update({'is_completed': true, 'completed_at': nowUtc})
                    .eq('id', id),
              ),
        );
        isPersisted = true;

        // Home'dan tamamlanan sulama My Garden durumunu da günceller.
        if (normalizedType == 'water' && task.plantId.isNotEmpty) {
          try {
            await Supabase.instance.client
                .from('plants')
                .update({
                  'last_watered_at': now.toIso8601String().substring(0, 10),
                })
                .eq('id', task.plantId);
          } catch (error) {
            debugPrint('Bitkinin sulama tarihi güncellenemedi: $error');
          }
        }
      }
    } catch (error) {
      debugPrint('Bakım görevi tamamlanamadı: $error');
    }

    if (!isPersisted) return;

    filteredTasks.value = filteredTasks.value
        .where((visibleTask) => visibleTask.id != task.id)
        .toList();
    tomorrowTasks.value = tomorrowTasks.value
        .where((visibleTask) => visibleTask.id != task.id)
        .toList();

    // Bitki durumu değiştikten sonra görevleri taze veriden yeniden hesapla.
    await _loadUserData();
    await loadTasksForDate(selectedDate.value);
  }

  /// Verileri yeniden yükler (pull-to-refresh için).
  Future<void> refresh() async {
    isLoading.value = true;
    await _loadUserData();
    await loadTasksForDate(selectedDate.value);
  }

  /// Seçili güne göre dinamik başlık döndürür.
  String taskSectionTitle(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selected = DateTime(date.year, date.month, date.day);
    if (selected == today) return "Today's Tasks";
    if (selected == today.add(const Duration(days: 1))) {
      return 'Tomorrow Tasks';
    }
    return '${DateFormat('d MMM').format(date)} Tasks';
  }
}
