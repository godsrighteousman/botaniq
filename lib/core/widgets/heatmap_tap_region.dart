import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../services/heatmap_service.dart';

/// Bir ekranı ısı haritası takibi için işaretler.
///
/// Çocuk widget ağacının davranışını (key, controller, callback, layout)
/// HİÇBİR şekilde değiştirmez — sadece üzerine, dokunuşları izleyip anonim
/// koordinat gönderen görünmez, saydam (`translucent`) bir katman ekler.
/// Gerçek dokunuş olayları normal şekilde altındaki widget'lara ulaşmaya
/// devam eder.
///
/// Debug derlemelerinde sağ altta küçük bir "referans görüntü yakala"
/// butonu belirir — bu, geliştiricinin ekranın TASARIM/DÜZEN görüntüsünü
/// (gerçek kullanıcı verisi olmadan, tek seferlik) render edip Supabase
/// Storage'a yüklemesini sağlar. Bu buton `kDebugMode` dışında hiçbir
/// zaman derlenmez/görünmez — gerçek son kullanıcılar asla görmez veya
/// tetiklemez.
class HeatmapTapRegion extends StatefulWidget {
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
  State<HeatmapTapRegion> createState() => _HeatmapTapRegionState();
}

class _HeatmapTapRegionState extends State<HeatmapTapRegion> {
  final GlobalKey _boundaryKey = GlobalKey();
  bool _capturing = false;

  void _handlePointerDown(PointerDownEvent event) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;
    final local = box.globalToLocal(event.position);
    HeatmapService.instance.recordTap(
      screenId: widget.screenId,
      localPosition: local,
      screenSize: box.size,
    );
  }

  Future<void> _captureReferenceImage() async {
    if (_capturing) return;
    setState(() => _capturing = true);
    try {
      final boundary =
          _boundaryKey.currentContext?.findRenderObject()
              as RenderRepaintBoundary?;
      if (boundary == null) return;
      final image = await boundary.toImage(pixelRatio: 2.0);
      final byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      if (byteData == null) return;
      await HeatmapService.instance.uploadReferenceImage(
        screenId: widget.screenId,
        pngBytes: byteData.buffer.asUint8List(),
      );
    } catch (error) {
      debugPrint('Referans görüntü yakalanamadı: $error');
    } finally {
      if (mounted) setState(() => _capturing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!kHeatmapEnabled) return widget.child;

    Widget content = RepaintBoundary(
      key: _boundaryKey,
      child: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: _handlePointerDown,
        child: widget.child,
      ),
    );

    if (kDebugMode) {
      content = Stack(
        children: [
          content,
          PositionedDirectional(
            end: 12,
            bottom: 12,
            child: SafeArea(
              child: FloatingActionButton.small(
                heroTag: 'heatmap_capture_${widget.screenId}',
                backgroundColor: Colors.black87,
                onPressed: _capturing ? null : _captureReferenceImage,
                child: _capturing
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(
                        Icons.camera_alt_outlined,
                        size: 18,
                        color: Colors.white,
                      ),
              ),
            ),
          ),
        ],
      );
    }

    return content;
  }
}
