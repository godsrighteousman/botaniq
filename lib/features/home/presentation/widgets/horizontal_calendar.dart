import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

/// Yatay kaydırılabilir 14 günlük takvim bileşeni.
/// Gün seçiminde animasyonlu geçiş ve görev noktaları gösterir.
class HorizontalCalendar extends StatelessWidget {
  final List<DateTime> days;
  final DateTime selectedDate;
  final Map<String, bool> daysWithTasks;
  final ValueChanged<DateTime> onDateSelected;

  const HorizontalCalendar({
    super.key,
    required this.days,
    required this.selectedDate,
    required this.daysWithTasks,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final localeName = Localizations.localeOf(context).toLanguageTag();
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: days.length,
        itemBuilder: (context, index) {
          final date = days[index];
          final isSelected = _isSameDay(date, selectedDate);
          final isToday = _isSameDay(date, DateTime.now());
          final dayKey = DateFormat('yyyy-MM-dd').format(date);
          final hasTask = daysWithTasks[dayKey] ?? false;

          return GestureDetector(
            onTap: () => onDateSelected(date),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              width: 62,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF0ED761), Color(0xFF0ABF55)],
                      )
                    : null,
                color: isSelected ? null : Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : isToday
                      ? const Color(0xFF0ED761).withOpacity(0.4)
                      : const Color(0xFFE8F5EE),
                  width: isToday && !isSelected ? 1.5 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(0xFF0ED761).withOpacity(0.35),
                          blurRadius: 14,
                          spreadRadius: 1,
                          offset: const Offset(0, 6),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('EEE', localeName).format(date).toUpperCase(),
                    style: GoogleFonts.inter(
                      color: isSelected
                          ? Colors.white.withOpacity(0.85)
                          : const Color(0xFF7A8F82),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    date.day.toString(),
                    style: GoogleFonts.outfit(
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF1B3A2A),
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: hasTask ? 6 : 0,
                    height: hasTask ? 6 : 0,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF0ED761),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
