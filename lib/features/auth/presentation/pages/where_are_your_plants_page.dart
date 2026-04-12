import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'what_can_we_help_page.dart';

class WhereAreYourPlantsPage extends StatefulWidget {
  const WhereAreYourPlantsPage({super.key});

  @override
  State<WhereAreYourPlantsPage> createState() => _WhereAreYourPlantsPageState();
}

class _WhereAreYourPlantsPageState extends State<WhereAreYourPlantsPage> {
  final Set<String> _selectedLocations = {};

  final Color _accentGreen = const Color(0xFFB5C397);
  final Color _buttonColor = const Color(0xFFF2F2F7);
  final Color _unselectedIconColor = const Color(0xFF8A8A8E);

  final List<Map<String, dynamic>> _locations = [
    {
      'id': 'indoor',
      'title': 'Indoor',
      'subtitle': 'Living room, bedroom, office',
      'icon': Icons.home_filled,
      'image': 'https://picsum.photos/seed/location1/800/400',
    },
    {
      'id': 'balcony',
      'title': 'Balcony',
      'subtitle': 'Potted plants on deck or terrace',
      'icon': Icons.balcony,
      'image': 'https://picsum.photos/seed/location2/800/400',
    },
    {
      'id': 'garden',
      'title': 'Garden',
      'subtitle': 'In-ground plants and flowerbeds',
      'icon': Icons.park,
      'image': 'https://picsum.photos/seed/location3/800/400',
    },
  ];

  void _toggleSelection(String id) {
    setState(() {
      if (_selectedLocations.contains(id)) {
        _selectedLocations.remove(id);
      } else {
        _selectedLocations.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Light background
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
                  // (Skip is already at the bottom)
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 16),
              // Header / Progress bar
              _buildProgressBar(),
              const SizedBox(height: 32),

              // Title Area
              Text(
                'Where are your plants?',
                style: GoogleFonts.outfit(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Select all that apply to customize your care\nschedules',
                style: GoogleFonts.inter(
                  color: const Color(0xFF666666),
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32),

              // List of options
              Expanded(
                child: ListView.separated(
                  itemCount: _locations.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return _buildLocationCard(_locations[index]);
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
                            // Handle skip
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _buttonColor,
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
                                builder: (context) => const WhatCanWeHelpPage(),
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
                            'Next Step',
                            style: GoogleFonts.inter(
                              color: Colors.black,
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
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: _accentGreen,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          flex: 2,
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFE5E5EA),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationCard(Map<String, dynamic> location) {
    final bool isSelected = _selectedLocations.contains(location['id']);

    return GestureDetector(
      onTap: () => _toggleSelection(location['id']),
      child: Container(
        height: 180, // slightly larger for the nice image effect
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          image: DecorationImage(
            image: NetworkImage(location['image']),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.15),
              BlendMode.darken,
            ),
          ),
        ),
        child: Stack(
          children: [
            // Internal glassmorphism container at the bottom
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white.withOpacity(0.85)
                          : Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isSelected
                            ? _accentGreen.withOpacity(0.8)
                            : Colors.black.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Icon circle
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.05),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            location['icon'],
                            color: _accentGreen,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Titles
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                location['title'],
                                style: GoogleFonts.outfit(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                location['subtitle'],
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF666666),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Checkbox circle
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? _accentGreen
                                  : _unselectedIconColor,
                              width: 2,
                            ),
                            color: isSelected
                                ? _accentGreen
                                : Colors.transparent,
                          ),
                          child: isSelected
                              ? const Icon(
                                  Icons.check,
                                  size: 18,
                                  color: Colors.black,
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
