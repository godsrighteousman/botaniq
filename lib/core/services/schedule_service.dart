import 'package:supabase_flutter/supabase_flutter.dart';

/// Bitki eklendiğinde otomatik bakım takvimi oluşturur.
class ScheduleService {
  static final _client = Supabase.instance.client;

  /// [plantId]: plants tablosundaki bitki ID'si
  /// [userId]: oturum açmış kullanıcı ID'si
  /// [wateringIntervalDays]: kaç günde bir sulama (varsayılan 7)
  /// [lastWateredDate]: son sulama tarihi (null ise bugün başlar)
  static Future<void> createInitialSchedules({
    required String plantId,
    required String userId,
    int wateringIntervalDays = 7,
    DateTime? lastWateredDate,
  }) async {
    final now = lastWateredDate ?? DateTime.now();
    final tasks = <Map<String, dynamic>>[];

    // 60 günlük sulama planı
    for (int i = wateringIntervalDays; i <= 60; i += wateringIntervalDays) {
      final dueDate = now.add(Duration(days: i));
      tasks.add({
        'plant_id': plantId,
        'user_id': userId,
        'task_type': 'water',
        'due_date': dueDate.toUtc().toIso8601String(),
        'is_completed': false,
      });
    }

    // 60 günlük gübreleme planı (her 21 günde bir)
    for (int i = 21; i <= 60; i += 21) {
      final dueDate = now.add(Duration(days: i));
      tasks.add({
        'plant_id': plantId,
        'user_id': userId,
        'task_type': 'fertilize',
        'due_date': dueDate.toUtc().toIso8601String(),
        'is_completed': false,
      });
    }

    if (tasks.isEmpty) return;

    await _client.from('care_tasks').insert(tasks);
  }

  /// Son sulama tarihinden sulama aralığına göre "X gün sonra" veya "Bugün" döner
  static String getNextWateringLabel(DateTime? lastWatered, int intervalDays) {
    if (lastWatered == null) return 'Not set';
    final nextDate = lastWatered.add(Duration(days: intervalDays));
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final next = DateTime(nextDate.year, nextDate.month, nextDate.day);
    final diff = next.difference(today).inDays;

    if (diff < 0) return 'Overdue!';
    if (diff == 0) return 'Water today';
    if (diff == 1) return 'Water tomorrow';
    return 'Water in $diff days';
  }
}
