import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/home_models.dart';
import 'task_card.dart';

/// Görev listesi bölümü. Geciken görevler Today listesine dahil edilir;
/// ardından yarın görevleri ayrı bir başlık altında gösterilir.
/// AnimatedSwitcher ile gün değişimlerinde yumuşak geçiş sağlar.
class TaskListSection extends StatelessWidget {
  final String sectionTitle;
  final List<CareTask> tasks;
  final List<CareTask> tomorrowTasks;
  final bool showTomorrow;
  final ValueChanged<CareTask> onTaskTap;

  const TaskListSection({
    super.key,
    required this.sectionTitle,
    required this.tasks,
    required this.tomorrowTasks,
    required this.showTomorrow,
    required this.onTaskTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.05),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: Column(
        key: ValueKey('$sectionTitle-${tasks.length}'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Seçili gün başlığı ──
          _buildSectionHeader(sectionTitle),
          const SizedBox(height: 14),

          if (tasks.isEmpty)
            _buildEmptyTaskState()
          else
            ...tasks.map(
              (task) => TaskCard(task: task, onTap: () => onTaskTap(task)),
            ),

          // ── Yarın bölümü ──
          if (showTomorrow && tomorrowTasks.isNotEmpty) ...[
            const SizedBox(height: 24),
            _buildSectionHeader('Tomorrow'),
            const SizedBox(height: 14),
            ...tomorrowTasks.map(
              (task) => TaskCard(task: task, onTap: () => onTaskTap(task)),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.outfit(
        color: const Color(0xFF1B3A2A),
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildEmptyTaskState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F9F6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE8F5EE)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF0ED761).withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_outline_rounded,
              color: Color(0xFF0ED761),
              size: 32,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'No tasks for this day!',
            style: GoogleFonts.outfit(
              color: const Color(0xFF5C7165),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Your plants are all taken care of 🌿',
            style: GoogleFonts.inter(
              color: const Color(0xFF7A8F82),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
