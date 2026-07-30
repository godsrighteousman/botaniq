class PlantWateringSchedule {
  const PlantWateringSchedule({
    required this.lastWateredAt,
    required this.intervalDays,
    required this.dueDate,
    required this.daysUntilDue,
  });

  final DateTime? lastWateredAt;
  final int intervalDays;
  final DateTime dueDate;
  final int daysUntilDue;

  bool get isOverdue => daysUntilDue < 0;
  bool get isDueToday => daysUntilDue == 0;
  bool get isDue => daysUntilDue <= 0;
  bool get isDueTomorrow => daysUntilDue == 1;

  String get statusLabel {
    if (lastWateredAt == null) return 'Henüz sulanmadı • Bugün sulanmalı';
    if (isOverdue) return '${daysUntilDue.abs()} gün gecikti';
    if (isDueToday) return 'Bugün sulanmalı';
    if (isDueTomorrow) return 'Yarın sulanmalı';
    return '$daysUntilDue gün sonra sulanmalı';
  }

  String get lastWateredLabel {
    final date = lastWateredAt;
    if (date == null) return 'Son sulama: Henüz yok';
    return 'Son sulama: ${_twoDigits(date.day)}.'
        '${_twoDigits(date.month)}.${date.year}';
  }

  String get intervalLabel => '$intervalDays günde bir';

  static String _twoDigits(int value) => value.toString().padLeft(2, '0');
}

class WateringScheduleService {
  const WateringScheduleService._();

  static PlantWateringSchedule fromPlant(
    Map<String, dynamic> plant, {
    DateTime? now,
  }) {
    final today = startOfLocalDay(now ?? DateTime.now());
    final lastWateredAt = _parseDate(plant['last_watered_at']);
    final intervalDays = positiveInterval(plant['watering_interval_days']);
    final dueDate = lastWateredAt == null
        ? today
        : startOfLocalDay(
            lastWateredAt,
          ).add(Duration(days: intervalDays));

    return PlantWateringSchedule(
      lastWateredAt: lastWateredAt == null
          ? null
          : startOfLocalDay(lastWateredAt),
      intervalDays: intervalDays,
      dueDate: dueDate,
      daysUntilDue: _calendarDayDifference(dueDate, today),
    );
  }

  static DateTime startOfLocalDay(DateTime value) {
    final local = value.isUtc ? value.toLocal() : value;
    return DateTime(local.year, local.month, local.day);
  }

  static bool isSameLocalDay(DateTime first, DateTime second) {
    return startOfLocalDay(first) == startOfLocalDay(second);
  }

  static int positiveInterval(dynamic value) {
    final parsed = value is num ? value.toInt() : int.tryParse('$value');
    return parsed != null && parsed > 0 ? parsed : 7;
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }

  static int _calendarDayDifference(DateTime date, DateTime reference) {
    final normalizedDate = startOfLocalDay(date);
    final normalizedReference = startOfLocalDay(reference);
    return DateTime.utc(
      normalizedDate.year,
      normalizedDate.month,
      normalizedDate.day,
    ).difference(
      DateTime.utc(
        normalizedReference.year,
        normalizedReference.month,
        normalizedReference.day,
      ),
    ).inDays;
  }
}
