import 'package:supabase_flutter/supabase_flutter.dart';

import 'care_notification_service.dart';

/// Bitki bakım aksiyonlarını (sulama vb.) tek bir yerden yönetir.
///
/// `plant_detail_page.dart`'ın "Şimdi Sula" butonu ve Inbox ekranındaki
/// hızlı sulama aksiyonu aynı mantığı paylaşır — davranış tek yerde tanımlı
/// kalır, iki ekran arasında kopya kod oluşmaz.
class PlantCareActionService {
  PlantCareActionService._();

  /// Bir bitkiyi "şimdi sulandı" olarak işaretler:
  /// 1) plants.last_watered_at'i günceller,
  /// 2) o bitki için bekleyen sulama görevlerini tamamlanmış sayar,
  /// 3) gerçek sulama geçmişine tamamlanmış bir kayıt ekler,
  /// 4) zamanlanmış yerel bildirimleri günceller (bkz. CareNotificationService).
  static Future<void> markPlantWatered(String plantId) async {
    final now = DateTime.now();
    final client = Supabase.instance.client;

    await client
        .from('plants')
        .update({'last_watered_at': now.toIso8601String().substring(0, 10)})
        .eq('id', plantId);

    await client
        .from('care_tasks')
        .update({
          'is_completed': true,
          'completed_at': now.toUtc().toIso8601String(),
        })
        .eq('plant_id', plantId)
        .eq('task_type', 'water')
        .eq('is_completed', false)
        .lte('due_date', now.toUtc().toIso8601String());

    final userId = client.auth.currentUser?.id;
    if (userId != null) {
      await client.from('care_tasks').insert({
        'plant_id': plantId,
        'user_id': userId,
        'task_type': 'water',
        'due_date': now.toUtc().toIso8601String(),
        'is_completed': true,
        'completed_at': now.toUtc().toIso8601String(),
      });
    }

    await CareNotificationService.instance.refreshSchedules();
  }
}
