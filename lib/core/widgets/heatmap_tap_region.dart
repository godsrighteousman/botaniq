import 'package:flutter/material.dart';

import '../services/heatmap_service.dart';

/// Bir ekranı ısı haritası takibi için işaretler.
///
/// Çocuk widget ağacının davranışını (key, controller, callback, layout)
/// HİÇBİR şekilde değiştirmez — sadece üzerine, dokunuşları izleyip anonim
/// koordinat gönderen görünmez, saydam (`translucent`) bir katman ekler.
/// Gerçek dokunuş olayları normal şekilde altındaki widget'lara ulaşmaya
/// devam eder. Kullanıcıya görünen hiçbir öğe eklemez.
class HeatmapTapRegion extends StatelessWidget {
  const HeatmapTapRegion({
    super.key,
    required this.screenId,
    required this.child,
  });

  /// Bu ekranı benzersiz şekilde tanımlayan, insan-okunur kısa kimlik
  /// (ör. `home`, `garden`). Toplanan her koordinatla birlikte gönderilir.
  final String screenId;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!kHeatmapEnabled) return child;

    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (event) => _handlePointerDown(context, event),
      child: child,
    );
  }

  void _handlePointerDown(BuildContext context, PointerDownEvent event) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;
    final local = box.globalToLocal(event.position);
    HeatmapService.instance.recordTap(
      screenId: screenId,
      localPosition: local,
      screenSize: box.size,
    );
  }
}
