import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'green_thumb_mastery_page.dart';

class YourGreenJourneyPage extends StatefulWidget {
  const YourGreenJourneyPage({super.key});

  @override
  State<YourGreenJourneyPage> createState() => _YourGreenJourneyPageState();
}

class _YourGreenJourneyPageState extends State<YourGreenJourneyPage> {
  String? _selectedCareLevel;

  final Color _accentGreen = const Color(0xFF0ED761);
  final Color _lightBg = const Color(0xFFF5F5F7);
  final Color _cardBg = Colors.white;

  final List<Map<String, String>> _careLevels = [
    {
      'id': 'casual',
      'label': 'CASUAL',
      'title': 'Low Maintenance',
      'subtitle': 'I just want to keep my simple\nplants alive and thriving.',
      'image': 'https://picsum.photos/seed/plant1/800/400',
    },
    {
      'id': 'enthusiast',
      'label': 'ENTHUSIAST',
      'title': 'Balanced Care',
      'subtitle':
          'I enjoy spending some weekly\ntime with my growing collection.',
      'image': 'https://picsum.photos/seed/plant2/800/400',
    },
    {
      'id': 'obsessed',
      'label': 'OBSESSED',
      'title': 'Plant Parent\nExtraordinaire',
      'subtitle':
          'I live for my plants. I want expert\nschedules for my indoor jungle.',
      'image': 'https://picsum.photos/seed/plant3/800/400',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _lightBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Top Navigation Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                      size: 20,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  _buildProgressBar(),
                  const SizedBox(width: 48), // balance back button
                ],
              ),
              const SizedBox(height: 32),

              // Title Area
              Text(
                'Your Green Journey',
                style: GoogleFonts.outfit(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Select the level of care you wish to provide.',
                style: GoogleFonts.inter(
                  color: const Color(0xFF6E6E73),
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32),

              // List of options
              Expanded(
                child: ListView.separated(
                  itemCount: _careLevels.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return _buildLevelCard(_careLevels[index]);
                  },
                ),
              ),

              // Bottom Actions
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 24.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const GreenThumbMasteryPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _cardBg,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            'Skip',
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const GreenThumbMasteryPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _accentGreen,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            'Continue',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
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

  Widget _buildProgressBar() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 4,
          decoration: BoxDecoration(
            color: const Color(0xFFE5E5EA),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Container(
          width: 32,
          height: 4,
          decoration: BoxDecoration(
            color: _accentGreen,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Container(
          width: 24,
          height: 4,
          decoration: BoxDecoration(
            color: const Color(0xFFE5E5EA),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildLevelCard(Map<String, String> level) {
    final bool isSelected = _selectedCareLevel == level['id'];

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCareLevel = level['id'];
        });
      },
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          image: DecorationImage(
            image: NetworkImage(level['image']!),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.darken,
            ),
          ),
        ),
        child: Stack(
          children: [
            // Dark gradient overlay
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: const [0.0, 0.8],
                ),
              ),
            ),
            // Border if selected
            if (isSelected)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: _accentGreen.withOpacity(0.6),
                    width: 2,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          level['label']!,
                          style: GoogleFonts.inter(
                            color: isSelected
                                ? _accentGreen
                                : const Color(0xFF8A8A8E),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          level['title']!,
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          level['subtitle']!,
                          style: GoogleFonts.inter(
                            color: const Color(0xFFE0E0E0),
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? _accentGreen : Colors.transparent,
                      border: Border.all(
                        color: isSelected ? _accentGreen : Colors.white38,
                        width: 1.5,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, size: 18, color: Colors.black)
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
