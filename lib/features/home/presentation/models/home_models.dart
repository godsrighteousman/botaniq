import 'package:flutter/material.dart';

/// Supabase care_tasks tablosundaki bir bakım görevi.
class CareTask {
  final String id;
  final String plantName;
  final String taskType;
  final String amount;
  final String instruction;
  final String imageUrl;
  final DateTime? dueDate;
  bool isCompleted;
  final bool isDerived;

  CareTask({
    required this.id,
    required this.plantName,
    required this.taskType,
    this.amount = '',
    this.instruction = '',
    this.imageUrl = '',
    this.dueDate,
    this.isCompleted = false,
    this.isDerived = false,
  });

  /// Görevi tamamlanmamış VE tarihi geçmişse overdue sayılır.
  bool get isOverdue {
    if (isCompleted || dueDate == null) return false;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final due = DateTime(dueDate!.year, dueDate!.month, dueDate!.day);
    return due.isBefore(today);
  }

  /// Supabase DB sonucundan CareTask oluşturur.
  factory CareTask.fromDbRow(Map<String, dynamic> row) {
    final plant = row['plants'] as Map<String, dynamic>? ?? {};
    return CareTask(
      id: row['id']?.toString() ?? '',
      plantName: plant['custom_name'] ?? plant['name'] ?? 'My Plant',
      taskType: _capitalizeFirst(row['task_type'] as String? ?? 'care'),
      amount: row['amount'] ?? '',
      instruction: row['instruction'] ?? 'Take care of your plant.',
      imageUrl: plant['image_url'] ?? '',
      dueDate: DateTime.tryParse(row['due_date'] ?? ''),
      isCompleted: row['is_completed'] ?? false,
    );
  }

  /// Bitki verisinden türetilmiş sanal görev oluşturur.
  factory CareTask.derived({
    required String id,
    required String plantName,
    required String taskType,
    required String imageUrl,
    required DateTime dueDate,
    String amount = '',
    String instruction = '',
  }) {
    return CareTask(
      id: id,
      plantName: plantName,
      taskType: taskType,
      amount: amount,
      instruction: instruction,
      imageUrl: imageUrl,
      dueDate: dueDate,
      isDerived: true,
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
  final Color statusColor;
  final Map<String, dynamic> rawData;

  const PlantSummary({
    required this.id,
    required this.name,
    required this.species,
    required this.imageUrl,
    required this.wateringStatus,
    required this.statusColor,
    required this.rawData,
  });

  factory PlantSummary.fromPlantData(Map<String, dynamic> plant) {
    final status = _computeWateringStatus(plant);
    return PlantSummary(
      id: plant['id']?.toString() ?? '',
      name: plant['custom_name'] ?? plant['name'] ?? '',
      species: plant['species'] ?? '',
      imageUrl: plant['image_url'] ?? '',
      wateringStatus: status.label,
      statusColor: status.color,
      rawData: plant,
    );
  }

  static _WateringInfo _computeWateringStatus(Map<String, dynamic> plant) {
    final last = plant['last_watered_at'];
    final interval = (plant['watering_interval_days'] as int?) ?? 7;
    if (last == null) return _WateringInfo('Water today', Colors.redAccent);
    final lastDate = DateTime.tryParse(last);
    if (lastDate == null) return _WateringInfo('Water today', Colors.redAccent);
    final next = lastDate.add(Duration(days: interval));
    final now = DateTime.now();
    final difference = next.difference(now).inDays;

    if (difference < 0) {
      return _WateringInfo('Needs water!', Colors.redAccent);
    } else if (difference == 0) {
      return _WateringInfo('Water today', Colors.redAccent);
    } else if (difference == 1) {
      return _WateringInfo('Water tomorrow', Colors.orangeAccent);
    } else {
      return _WateringInfo(
        'Water in $difference days',
        const Color(0xFF4FA976),
      );
    }
  }
}

class _WateringInfo {
  final String label;
  final Color color;
  const _WateringInfo(this.label, this.color);
}
