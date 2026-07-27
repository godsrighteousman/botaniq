import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  final ValueNotifier<List<CareTask>> overdueTasks = ValueNotifier([]);
  final ValueNotifier<List<CareTask>> tomorrowTasks = ValueNotifier([]);
  final ValueNotifier<List<PlantSummary>> plants = ValueNotifier([]);
  final ValueNotifier<List<Map<String, dynamic>>> sickPlants = ValueNotifier([]);
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

  void _init() {
    final now = DateTime.now();
    for (int i = 0; i < 14; i++) {
      weekDays.add(now.add(Duration(days: i)));
    }
    // Paralel başlat
    Future.wait([_loadUserData(), loadTasksForDate(now)]);
  }

  void dispose() {
    isLoading.dispose();
    userName.dispose();
    selectedDate.dispose();
    filteredTasks.dispose();
    overdueTasks.dispose();
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
    try {
      final results = await Future.wait([
        Supabase.instance.client
            .from('profiles')
            .select('full_name, location')
            .eq('id', user.id)
            .maybeSingle()
            .timeout(const Duration(seconds: 6)),
        Supabase.instance.client
            .from('plants')
            .select()
            .eq('user_id', user.id)
            .order('created_at', ascending: false)
            .timeout(const Duration(seconds: 6)),
        Supabase.instance.client
            .from('sick_plants')
            .select()
            .eq('user_id', user.id)
            .eq('status', 'active')
            .order('created_at', ascending: false)
            .timeout(const Duration(seconds: 6)),
      ]);

      final profile = results[0] as Map<String, dynamic>?;
      final plantsData = results[1] as List;
      final sickPlantsData = results[2] as List;

      // Kullanıcı adını çözümle
      final rawName = profile?['full_name'] ??
          user.userMetadata?['full_name'] ??
          user.userMetadata?['name'] ??
          user.userMetadata?['first_name'] ??
          user.userMetadata?['display_name'] ??
          user.userMetadata?['username'] ??
          '';
      String resolvedName = rawName.toString().trim();
      if (resolvedName.isEmpty) resolvedName = 'Bahçıvan';
      userName.value = resolvedName;

      // Bitkileri dönüştür
      _rawPlants = List<Map<String, dynamic>>.from(plantsData);
      plants.value = _rawPlants.map(PlantSummary.fromPlantData).toList();
      sickPlants.value = List<Map<String, dynamic>>.from(sickPlantsData);
      isLoading.value = false;

      // Hava durumu arka planda
      final userLoc = profile?['location'] ?? '';
      _loadWeather(userLoc);
    } catch (_) {
      isLoading.value = false;
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

    final dateStr = DateFormat('yyyy-MM-dd').format(date);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selected = DateTime(date.year, date.month, date.day);
    final isToday = selected == today;

    try {
      // Seçili gün DB görevleri
      final result = await Supabase.instance.client
          .from('care_tasks')
          .select('*, plants(custom_name, name, image_url)')
          .eq('user_id', user.id)
          .gte('due_date', '${dateStr}T00:00:00')
          .lt('due_date', '${dateStr}T23:59:59')
          .order('due_date')
          .timeout(const Duration(seconds: 6));

      final dbTasks = (result as List)
          .map((r) => CareTask.fromDbRow(r as Map<String, dynamic>))
          .where((t) => !t.isCompleted) // Sadece tamamlanmamış görevler
          .toList();

      final dbPlantWaterNames = dbTasks
          .where((t) => t.taskType.toLowerCase() == 'water' || t.taskType.toLowerCase() == 'watering')
          .map((t) => t.plantName.toLowerCase())
          .toSet();

      final plantTasks = _buildPlantDerivedTasks(date).where((t) {
        if (t.taskType.toLowerCase() == 'water' || t.taskType.toLowerCase() == 'watering') {
          return !dbPlantWaterNames.contains(t.plantName.toLowerCase());
        }
        return true;
      }).toList();

      final allTasks = [...dbTasks, ...plantTasks];

      filteredTasks.value = allTasks;

      // Overdue görevler (sadece bugün seçiliyse)
      if (isToday) {
        await _loadOverdueTasks(user.id, today);
      } else {
        overdueTasks.value = [];
      }

      // Yarın görevleri (sadece bugün seçiliyse)
      if (isToday) {
        final tomorrowDate = today.add(const Duration(days: 1));
        final tomorrowStr = DateFormat('yyyy-MM-dd').format(tomorrowDate);
        try {
          final tResult = await Supabase.instance.client
              .from('care_tasks')
              .select('*, plants(custom_name, name, image_url)')
              .eq('user_id', user.id)
              .gte('due_date', '${tomorrowStr}T00:00:00')
              .lt('due_date', '${tomorrowStr}T23:59:59')
              .order('due_date')
              .timeout(const Duration(seconds: 6));
          final tDbTasks = (tResult as List)
              .map((r) => CareTask.fromDbRow(r as Map<String, dynamic>))
              .where((t) => !t.isCompleted)
              .toList();
          final tPlantTasks = _buildPlantDerivedTasks(tomorrowDate);
          tomorrowTasks.value = [...tDbTasks, ...tPlantTasks];
        } catch (_) {
          tomorrowTasks.value = [];
        }
      } else {
        tomorrowTasks.value = [];
      }

      _precomputeDaysWithTasks();
    } catch (_) {}
  }

  /// Tüm gecikmiş görevleri yükler (bugünden önceki tamamlanmamış görevler).
  Future<void> _loadOverdueTasks(String userId, DateTime today) async {
    try {
      final todayStr = DateFormat('yyyy-MM-dd').format(today);
      final result = await Supabase.instance.client
          .from('care_tasks')
          .select('*, plants(custom_name, name, image_url)')
          .eq('user_id', userId)
          .eq('is_completed', false)
          .lt('due_date', '${todayStr}T00:00:00')
          .order('due_date')
          .timeout(const Duration(seconds: 6));

      final dbOverdue = (result as List).map((r) =>
          CareTask.fromDbRow(r as Map<String, dynamic>)).toList();

      final plantOverdue = _buildOverduePlantTasks(today);

      overdueTasks.value = [...dbOverdue, ...plantOverdue];
    } catch (_) {
      overdueTasks.value = [];
    }
  }

  // ── Bitki Tabanlı Görev Hesaplama ──

  List<CareTask> _buildPlantDerivedTasks(DateTime targetDate) {
    final target = DateTime(targetDate.year, targetDate.month, targetDate.day);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final isTargetToday = target == today;
    final List<CareTask> tasks = [];

    for (final plant in _rawPlants) {
      final plantName = plant['custom_name'] ?? plant['name'] ?? 'My Plant';
      final imageUrl = plant['image_url'] ?? '';
      final lastWateredStr = plant['last_watered_at'] as String?;

      if (lastWateredStr == null || DateTime.tryParse(lastWateredStr) == null) {
        // Son sulama tarihi yoksa veya geçersizse (hiç sulanmamışsa) bugün sulanması gerekir!
        if (isTargetToday) {
          tasks.add(CareTask.derived(
            id: 'plant_water_${plant['id']}',
            plantName: plantName,
            taskType: 'Water',
            amount: plant['water_requirement'] ?? '250ml',
            instruction: 'Time to water your $plantName!',
            imageUrl: imageUrl,
            dueDate: today,
          ));
        }
        continue;
      }

      final lastWatered = DateTime.tryParse(lastWateredStr)!;

      final waterInterval = (plant['watering_interval_days'] as int?) ?? 7;

      // Sulama kontrolü
      final nextWater = DateTime(
        lastWatered.year,
        lastWatered.month,
        lastWatered.day,
      ).add(Duration(days: waterInterval));

      bool shouldAddWater = false;
      if (isTargetToday) {
        // Bugün seçiliyse: Sulama zamanı geçmiş (overdue) veya bugün olanları Today listesinde göster
        shouldAddWater = nextWater.isBefore(today) || nextWater == today;
      } else {
        // Başka gün seçiliyse: Sadece o güne aitse göster
        shouldAddWater = nextWater == target;
      }

      if (shouldAddWater) {
        tasks.add(CareTask.derived(
          id: 'plant_water_${plant['id']}',
          plantName: plantName,
          taskType: 'Water',
          amount: plant['water_requirement'] ?? '250ml',
          instruction: 'Time to water your $plantName!',
          imageUrl: imageUrl,
          dueDate: nextWater,
        ));
      }

      // Gübreleme kontrolü (21 gün aralık)
      const fertilizeInterval = 21;
      final nextFertilize = DateTime(
        lastWatered.year,
        lastWatered.month,
        lastWatered.day,
      ).add(const Duration(days: fertilizeInterval));

      bool shouldAddFert = false;
      if (isTargetToday) {
        shouldAddFert = nextFertilize.isBefore(today) || nextFertilize == today;
      } else {
        shouldAddFert = nextFertilize == target;
      }

      if (shouldAddFert) {
        tasks.add(CareTask.derived(
          id: 'plant_fert_${plant['id']}',
          plantName: plantName,
          taskType: 'Fertilize',
          amount: 'Liquid Fertilizer',
          instruction: 'Time to fertilize your $plantName!',
          imageUrl: imageUrl,
          dueDate: nextFertilize,
        ));
      }
    }
    return tasks;
  }

  /// Bugünden önceki gecikmiş bitki tabanlı görevleri hesaplar.
  /// (Artık today tasks içinde gösterdiğimiz için kafa karışıklığını önlemek adına boş dönüyoruz)
  List<CareTask> _buildOverduePlantTasks(DateTime today) {
    return const [];
  }

  void _precomputeDaysWithTasks() {
    final Map<String, bool> result = {};
    for (final day in weekDays) {
      final key = DateFormat('yyyy-MM-dd').format(day);
      final hasDerived = _buildPlantDerivedTasks(day).isNotEmpty;
      result[key] = hasDerived;
    }
    final selectedKey = DateFormat('yyyy-MM-dd').format(selectedDate.value);
    if (filteredTasks.value.isNotEmpty) result[selectedKey] = true;
    final now = DateTime.now();
    final tomorrowKey = DateFormat('yyyy-MM-dd').format(
      DateTime(now.year, now.month, now.day).add(const Duration(days: 1)),
    );
    if (tomorrowTasks.value.isNotEmpty) result[tomorrowKey] = true;
    daysWithTasks.value = result;
  }

  // ── Görev Aksiyonları ──

  Future<void> markTaskDone(String taskId) async {
    final now = DateTime.now();
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    if (taskId.startsWith('plant_water_') || taskId.startsWith('overdue_water_')) {
      final plantId = taskId
          .replaceFirst('plant_water_', '')
          .replaceFirst('overdue_water_', '');
      try {
        // 1. Update last_watered_at of the plant to today (formatted as yyyy-MM-dd)
        await Supabase.instance.client
            .from('plants')
            .update({'last_watered_at': now.toIso8601String().substring(0, 10)})
            .eq('id', plantId);

        // 2. Insert completed care task for history
        await Supabase.instance.client.from('care_tasks').insert({
          'plant_id': plantId,
          'user_id': user.id,
          'task_type': 'water',
          'due_date': now.toIso8601String(),
          'is_completed': true,
          'completed_at': now.toIso8601String(),
        });
      } catch (e) {
        debugPrint("Error updating derived water task: $e");
      }
    } else if (taskId.startsWith('plant_fert_')) {
      final plantId = taskId.replaceFirst('plant_fert_', '');
      try {
        // Insert completed fertilize task
        await Supabase.instance.client.from('care_tasks').insert({
          'plant_id': plantId,
          'user_id': user.id,
          'task_type': 'fertilize',
          'due_date': now.toIso8601String(),
          'is_completed': true,
          'completed_at': now.toIso8601String(),
        });
      } catch (e) {
        debugPrint("Error updating derived fertilize task: $e");
      }
    } else {
      // Database care task
      try {
        await Supabase.instance.client
            .from('care_tasks')
            .update({
              'is_completed': true,
              'completed_at': now.toIso8601String(),
            })
            .eq('id', taskId);
      } catch (e) {
        debugPrint("Error updating database task: $e");
      }
    }

    // Lokal state güncelle: Tamamlanan görevi listeden çıkar
    final updated = List<CareTask>.from(filteredTasks.value);
    updated.removeWhere((t) => t.id == taskId);
    filteredTasks.value = updated;

    // Overdue listesinden de çıkar
    final updatedOverdue = List<CareTask>.from(overdueTasks.value);
    updatedOverdue.removeWhere((t) => t.id == taskId);
    overdueTasks.value = updatedOverdue;

    // Bitkilerin sulama durumunun güncellenmesi için verileri arka planda yenile
    _loadUserData();
    _precomputeDaysWithTasks();
  }

  /// Verileri yeniden yükler (pull-to-refresh için).
  Future<void> refresh() async {
    isLoading.value = true;
    await Future.wait([_loadUserData(), loadTasksForDate(selectedDate.value)]);
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
