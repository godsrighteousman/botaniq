import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'location_access_page.dart';

class GreenThumbMasteryPage extends StatefulWidget {
  const GreenThumbMasteryPage({super.key});

  @override
  State<GreenThumbMasteryPage> createState() => _GreenThumbMasteryPageState();
}

class _GreenThumbMasteryPageState extends State<GreenThumbMasteryPage> {
  String? _selectedMastery;

  final Color _accentGreen = const Color(0xFF0ED761);
  final Color _lightBg = const Color(0xFFF5F5F7);
  final Color _cardBg = Colors.white;

  final List<Map<String, String>> _masteryLevels = [
    {
      'id': 'killer',
      'title': 'The Serial Killer',
      'subtitle':
          'Even my plastic plants look a bit worried when I enter the room.',
      'image':
          'https://picsum.photos/seed/thumb1/400/400', // Dead earth texture
    },
    {
      'id': 'accidental',
      'title': 'Accidental Parent',
      'subtitle':
          'I own a cactus. It\'s survived two weeks. We\'re still getting to know each other.',
      'image': 'https://picsum.photos/seed/thumb2/400/400', // Small cactus pot
    },
    {
      'id': 'growth',
      'title': 'Growth Mindset',
      'subtitle':
          'Most of my friends have leaves. I know my Monsteras from my Pothos.',
      'image':
          'https://picsum.photos/seed/thumb3/400/400', // Fiddle leaf / indoor plant
    },
    {
      'id': 'whisperer',
      'title': 'Plant Whisperer',
      'subtitle':
          'I propagate my own rare plants and speak fluent botanical Latin.',
      'image':
          'https://picsum.photos/seed/thumb4/400/400', // Monstera leaves / lush
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
                ],
              ),
              const SizedBox(height: 32),

              // Title Area
              RichText(
                text: TextSpan(
                  style: GoogleFonts.outfit(
                    color: Colors.black,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                  children: [
                    const TextSpan(text: 'How\'s your '),
                    TextSpan(
                      text: 'green\nthumb ',
                      style: TextStyle(
                        color: _accentGreen,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const TextSpan(text: 'lately?'),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Be honest—we\'ve all been "The Serial Killer" at\nsome point. Select your current mastery.',
                style: GoogleFonts.inter(
                  color: const Color(0xFF6E6E73),
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),

              // List of options
              Expanded(
                child: ListView.separated(
                  itemCount: _masteryLevels.length,
                  // Adjusted spacing for less empty space
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return _buildMasteryCard(_masteryLevels[index]);
                  },
                ),
              ),

              // Bottom Actions
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 24.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 56,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const LocationAccessPage(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: Text(
                            'Skip for now',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF8A8A8E),
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
                                    const LocationAccessPage(),
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
        for (int i = 0; i < 4; i++)
          Container(
            width: i == 2 ? 16 : 6,
            height: 6,
            margin: const EdgeInsets.only(left: 4),
            decoration: BoxDecoration(
              color: i == 2 ? _accentGreen : const Color(0xFFE5E5EA),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
      ],
    );
  }

  Widget _buildMasteryCard(Map<String, String> level) {
    final bool isSelected = _selectedMastery == level['id'];

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMastery = level['id'];
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? _cardBg.withOpacity(0.8) : _cardBg,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? _accentGreen : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left Image
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                level['image']!,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            // Texts and Checkmark
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          level['title']!,
                          style: GoogleFonts.outfit(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (isSelected)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _accentGreen,
                          ),
                          child: const Icon(
                            Icons.check,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    level['subtitle']!,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF6E6E73),
                      fontSize: 13,
                      height: 1.3,
                    ),
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
