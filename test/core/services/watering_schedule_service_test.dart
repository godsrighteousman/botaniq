import 'package:botaniq/core/services/watering_schedule_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WateringScheduleService', () {
    test('calculates a task due today from last watering and interval', () {
      final schedule = WateringScheduleService.fromPlant({
        'last_watered_at': '2026-07-24',
        'watering_interval_days': 7,
      }, now: DateTime(2026, 7, 31, 18));

      expect(schedule.dueDate, DateTime(2026, 7, 31));
      expect(schedule.isDueToday, isTrue);
      expect(schedule.statusLabel, 'Bugün sulanmalı');
      expect(schedule.intervalLabel, '7 günde bir');
      expect(schedule.lastWateredLabel, 'Son sulama: 24.07.2026');
    });

    test('places a watering due in one day into tomorrow', () {
      final schedule = WateringScheduleService.fromPlant({
        'last_watered_at': '2026-07-25',
        'watering_interval_days': 7,
      }, now: DateTime(2026, 7, 31));

      expect(schedule.dueDate, DateTime(2026, 8, 1));
      expect(schedule.isDueTomorrow, isTrue);
      expect(schedule.statusLabel, 'Yarın sulanmalı');
    });

    test('keeps an unfinished watering overdue on the following day', () {
      final schedule = WateringScheduleService.fromPlant({
        'last_watered_at': '2026-07-24',
        'watering_interval_days': 7,
      }, now: DateTime(2026, 8, 1));

      expect(schedule.isDue, isTrue);
      expect(schedule.isOverdue, isTrue);
      expect(schedule.statusLabel, '1 gün gecikti');
    });

    test('treats a never-watered plant as due today', () {
      final schedule = WateringScheduleService.fromPlant({
        'last_watered_at': null,
        'watering_interval_days': 5,
      }, now: DateTime(2026, 7, 31));

      expect(schedule.isDueToday, isTrue);
      expect(schedule.dueDate, DateTime(2026, 7, 31));
      expect(schedule.lastWateredLabel, 'Son sulama: Henüz yok');
    });

    test('uses seven days when interval is missing or invalid', () {
      expect(
        WateringScheduleService.fromPlant({
          'last_watered_at': '2026-07-24',
          'watering_interval_days': 0,
        }, now: DateTime(2026, 7, 31)).intervalDays,
        7,
      );
    });
  });
}
