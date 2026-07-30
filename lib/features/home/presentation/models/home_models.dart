import 'package:flutter/material.dart';
import '../../../../core/services/watering_schedule_service.dart';

/// Supabase care_tasks tablosundaki bir bakım görevi.
class CareTask {
  final String id;
  final String plantId;
  final String plantName;
  final String taskType;
  final String amount;
  final String instruction;
  final String imageUrl;
  final DateTime? dueDate;
  bool isCompleted;
  final bool isDerived;
  final List<String> sourceTaskIds;

  CareTask({
    required this.id,
    this.plantId = '',
    required this.plantName,
    required this.taskType,
    this.amount = '',
    this.instruction = '',
    this.imageUrl = '',
    this.dueDate,
    this.isCompleted = false,
    this.isDerived = false,
    this.sourceTaskIds = const [],
  });

  /// Görevi tamamlanmamış VE tarihi geçmişse overdue sayılır.
  bool get isOverdue => isOverdueAt(DateTime.now());

  bool isOverdueAt(DateTime now) {
    if (isCompleted || dueDate == null) return false;
    final localNow = now.isUtc ? now.toLocal() : now;
    final localDue = dueDate!.isUtc ? dueDate!.toLocal() : dueDate!;
    final today = DateTime(localNow.year, localNow.month, localNow.day);
    final due = DateTime(localDue.year, localDue.month, localDue.day);
    return due.isBefore(today);
  }

  /// Supabase DB sonucundan CareTask oluşturur.
  factory CareTask.fromDbRow(Map<String, dynamic> row) {
    final plant = row['plants'] as Map<String, dynamic>? ?? {};
    final id = row['id']?.toString() ?? '';
    final parsedDueDate = DateTime.tryParse(row['due_date']?.toString() ?? '');
    return CareTask(
      id: id,
      plantId: row['plant_id']?.toString() ?? plant['id']?.toString() ?? '',
      plantName: plant['custom_name'] ?? plant['name'] ?? 'My Plant',
      taskType: _capitalizeFirst(row['task_type'] as String? ?? 'care'),
      amount: row['amount'] ?? '',
      instruction: row['instruction'] ?? 'Take care of your plant.',
      imageUrl: plant['image_url'] ?? '',
      dueDate: parsedDueDate?.toLocal(),
      isCompleted: row['is_completed'] ?? false,
      sourceTaskIds: id.isEmpty ? const [] : [id],
    );
  }

  /// Bitki verisinden türetilmiş sanal görev oluşturur.
  factory CareTask.derived({
    required String id,
    required String plantId,
    required String plantName,
    required String taskType,
    required String imageUrl,
    required DateTime dueDate,
    String amount = '',
    String instruction = '',
  }) {
    return CareTask(
      id: id,
      plantId: plantId,
      plantName: plantName,
      taskType: taskType,
      amount: amount,
      instruction: instruction,
      imageUrl: imageUrl,
      dueDate: dueDate,
      isDerived: true,
    );
  }

  CareTask copyWith({
    String? id,
    String? plantId,
    String? plantName,
    String? taskType,
    String? amount,
    String? instruction,
    String? imageUrl,
    DateTime? dueDate,
    bool? isCompleted,
    bool? isDerived,
    List<String>? sourceTaskIds,
  }) {
    return CareTask(
      id: id ?? this.id,
      plantId: plantId ?? this.plantId,
      plantName: plantName ?? this.plantName,
      taskType: taskType ?? this.taskType,
      amount: amount ?? this.amount,
      instruction: instruction ?? this.instruction,
      imageUrl: imageUrl ?? this.imageUrl,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
      isDerived: isDerived ?? this.isDerived,
      sourceTaskIds: sourceTaskIds ?? this.sourceTaskIds,
    );
  }

  static String _capitalizeFirst(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }
}

/// Home ekranında gösterilen bitki özet bilgisi.
class PlantSummary {
  final String id;
  final String name;
  final String species;
  final String imageUrl;
  final String wateringStatus;
  final String wateringDetails;
  final Color statusColor;
  final Map<String, dynamic> rawData;

  const PlantSummary({
    required this.id,
    required this.name,
    required this.species,
    required this.imageUrl,
    required this.wateringStatus,
    required this.wateringDetails,
    required this.statusColor,
    required this.rawData,
  });

  factory PlantSummary.fromPlantData(Map<String, dynamic> plant) {
    final schedule = WateringScheduleService.fromPlant(plant);
    return PlantSummary(
      id: plant['id']?.toString() ?? '',
      name: plant['custom_name'] ?? plant['name'] ?? '',
      species: plant['species'] ?? '',
      imageUrl: plant['image_url'] ?? '',
      wateringStatus: schedule.statusLabel,
      wateringDetails:
          '${schedule.lastWateredLabel} • ${schedule.intervalLabel}',
      statusColor: _statusColor(schedule),
      rawData: plant,
    );
  }

  static Color _statusColor(PlantWateringSchedule schedule) {
    if (schedule.isDue) return Colors.redAccent;
    if (schedule.isDueTomorrow) return Colors.orangeAccent;
    return const Color(0xFF4FA976);
  }
}
