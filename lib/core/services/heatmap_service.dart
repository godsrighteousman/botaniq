import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Etkileşim ısı haritası toplama özelliğinin ana anahtarı. `false` yapılırsa
/// [HeatmapTapRegion] hiçbir şey yapmadan doğrudan child'ını döndürür — tüm
/// özellik tek satırla kapatılabilir.
const bool kHeatmapEnabled = true;

/// Kullanıcının dokunduğu noktaları — piksel görüntü DEĞİL, sadece ekrana
/// göre ORANLI (0.0-1.0) x/y koordinatını — tamamen anonim şekilde toplayan
/// servis. Hiçbir kullanıcı kimliği, oturum ID'si veya görsel içerik
/// gönderilmez; yalnızca ekran adı + normalize koordinat + zaman damgası.
///
/// Kullanıcı Ayarlar'dan açıkça katılmadıkça (varsayılan KAPALI) hiçbir veri
/// toplanmaz veya gönderilmez. Ağ/izin sorunları sessizce yutulur — bu
/// özellik hiçbir koşulda uygulamayı çökertmez veya akışı bloklamaz.
class HeatmapService {
  HeatmapService._();

  static final HeatmapService instance = HeatmapService._();

  static const _optInKey = 'heatmap_opt_in';

  bool? _cachedOptIn;

  /// Kullanıcının ısı haritası veri toplamaya katılıp katılmadığı.
  Future<bool> get isOptedIn async {
    if (_cachedOptIn != null) return _cachedOptIn!;
    try {
      final prefs = await SharedPreferences.getInstance();
      _cachedOptIn = prefs.getBool(_optInKey) ?? false;
    } catch (_) {
      _cachedOptIn = false;
    }
    return _cachedOptIn!;
  }

  Future<void> setOptIn(bool value) async {
    _cachedOptIn = value;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_optInKey, value);
    } catch (error) {
      debugPrint('Isı haritası tercihi kaydedilemedi: $error');
    }
  }

  /// Bir dokunuşu kaydeder. Tamamen "fire-and-forget" çalışır — hiçbir
  /// zaman `await` edilmesi gerekmez, hata durumunda UI'a hiçbir şey
  /// yansımaz.
  void recordTap({
    required String screenId,
    required Offset localPosition,
    required Size screenSize,
  }) {
    if (!kHeatmapEnabled) return;
    if (screenSize.width <= 0 || screenSize.height <= 0) return;
    unawaited(_recordTapAsync(screenId, localPosition, screenSize));
  }

  Future<void> _recordTapAsync(
    String screenId,
    Offset localPosition,
    Size screenSize,
  ) async {
    try {
      if (!await isOptedIn) return;
      final xNorm = (localPosition.dx / screenSize.width).clamp(0.0, 1.0);
      final yNorm = (localPosition.dy / screenSize.height).clamp(0.0, 1.0);
      await Supabase.instance.client
          .from('heatmap_taps')
          .insert({
            'screen_id': screenId,
            'x_norm': xNorm,
            'y_norm': yNorm,
            'screen_width': screenSize.width,
            'screen_height': screenSize.height,
          })
          .timeout(const Duration(seconds: 6));
    } catch (error) {
      // Kasıtlı olarak sessiz — kullanıcıya asla hata/uyarı gösterilmez,
      // akış hiçbir şekilde kesilmez.
      debugPrint('Isı haritası verisi gönderilemedi: $error');
    }
  }

  /// Bir ekranın referans düzen görüntüsünü (geliştirici tarafından, tek
  /// seferlik, gerçek kullanıcı verisi OLMADAN) storage'a yükler. Sadece
  /// debug derlemelerinde, [HeatmapTapRegion] içindeki gizli yakalama
  /// butonundan çağrılır — gerçek son kullanıcı akışında hiçbir zaman
  /// tetiklenmez.
  Future<void> uploadReferenceImage({
    required String screenId,
    required Uint8List pngBytes,
  }) async {
    try {
      await Supabase.instance.client.storage
          .from('heatmap_reference_screens')
          .uploadBinary(
            '$screenId.png',
            pngBytes,
            fileOptions: const FileOptions(upsert: true),
          )
          .timeout(const Duration(seconds: 15));
    } catch (error) {
      debugPrint('Referans ekran görüntüsü yüklenemedi: $error');
      rethrow;
    }
  }
}
