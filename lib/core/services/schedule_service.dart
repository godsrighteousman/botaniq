import 'package:supabase_flutter/supabase_flutter.dart';

/// Bitki eklendiğinde tarih tabanlı, sulama dışı bakım görevleri oluşturur.
///
/// Sulama görevi ayrıca kaydedilmez; `last_watered_at` ve
/// `watering_interval_days` alanlarından her ekranda dinamik türetilir.
class ScheduleService {
  static final _client = Supabase.instance.client;

  /// [plantId]: plants tablosundaki bitki ID'si
  /// [userId]: oturum açmış kullanıcı ID'si
  static Future<void> createInitialSchedules({
    required String plantId,
    required String userId,
  }) async {
    final now = DateTime.now();
    final tasks = <Map<String, dynamic>>[];

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
}
