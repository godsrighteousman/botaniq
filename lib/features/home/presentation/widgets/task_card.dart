import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/home_models.dart';

/// Tek bir görev kartı widget'ı.
/// Overdue, normal ve tamamlanmış durumları destekler.
/// Tamamlama animasyonu ile yumuşak geçiş sağlar.
class TaskCard extends StatelessWidget {
  final CareTask task;
  final VoidCallback onTap;

  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = task.isCompleted;
    final isOverdue = task.isOverdue;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: isOverdue && !isCompleted
              ? LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color(0xFFFF6B6B).withOpacity(0.08),
                    Colors.white.withOpacity(0.9),
                  ],
                )
              : null,
          color: isOverdue
              ? null
              : isCompleted
                  ? const Color(0xFFF5F9F6).withOpacity(0.6)
                  : Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isOverdue && !isCompleted
                ? const Color(0xFFFF6B6B).withOpacity(0.3)
                : isCompleted
                    ? Colors.transparent
                    : const Color(0xFFE8F5EE),
            width: isOverdue ? 1.5 : 1,
          ),
          boxShadow: isCompleted
              ? []
              : [
                  BoxShadow(
                    color: isOverdue
                        ? const Color(0xFFFF6B6B).withOpacity(0.08)
                        : Colors.black.withOpacity(0.04),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Row(
          children: [
            // Bitki resmi
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: isCompleted ? 0.4 : 1.0,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xFFE8F5EE),
                  image: task.imageUrl.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(task.imageUrl),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: task.imageUrl.isEmpty
                    ? const Icon(
                        Icons.local_florist_outlined,
                        color: Color(0xFF86D5A6),
                        size: 24,
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 14),

            // Görev bilgisi
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Overdue rozeti
                  if (isOverdue && !isCompleted) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      margin: const EdgeInsets.only(bottom: 6),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.warning_rounded,
                            color: Colors.white,
                            size: 12,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'OVERDUE',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  // Bitki adı
                  Text(
                    task.plantName,
                    style: GoogleFonts.outfit(
                      color: isCompleted
                          ? const Color(0xFF7A8F82)
                          : const Color(0xFF1B3A2A),
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      decoration:
                          isCompleted ? TextDecoration.lineThrough : null,
                      decorationColor: const Color(0xFF7A8F82),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Görev tipi + miktar
                  Row(
                    children: [
                      Icon(
                        _getTaskIcon(task.taskType),
                        color: isCompleted
                            ? const Color(0xFF7A8F82)
                            : isOverdue
                                ? const Color(0xFFFF6B6B)
                                : const Color(0xFF0ED761),
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          '${task.taskType}${task.amount.isNotEmpty ? ' · ${task.amount}' : ''}',
                          style: GoogleFonts.inter(
                            color: isCompleted
                                ? const Color(0xFFADBFB4)
                                : const Color(0xFF5C7165),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Sağ taraf: durum ikonu
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: isCompleted
                  ? Container(
                      key: const ValueKey('done'),
                      width: 34,
                      height: 34,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF0ED761), Color(0xFF0ABF55)],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    )
                  : Container(
                      key: const ValueKey('pending'),
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F9F6),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isOverdue
                              ? const Color(0xFFFF6B6B).withOpacity(0.3)
                              : const Color(0xFFE0E8E3),
                        ),
                      ),
                      child: Icon(
                        Icons.chevron_right_rounded,
                        color: isOverdue
                            ? const Color(0xFFFF6B6B)
                            : const Color(0xFF7A8F82),
                        size: 20,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getTaskIcon(String taskType) {
    switch (taskType.toLowerCase()) {
      case 'water':
      case 'watering':
        return Icons.water_drop_rounded;
      case 'fertilize':
      case 'fertilizer':
      case 'fertilizing':
        return Icons.eco_rounded;
      case 'prune':
      case 'pruning':
        return Icons.content_cut_rounded;
      default:
        return Icons.spa_rounded;
    }
  }
}
