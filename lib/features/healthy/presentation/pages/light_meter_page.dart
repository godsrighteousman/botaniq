import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:camera/camera.dart';
import 'package:botaniq/l10n/app_localizations.dart';

class LightMeterPage extends StatefulWidget {
  const LightMeterPage({super.key});

  @override
  State<LightMeterPage> createState() => _LightMeterPageState();
}

class _LightMeterPageState extends State<LightMeterPage>
    with SingleTickerProviderStateMixin {
  final Color _bgHint = const Color(0xFFF9FAF9);

  double _currentLux = 0.0;
  bool _isProcessingImage = false;
  CameraController? _cameraController;
  DateTime _lastProcessTime = DateTime.now();

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _initCameraSensor();
  }

  Future<void> _initCameraSensor() async {
    try {
      final cameras = await availableCameras();

      // Ön kamerayı bul (yoksa ilk rotayı al)
      CameraDescription? frontCamera;
      for (var camera in cameras) {
        if (camera.lensDirection == CameraLensDirection.front) {
          frontCamera = camera;
          break;
        }
      }
      frontCamera ??= cameras.first;

      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.low, // Performans için düşük çözünürlük okuyoruz
        enableAudio: false,
      );

      await _cameraController!.initialize();

      // Canlı görüntüden parlaklık analizi
      _cameraController!.startImageStream((CameraImage image) {
        if (_isProcessingImage) return;

        // Akıcılık ve performans için saniyede yaklaşık 2-3 kare inceliyoruz
        if (DateTime.now().difference(_lastProcessTime).inMilliseconds > 400) {
          _isProcessingImage = true;

          double brightness = _calculateBrightness(image);
          double estimatedLux = _mapBrightnessToLux(brightness);

          if (mounted) {
            setState(() {
              _currentLux = estimatedLux;
            });
          }

          _lastProcessTime = DateTime.now();
          _isProcessingImage = false;
        }
      });
    } catch (e) {
      // Kamera izni yoksa fallback değeri gösterilir
      if (mounted) {
        setState(() {
          _currentLux = 300.0;
        });
      }
    }
  }

  double _calculateBrightness(CameraImage image) {
    int sum = 0;
    int count = 0;

    if (image.format.group == ImageFormatGroup.bgra8888) {
      final bytes = image.planes[0].bytes;
      // Performans için atlayarak piksel matrisi işleme
      for (int i = 0; i < bytes.length; i += 40) {
        sum += bytes[i]; // B
        sum += bytes[i + 1]; // G
        sum += bytes[i + 2]; // R
        count += 3;
      }
    } else if (image.format.group == ImageFormatGroup.yuv420) {
      final bytes = image.planes[0].bytes; // Sadece Y kanalı yeterli
      for (int i = 0; i < bytes.length; i += 10) {
        sum += bytes[i];
        count++;
      }
    } else {
      return 100.0; // Okunamayan format
    }

    return count == 0 ? 0 : sum / count;
  }

  double _mapBrightnessToLux(double brightness) {
    if (brightness <= 0) return 0.0;
    // Kamera parlaklığını (0 - 255) lüks (Lux) değerine çevirme
    double normalized = brightness / 255.0;

    // Işığın gerçekçi dağılım fonksiyonu (Exp Curve)
    double lux = pow(normalized, 3.2) * 20000;

    if (lux < 5) lux = 0; // Çok karanlık
    return lux;
  }

  @override
  void dispose() {
    _cameraController?.stopImageStream();
    _cameraController?.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  String _getLightStatus(AppLocalizations l10n) {
    if (_currentLux < 500) return l10n.lightLow;
    if (_currentLux < 2000) return l10n.lightMedium;
    if (_currentLux < 10000) return l10n.lightHigh;
    return l10n.lightVeryHigh;
  }

  Color _getStatusColor() {
    if (_currentLux < 500) return const Color(0xFF6B7D73);
    if (_currentLux < 2000) return const Color(0xFF4FA976);
    if (_currentLux < 10000) return const Color(0xFFE2A04A);
    return const Color(0xFFEF7C56);
  }

  String _getRecommendation(AppLocalizations l10n) {
    if (_currentLux < 500) return l10n.lightLowRecommendation;
    if (_currentLux < 2000) return l10n.lightMediumRecommendation;
    if (_currentLux < 10000) return l10n.lightHighRecommendation;
    return l10n.lightVeryHighRecommendation;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: _bgHint,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF2C3E35),
            size: 18,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.lightMeterTitle,
          style: GoogleFonts.outfit(
            color: const Color(0xFF2C3E35),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              Text(
                l10n.lightMeterInstructionTitle,
                style: GoogleFonts.inter(
                  color: const Color(0xFF6E6E73),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.lightMeterInstruction,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  color: const Color(0xFF2C3E35),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 60),
              _buildLuxGauge(),
              const SizedBox(height: 60),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFCBD5E1).withOpacity(0.05 * 4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor().withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          _getLightStatus(l10n),
                          key: ValueKey<String>(_getLightStatus(l10n)),
                          style: GoogleFonts.inter(
                            color: _getStatusColor(),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          color: Color(0xFF8B9E93),
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _getRecommendation(l10n),
                            style: GoogleFonts.inter(
                              color: const Color(0xFF6E6E73),
                              fontSize: 14,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLuxGauge() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Pulse Effect
        AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _pulseAnimation.value,
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _getStatusColor().withOpacity(0.05),
                ),
              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _pulseAnimation.value * 0.9,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _getStatusColor().withOpacity(0.1),
                ),
              ),
            );
          },
        ),
        // Core Gauge
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: _getStatusColor(), width: 6),
            boxShadow: [
              BoxShadow(
                color: _getStatusColor().withOpacity(0.3),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wb_sunny_rounded, color: _getStatusColor(), size: 32),
              const SizedBox(height: 8),
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: _currentLux, end: _currentLux),
                duration: const Duration(milliseconds: 400),
                builder: (context, value, child) {
                  return Text(
                    '${value.toInt()}',
                    style: GoogleFonts.outfit(
                      color: const Color(0xFF2C3E35),
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      height: 1.0,
                    ),
                  );
                },
              ),
              Text(
                'LUX',
                style: GoogleFonts.inter(
                  color: const Color(0xFF8B9E93),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
