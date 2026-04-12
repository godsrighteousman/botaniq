import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../home/presentation/pages/home_page.dart';

class CreatingSanctuaryPage extends StatefulWidget {
  const CreatingSanctuaryPage({super.key});

  @override
  State<CreatingSanctuaryPage> createState() => _CreatingSanctuaryPageState();
}

class _CreatingSanctuaryPageState extends State<CreatingSanctuaryPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  final Color _accentGreen = const Color(0xFF0ED761);
  final Color _lightBg = const Color(0xFFF5F5F7);

  int _currentTextIndex = 0;
  final List<String> _loadingTexts = [
    'Analyzing your micro-climate...',
    'Customizing care schedules...',
    'Preparing your green sanctuary...',
  ];

  Timer? _textTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _fadeAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Cycle through texts every 1.5 seconds
    _textTimer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      if (mounted) {
        setState(() {
          if (_currentTextIndex < _loadingTexts.length - 1) {
            _currentTextIndex++;
          }
        });
      }
    });

    // Navigate to Home after 4.5 seconds
    Timer(const Duration(milliseconds: 4500), () {
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HomePage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
            transitionDuration: const Duration(milliseconds: 800),
          ),
          (route) => false, // Remove all previous routes
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _textTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _lightBg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated Icon / Logo
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _accentGreen.withOpacity(0.1),
                        boxShadow: [
                          BoxShadow(
                            color: _accentGreen.withOpacity(0.3),
                            blurRadius: 40,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(Icons.eco, color: _accentGreen, size: 60),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 64),

            // Animated Text
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: Text(
                _loadingTexts[_currentTextIndex],
                key: ValueKey<int>(_currentTextIndex),
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.5,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Linear Progress Indicator tailored to theme
            SizedBox(
              width: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  backgroundColor: const Color(0xFFE5E5EA),
                  color: _accentGreen,
                  minHeight: 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
