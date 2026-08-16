import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:botaniq/l10n/app_localizations.dart';

import 'your_green_journey_page.dart';

class WhatCanWeHelpPage extends StatefulWidget {
  const WhatCanWeHelpPage({super.key});

  @override
  State<WhatCanWeHelpPage> createState() => _WhatCanWeHelpPageState();
}

class _WhatCanWeHelpPageState extends State<WhatCanWeHelpPage> {
  final Set<String> _selectedGoals = {};

  final Color _accentGreen = const Color(0xFFB5C397);
  final Color _bgColor = Colors.white;
  final Color _cardBg = const Color(0xFFF2F2F7);

  final List<Map<String, dynamic>> _goals = [
    {
      'id': 'heal',
      'title': 'Heal sick\nplants',
      'icon': Icons.medical_services_rounded,
      'color': const Color(0xFFB5C397),
    },
    {
      'id': 'care',
      'title': 'Care\nreminders',
      'icon': Icons.water_drop_rounded,
      'color': const Color(0xFF6AA1FF),
    },
    {
      'id': 'identify',
      'title': 'Identify\nspecies',
      'icon': Icons.document_scanner_rounded, // fallback icon
      'color': const Color(0xFFFFC634),
    },
    {
      'id': 'journal',
      'title': 'Growth\njournal',
      'icon': Icons.menu_book_rounded,
      'color': const Color(0xFFC486F5),
    },
  ];

  void _toggleSelection(String id) {
    setState(() {
      if (_selectedGoals.contains(id)) {
        _selectedGoals.remove(id);
      } else {
        _selectedGoals.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: _bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Back Button
              BackButton(
                color: Colors.black,
                style: IconButton.styleFrom(iconSize: 20),
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
                    TextSpan(text: l10n.helpTitleBefore),
                    TextSpan(
                      text: l10n.helpTitleHighlight,
                      style: TextStyle(color: _accentGreen),
                    ),
                    TextSpan(text: l10n.helpTitleAfter),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.helpSubtitle,
                style: GoogleFonts.inter(
                  color: const Color(0xFF666666),
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 40),

              // Grid Options
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: _goals.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.85,
                  ),
                  itemBuilder: (context, index) {
                    return _buildGoalCard(_goals[index]);
                  },
                ),
              ),

              // Something else button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _cardBg,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        l10n.helpOther,
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.more_horiz,
                        color: Colors.black,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Next/Skip Actions
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          // Skip action
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const YourGreenJourneyPage(),
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
                          l10n.skip,
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
                                  const YourGreenJourneyPage(),
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
                          l10n.continueLabel,
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
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoalCard(Map<String, dynamic> goal) {
    final l10n = AppLocalizations.of(context)!;
    final bool isSelected = _selectedGoals.contains(goal['id']);
    final Color itemColor = goal['color'];
    final title = switch (goal['id']) {
      'heal' => l10n.helpHeal,
      'care' => l10n.helpCare,
      'identify' => l10n.helpIdentify,
      _ => l10n.helpJournal,
    };

    return GestureDetector(
      onTap: () => _toggleSelection(goal['id']),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _cardBg,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? itemColor.withValues(alpha: 0.5)
                : const Color(0xFFE5E5EA),
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: itemColor.withValues(alpha: 0.15),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, 0),
                  ),
                ]
              : [],
        ),
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: itemColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(goal['icon'], color: itemColor, size: 32),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
              ],
            ),
            PositionedDirectional(
              top: 0,
              end: 0,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? _accentGreen : Colors.white,
                  border: Border.all(
                    color: isSelected
                        ? Colors.transparent
                        : const Color(0xFFD1D1D6),
                  ),
                ),
                child: isSelected
                    ? const Icon(Icons.check, size: 14, color: Colors.black)
                    : const Icon(
                        Icons.check,
                        size: 14,
                        color: Color(0xFFD1D1D6),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
