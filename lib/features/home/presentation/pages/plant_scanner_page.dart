import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:botaniq/l10n/app_localizations.dart';
import 'package:camera/camera.dart';

import '../../../../core/services/openai_service.dart';
import '../../../../core/services/search_history_service.dart';
import '../../../garden/presentation/pages/add_plant_wizard.dart';

class PlantScannerPage extends StatefulWidget {
  const PlantScannerPage({super.key});

  @override
  State<PlantScannerPage> createState() => _PlantScannerPageState();
}

class _PlantScannerPageState extends State<PlantScannerPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scanAnimation;

  final Color _accentGreen = const Color(0xFF0ED761);

  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  bool _isIdentifying = false;
  bool _isMushroomMode = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scanAnimation = Tween<double>(begin: 0.1, end: 0.9).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras != null && _cameras!.isNotEmpty) {
        // Genellikle 0 arka kameradır
        _cameraController = CameraController(
          _cameras![0],
          ResolutionPreset.high,
          enableAudio: false,
        );

        await _cameraController!.initialize();

        if (mounted) {
          setState(() {
            _isCameraInitialized = true;
          });
        }
      }
    } catch (e) {
      debugPrint("Kamera başlatma hatası: $e");
    }
  }

  Future<void> _takePhoto() async {
    if (!_isCameraInitialized || _cameraController == null || _isIdentifying) {
      return;
    }

    try {
      setState(() {
        _isIdentifying = true;
      });
      _animationController.repeat(reverse: true);

      // Fotoğrafı çekiyoruz
      final XFile photo = await _cameraController!.takePicture();
      final base64Image = await _resizeAndEncodeImage(photo.path);

      // OpenAI servisine gönder
      debugPrint("Fotoğraf çekildi. OpenAI'a gönderiliyor... Lütfen bekleyin.");
      final result = await OpenAIService.identifyPlant(
        base64Image,
        isMushroom: _isMushroomMode,
      );

      if (mounted) {
        if (result != null) {
          // Arama/tarama geçmişine ekle
          SearchHistoryService.addRecord(result);
          // İşlem başarılı, dialog göster
          _showResultDialog(result, photo.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.scannerFailed),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      }

      // Animasyonu ve durumu sıfırla
      if (mounted) {
        setState(() {
          _isIdentifying = false;
        });
        _animationController.stop();
      }
    } catch (e) {
      debugPrint("Fotoğraf çekme hatası: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.scannerError(e.toString()),
            ),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
      setState(() {
        _isIdentifying = false;
      });
      _animationController.stop();
    }
  }

  Future<String> _resizeAndEncodeImage(String imagePath) async {
    try {
      final File imageFile = File(imagePath);
      final Uint8List originalBytes = await imageFile.readAsBytes();

      // Decode the image first to find its original size
      final ui.Codec nativeCodec = await ui.instantiateImageCodec(
        originalBytes,
      );
      final ui.FrameInfo frameInfo = await nativeCodec.getNextFrame();
      final ui.Image originalImage = frameInfo.image;

      const int maxDimension = 512;
      int originalWidth = originalImage.width;
      int originalHeight = originalImage.height;
      int targetWidth;
      int targetHeight;

      if (originalWidth > originalHeight) {
        targetWidth = maxDimension;
        targetHeight = (originalHeight * maxDimension / originalWidth).round();
      } else {
        targetHeight = maxDimension;
        targetWidth = (originalWidth * maxDimension / originalHeight).round();
      }

      // Draw the image scaled down using Canvas
      final ui.PictureRecorder recorder = ui.PictureRecorder();
      final ui.Canvas canvas = ui.Canvas(recorder);
      final ui.Paint paint = ui.Paint()
        ..filterQuality = ui.FilterQuality.medium;

      canvas.drawImageRect(
        originalImage,
        ui.Rect.fromLTWH(
          0,
          0,
          originalWidth.toDouble(),
          originalHeight.toDouble(),
        ),
        ui.Rect.fromLTWH(0, 0, targetWidth.toDouble(), targetHeight.toDouble()),
        paint,
      );

      final ui.Picture picture = recorder.endRecording();
      final ui.Image resizedImage = await picture.toImage(
        targetWidth,
        targetHeight,
      );

      final ByteData? byteData = await resizedImage.toByteData(
        format: ui.ImageByteFormat.png,
      );
      if (byteData != null) {
        final compressedBytes = byteData.buffer.asUint8List();
        debugPrint(
          "Görsel optimize edildi (token tasarrufu). Boyut: ${originalBytes.lengthInBytes} -> ${compressedBytes.lengthInBytes} byte.",
        );
        return base64Encode(compressedBytes);
      }
    } catch (e) {
      debugPrint(
        "Görsel küçültme hatası: $e. Sıkıştırılmamış görsel gönderiliyor.",
      );
    }
    try {
      final bytes = await File(imagePath).readAsBytes();
      return base64Encode(bytes);
    } catch (_) {}
    return '';
  }

  @override
  void dispose() {
    _animationController.dispose();
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Gerçek Kamera Görüntüsü Katmanı
          Positioned.fill(
            child: _isCameraInitialized && _cameraController != null
                ? CameraPreview(_cameraController!)
                : const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
          ),

          // Odaklanmayı artırmak için hafif siyah katman
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.2)),
          ),

          // Ortadaki Odaklanma Köşeleri
          Center(
            child: Container(
              width: 250,
              height: 350,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: _isIdentifying
                      ? 0
                      : 1, // Tarama sırasında border'ı gizleyebiliriz
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  _buildCorner(Alignment.topLeft),
                  _buildCorner(Alignment.topRight),
                  _buildCorner(Alignment.bottomLeft),
                  _buildCorner(Alignment.bottomRight),
                ],
              ),
            ),
          ),

          // Tarama Çizgisi ve Animasyonu (Sadece tanımlanıyorken gösteriyoruz)
          if (_isIdentifying)
            AnimatedBuilder(
              animation: _scanAnimation,
              builder: (context, child) {
                final topOffset =
                    MediaQuery.of(context).size.height * _scanAnimation.value;
                return Positioned(
                  top: topOffset,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Container(
                        height: 3,
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                          color: _accentGreen,
                          boxShadow: [
                            BoxShadow(
                              color: _accentGreen.withOpacity(0.8),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 80,
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              _accentGreen.withOpacity(0.4),
                              _accentGreen.withOpacity(0.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

          // Üst Header (Geri dön butonu vb.)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.flash_off,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Tür Seçimi (Mantar veya Bitki)
          if (!_isIdentifying)
            Positioned(
              bottom: 140,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _isMushroomMode = false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: !_isMushroomMode
                            ? _accentGreen
                            : Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: !_isMushroomMode
                              ? _accentGreen
                              : Colors.white.withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.local_florist,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            l10n.scannerPlant,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () => setState(() => _isMushroomMode = true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: _isMushroomMode
                            ? _accentGreen
                            : Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: _isMushroomMode
                              ? _accentGreen
                              : Colors.white.withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.forest,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            l10n.scannerMushroom,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Alt kısımdaki Buton veya Metin
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Center(
              child: _isIdentifying
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                _accentGreen,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            _isMushroomMode
                                ? l10n.scannerIdentifyingMushroom
                                : l10n.scannerIdentifyingPlant,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : GestureDetector(
                      onTap: _takePhoto,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: _accentGreen,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          l10n.scannerCapture,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCorner(Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          border: Border(
            top:
                alignment == Alignment.topLeft ||
                    alignment == Alignment.topRight
                ? BorderSide(color: _accentGreen, width: 3)
                : BorderSide.none,
            bottom:
                alignment == Alignment.bottomLeft ||
                    alignment == Alignment.bottomRight
                ? BorderSide(color: _accentGreen, width: 3)
                : BorderSide.none,
            left:
                alignment == Alignment.topLeft ||
                    alignment == Alignment.bottomLeft
                ? BorderSide(color: _accentGreen, width: 3)
                : BorderSide.none,
            right:
                alignment == Alignment.topRight ||
                    alignment == Alignment.bottomRight
                ? BorderSide(color: _accentGreen, width: 3)
                : BorderSide.none,
          ),
        ),
      ),
    );
  }

  void _showResultDialog(Map<String, dynamic> data, String imagePath) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            data['name'] ??
                (_isMushroomMode
                    ? l10n.scannerUnknownMushroom
                    : l10n.scannerUnknownPlant),
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['species'] ?? '',
                  style: GoogleFonts.inter(
                    color: _accentGreen,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  data['description'] ?? '',
                  style: GoogleFonts.inter(color: Colors.white70),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(
                      _isMushroomMode ? Icons.location_on : Icons.water_drop,
                      color: _isMushroomMode ? Colors.orange : Colors.blue,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        data['water_needs'] ?? '',
                        style: GoogleFonts.inter(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      _isMushroomMode ? Icons.warning_rounded : Icons.wb_sunny,
                      color: _isMushroomMode ? Colors.red : Colors.orange,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        data['light_needs'] ?? '',
                        style: GoogleFonts.inter(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                l10n.commonClose,
                style: GoogleFonts.inter(
                  color: _accentGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: _accentGreen),
              onPressed: () {
                Navigator.pop(context); // Dialog'u kapat
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddPlantWizard(plantData: data, imagePath: imagePath),
                  ),
                );
              },
              child: Text(
                l10n.plantAddGardenAction,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
