import '../../../core/services/watering_schedule_service.dart';
import '../presentation/models/home_models.dart';

class CareTaskBuckets {
  const CareTaskBuckets({required this.today, required this.tomorrow});

  final List<CareTask> today;
  final List<CareTask> tomorrow;
}

/// Bakım görevlerini yerel takvim günlerine göre sınıflandırır.
///
/// Veritabanındaki [CareTask] kayıtları gübreleme için kaynak kabul edilir.
/// Bitki verisinden yalnızca, program kaydı oluşturulamamış olabilecek sulama
/// ihtiyacı türetilir.
class CareTaskPlanner {
  const CareTaskPlanner._();

  static DateTime startOfLocalDay(DateTime value) {
    return WateringScheduleService.startOfLocalDay(value);
  }

  static bool isSameLocalDay(DateTime first, DateTime second) {
    return WateringScheduleService.isSameLocalDay(first, second);
  }

  /// Geçmiş ve bugün vadeli görevleri Today'e, ertesi gün vadeli görevleri
  /// Tomorrow'a koyar. Daha ileri tarihli ve tamamlanmış görevleri dışarıda
  /// bırakır.
  static CareTaskBuckets bucketTodayAndTomorrow(
    Iterable<CareTask> tasks, {
    required DateTime now,
  }) {
    final today = startOfLocalDay(now);
    final tomorrow = today.add(const Duration(days: 1));
    final dayAfterTomorrow = tomorrow.add(const Duration(days: 1));
    final todayTasks = <CareTask>[];
    final tomorrowTasks = <CareTask>[];

    for (final task in tasks) {
      if (task.isCompleted || task.dueDate == null) continue;
      final due = startOfLocalDay(task.dueDate!);

      if (due.isBefore(tomorrow)) {
        todayTasks.add(task);
      } else if (due.isBefore(dayAfterTomorrow)) {
        tomorrowTasks.add(task);
      }
    }

    return CareTaskBuckets(
      today: _sortByDueDate(todayTasks),
      tomorrow: _sortByDueDate(tomorrowTasks),
    );
  }

  /// Aynı bitki ve bakım türüne ait birden fazla kaydı tek kartta birleştirir.
  /// Veritabanı kaydı varsa sanal göreve tercih edilir; birleşen veritabanı
  /// kimlikleri tamamlanma sırasında birlikte güncellenmek üzere korunur.
  static List<CareTask> mergeByPlantAndType({
    required Iterable<CareTask> databaseTasks,
    required Iterable<CareTask> derivedTasks,
  }) {
    final merged = <String, CareTask>{};

    void addTask(CareTask task) {
      if (task.isCompleted) return;
      final key = _dedupeKey(task);
      final existing = merged[key];

      if (existing == null) {
        merged[key] = task;
        return;
      }

      final sourceIds = <String>{
        ...existing.sourceTaskIds,
        ...task.sourceTaskIds,
      };
      merged[key] = existing.copyWith(sourceTaskIds: sourceIds.toList());
    }

    for (final task in _sortByDueDate(databaseTasks)) {
      addTask(task);
    }
    for (final task in _sortByDueDate(derivedTasks)) {
      addTask(task);
    }

    return _sortByDueDate(merged.values);
  }

  /// My Garden bitkilerinin sulama tarihinden seçili gün için yedek görevler
  /// üretir. Bugün seçiliyken gecikmiş sulamalar da aynı Today listesine girer.
  static List<CareTask> buildWateringTasks({
    required Iterable<Map<String, dynamic>> plants,
    required DateTime targetDate,
    required DateTime now,
  }) {
    final today = startOfLocalDay(now);
    final target = startOfLocalDay(targetDate);
    final isToday = target == today;
    final tasks = <CareTask>[];

    for (final plant in plants) {
      final plantId = plant['id']?.toString() ?? '';
      if (plantId.isEmpty) continue;

      final plantName = (plant['custom_name'] ?? plant['name'] ?? 'My Plant')
          .toString();
      final imageUrl = plant['image_url']?.toString() ?? '';
      final schedule = WateringScheduleService.fromPlant(plant, now: now);
      final dueDate = schedule.dueDate;

      final isDue = isToday
          ? schedule.isDue
          : isSameLocalDay(dueDate, target);
      if (!isDue) continue;

      final waterRequirement = plant['water_requirement']?.toString().trim();
      tasks.add(
        CareTask.derived(
          id: 'plant_water_$plantId',
          plantId: plantId,
          plantName: plantName,
          taskType: 'Water',
          amount: waterRequirement == null || waterRequirement.isEmpty
              ? '250ml'
              : waterRequirement,
          instruction: 'Time to water your $plantName!',
          imageUrl: imageUrl,
          dueDate: dueDate,
        ),
      );
    }

    return _sortByDueDate(tasks);
  }

  static String normalizedTaskType(String taskType) {
    switch (taskType.trim().toLowerCase()) {
      case 'water':
      case 'watering':
        return 'water';
      case 'fertilize':
      case 'fertilizer':
      case 'fertilizing':
        return 'fertilize';
      default:
        return taskType.trim().toLowerCase();
    }
  }

  static String _dedupeKey(CareTask task) {
    final owner = task.plantId.isEmpty ? 'task:${task.id}' : task.plantId;
    return '$owner|${normalizedTaskType(task.taskType)}';
  }

  static List<CareTask> _sortByDueDate(Iterable<CareTask> tasks) {
    final sorted = List<CareTask>.from(tasks);
    sorted.sort((first, second) {
      final firstDue = first.dueDate;
      final secondDue = second.dueDate;
      if (firstDue == null && secondDue == null) return 0;
      if (firstDue == null) return 1;
      if (secondDue == null) return -1;
      return firstDue.compareTo(secondDue);
    });
    return sorted;
  }
}
