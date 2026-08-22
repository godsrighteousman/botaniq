import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Uygulamanın açılış (splash) ekranı — logo ve marka adını, aşamalı bir
/// giriş animasyonuyla tanıtan, tamamen kararlı/görsel bir an. Gerçek oturum
/// kontrolü burada yapılmaz; bu ekran sadece markanın kısa, özenli bir ilk
/// izlenim bırakması için [SplashGate] tarafından minimum bir süre gösterilir.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..forward();

  late final Animation<double> _logoScale = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.0, 0.55, curve: Curves.easeOutBack),
  );
  late final Animation<double> _logoFade = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
  );
  late final Animation<double> _glowFade = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.1, 0.7, curve: Curves.easeOut),
  );
  late final Animation<double> _wordmarkFade = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.45, 0.85, curve: Curves.easeOut),
  );
  late final Animation<Offset> _wordmarkSlide =
      Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.45, 0.85, curve: Curves.easeOutCubic),
        ),
      );
  late final Animation<double> _accentWidth = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.65, 1.0, curve: Curves.easeOutCubic),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1710),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Marka gradyanı — uygulamanın diğer premium/hero kartlarıyla
          // aynı yeşil tonlama dilini kullanır.
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0B1710),
                  Color(0xFF0D3926),
                  Color(0xFF124430),
                ],
                stops: [0.0, 0.55, 1.0],
              ),
            ),
          ),

          // Atmosfer için yumuşak, düşük opaklıklı ışık lekeleri.
          Positioned(
            top: -90,
            left: -70,
            child: _AmbientGlow(
              size: 260,
              color: const Color(0xFF0ED761).withValues(alpha: 0.16),
            ),
          ),
          Positioned(
            bottom: -110,
            right: -60,
            child: _AmbientGlow(
              size: 320,
              color: const Color(0xFFF5B74A).withValues(alpha: 0.08),
            ),
          ),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 168,
                  height: 168,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      FadeTransition(
                        opacity: _glowFade,
                        child: Container(
                          width: 168,
                          height: 168,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(
                              0xFF0ED761,
                            ).withValues(alpha: 0.10),
                          ),
                        ),
                      ),
                      ScaleTransition(
                        scale: _logoScale,
                        child: FadeTransition(
                          opacity: _logoFade,
                          child: Container(
                            width: 116,
                            height: 116,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: const Color(0xFF0F1F17),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF0ED761,
                                  ).withValues(alpha: 0.35),
                                  blurRadius: 44,
                                  offset: const Offset(0, 16),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Image.asset(
                              'assets/images/botaniq_app_icon_v2.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                FadeTransition(
                  opacity: _wordmarkFade,
                  child: SlideTransition(
                    position: _wordmarkSlide,
                    child: Text(
                      'Botaniq',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                AnimatedBuilder(
                  animation: _accentWidth,
                  builder: (context, child) {
                    return Container(
                      width: 64 * _accentWidth.value,
                      height: 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF0ED761), Color(0xFFF5B74A)],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AmbientGlow extends StatelessWidget {
  const _AmbientGlow({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
      ),
    );
  }
}
