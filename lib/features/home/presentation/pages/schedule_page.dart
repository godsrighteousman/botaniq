import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final Color _accentGreen = const Color(0xFF0ED761);
  final Color _lightBg = const Color(0xFFF5F5F7);
  final Color _cardBg = Colors.white;
  final Color _textSecondary = const Color(0xFF8A8A8E);

  late DateTime _selectedDate;
  final List<DateTime> _weekDays = [];

  // Mock Tasks Data
  final List<Map<String, dynamic>> _tasks = [
    {
      'id': '1',
      'plantName': 'Monstera Deliciosa',
      'taskType': 'Watering',
      'amount': '250ml',
      'instruction':
          'Water thoroughly until water drains out of the bottom hole. Avoid getting water on the leaves.',
      'image':
          'https://images.unsplash.com/photo-1485955900006-10f4d324d411?auto=format&fit=crop&q=80&w=400',
      'isCompleted': false,
    },
    {
      'id': '2',
      'plantName': 'Fiddle Leaf Fig',
      'taskType': 'Fertilize',
      'amount': 'Liquid Fertilizer',
      'instruction':
          'Use a balanced liquid fertilizer diluted to half strength. Apply to moist soil.',
      'image':
          'https://images.unsplash.com/photo-1601985705806-5b9a71f6004f?auto=format&fit=crop&q=80&w=400',
      'isCompleted': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();

    // Generate 7 days (including today)
    for (int i = 0; i < 7; i++) {
      _weekDays.add(DateTime.now().add(Duration(days: i)));
    }
  }

  void _markTaskDone(String id) {
    setState(() {
      final taskIndex = _tasks.indexWhere((task) => task['id'] == id);
      if (taskIndex != -1) {
        _tasks[taskIndex]['isCompleted'] = true;
      }
    });
  }

  void _showTaskDetails(BuildContext context, Map<String, dynamic> task) {
    if (task['isCompleted']) return; // Disable interaction if completed

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            color: _cardBg,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image and Title
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: NetworkImage(task['image']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task['plantName'],
                          style: GoogleFonts.outfit(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _accentGreen.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            task['taskType'],
                            style: GoogleFonts.inter(
                              color: _accentGreen,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Instruction
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Instructions',
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                task['instruction'],
                style: GoogleFonts.inter(
                  color: _textSecondary,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),

              // Amount / Dosage
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _lightBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black.withOpacity(0.05)),
                ),
                child: Row(
                  children: [
                    Icon(
                      task['taskType'] == 'Watering'
                          ? Icons.water_drop
                          : Icons.eco,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Required: ${task['amount']}',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Optional: add remind logic
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _lightBg,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Remind later',
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
                          _markTaskDone(task['id']);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _accentGreen,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Done',
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
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _lightBg,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Row(
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
                  const Spacer(),
                  Text(
                    'Schedule',
                    style: GoogleFonts.outfit(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 24), // Balance the back button
                ],
              ),
            ),

            // 7 Days Horizontal Calendar
            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: _weekDays.length,
                itemBuilder: (context, index) {
                  final date = _weekDays[index];
                  final isSelected =
                      date.day == _selectedDate.day &&
                      date.month == _selectedDate.month &&
                      date.year == _selectedDate.year;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDate = date;
                      });
                    },
                    child: Container(
                      width: 60,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? _accentGreen : _cardBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? Colors.transparent
                              : Colors.black.withOpacity(0.05),
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: _accentGreen.withOpacity(0.3),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : [],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('EEE').format(date),
                            style: GoogleFonts.inter(
                              color: isSelected ? Colors.white : _textSecondary,
                              fontSize: 13,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            date.day.toString(),
                            style: GoogleFonts.outfit(
                              color: isSelected ? Colors.white : Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 32),

            // Tasks List Area
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: _cardBg,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.all(24),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Text(
                        'Today Task',
                        style: GoogleFonts.outfit(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ..._tasks.map((task) => _buildTaskCard(task)),

                      // Empty state visually when no tasks or different date
                      if (_tasks.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Center(
                            child: Text(
                              'No tasks for today!',
                              style: GoogleFonts.inter(
                                color: _textSecondary,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    bool isCompleted = task['isCompleted'];

    return GestureDetector(
      onTap: () => _showTaskDetails(context, task),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isCompleted ? _lightBg.withOpacity(0.5) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isCompleted
                ? Colors.transparent
                : Colors.black.withOpacity(0.05),
          ),
          boxShadow: isCompleted
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    spreadRadius: 0,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Row(
          children: [
            // Image
            Opacity(
              opacity: isCompleted ? 0.5 : 1.0,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(task['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Text Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task['plantName'],
                    style: GoogleFonts.outfit(
                      color: isCompleted ? _textSecondary : Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        task['taskType'] == 'Watering'
                            ? Icons.water_drop
                            : Icons.eco,
                        color: isCompleted ? _textSecondary : _accentGreen,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${task['taskType']} - ${task['amount']}',
                        style: GoogleFonts.inter(
                          color: isCompleted
                              ? _textSecondary
                              : const Color(0xFF6E6E73),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Status Icon
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted ? _accentGreen : _lightBg,
                border: Border.all(
                  color: isCompleted
                      ? _accentGreen
                      : Colors.black.withOpacity(0.1),
                ),
              ),
              child: isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 18)
                  : const Icon(
                      Icons.chevron_right,
                      color: Colors.black54,
                      size: 20,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
