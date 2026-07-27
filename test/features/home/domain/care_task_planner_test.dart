import 'package:botaniq/features/home/domain/care_task_planner.dart';
import 'package:botaniq/features/home/presentation/models/home_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime(2026, 7, 28, 15, 30);

  group('CareTaskPlanner.bucketTodayAndTomorrow', () {
    test('puts overdue and today tasks in Today, tomorrow in Tomorrow, '
        'and excludes later or completed tasks', () {
      final buckets = CareTaskPlanner.bucketTodayAndTomorrow([
        _task(
          id: 'overdue',
          plantId: 'plant-overdue',
          dueDate: DateTime(2026, 7, 27, 23, 59),
        ),
        _task(
          id: 'today',
          plantId: 'plant-today',
          dueDate: DateTime(2026, 7, 28, 23, 59),
        ),
        _task(
          id: 'tomorrow',
          plantId: 'plant-tomorrow',
          dueDate: DateTime(2026, 7, 29, 8),
        ),
        _task(
          id: 'day-after-tomorrow',
          plantId: 'plant-later',
          dueDate: DateTime(2026, 7, 30),
        ),
        _task(
          id: 'completed',
          plantId: 'plant-completed',
          dueDate: DateTime(2026, 7, 27),
          isCompleted: true,
        ),
      ], now: now);

      expect(
        buckets.today.map((task) => task.id),
        orderedEquals(['overdue', 'today']),
      );
      expect(
        buckets.tomorrow.map((task) => task.id),
        orderedEquals(['tomorrow']),
      );
    });

    test('buckets fertilizer tasks loaded from database rows', () {
      final todayFertilizer = _databaseTask(
        id: 'fertilizer-today',
        plantId: 'plant-a',
        taskType: 'fertilize',
        dueDate: DateTime(2026, 7, 28, 20),
      );
      final tomorrowFertilizer = _databaseTask(
        id: 'fertilizer-tomorrow',
        plantId: 'plant-b',
        taskType: 'fertilizing',
        dueDate: DateTime(2026, 7, 29, 9),
      );

      final buckets = CareTaskPlanner.bucketTodayAndTomorrow([
        todayFertilizer,
        tomorrowFertilizer,
      ], now: now);

      expect(
        buckets.today.map((task) => task.id),
        orderedEquals(['fertilizer-today']),
      );
      expect(
        buckets.tomorrow.map((task) => task.id),
        orderedEquals(['fertilizer-tomorrow']),
      );
      expect(
        CareTaskPlanner.normalizedTaskType(buckets.today.single.taskType),
        'fertilize',
      );
      expect(
        CareTaskPlanner.normalizedTaskType(buckets.tomorrow.single.taskType),
        'fertilize',
      );
    });
  });

  group('CareTaskPlanner.buildWateringTasks', () {
    final plants = <Map<String, dynamic>>[
      {
        'id': 'overdue',
        'custom_name': 'Overdue plant',
        'last_watered_at': '2026-07-20',
        'watering_interval_days': 7,
      },
      {
        'id': 'today',
        'custom_name': 'Today plant',
        'last_watered_at': '2026-07-21',
        'watering_interval_days': 7,
      },
      {
        'id': 'tomorrow',
        'custom_name': 'Tomorrow plant',
        'last_watered_at': '2026-07-22',
        'watering_interval_days': 7,
      },
      {
        'id': 'never-watered',
        'custom_name': 'Never-watered plant',
        'last_watered_at': null,
        'watering_interval_days': 7,
      },
    ];

    test('includes overdue, today, and never-watered plants in Today', () {
      final tasks = CareTaskPlanner.buildWateringTasks(
        plants: plants,
        targetDate: DateTime(2026, 7, 28),
        now: now,
      );
      final tasksByPlantId = {for (final task in tasks) task.plantId: task};

      expect(
        tasksByPlantId.keys,
        unorderedEquals(['overdue', 'today', 'never-watered']),
      );
      expect(tasksByPlantId['overdue']!.dueDate, DateTime(2026, 7, 27));
      expect(tasksByPlantId['today']!.dueDate, DateTime(2026, 7, 28));
      expect(tasksByPlantId['never-watered']!.dueDate, DateTime(2026, 7, 28));
      expect(tasks.every((task) => task.isDerived), isTrue);
      expect(
        tasks.every(
          (task) =>
              CareTaskPlanner.normalizedTaskType(task.taskType) == 'water',
        ),
        isTrue,
      );
    });

    test('includes only tomorrow watering when Tomorrow is targeted', () {
      final tasks = CareTaskPlanner.buildWateringTasks(
        plants: plants,
        targetDate: DateTime(2026, 7, 29, 18),
        now: now,
      );

      expect(tasks, hasLength(1));
      expect(tasks.single.plantId, 'tomorrow');
      expect(tasks.single.dueDate, DateTime(2026, 7, 29));
    });

    test('keeps different plant IDs separate when names are the same', () {
      final derivedTasks = CareTaskPlanner.buildWateringTasks(
        plants: [
          {
            'id': 'monstera-a',
            'custom_name': 'Monstera',
            'last_watered_at': '2026-07-21',
            'watering_interval_days': 7,
          },
          {
            'id': 'monstera-b',
            'custom_name': 'Monstera',
            'last_watered_at': '2026-07-21',
            'watering_interval_days': 7,
          },
        ],
        targetDate: DateTime(2026, 7, 28),
        now: now,
      );

      final merged = CareTaskPlanner.mergeByPlantAndType(
        databaseTasks: const [],
        derivedTasks: derivedTasks,
      );

      expect(merged, hasLength(2));
      expect(
        merged.map((task) => task.plantId),
        unorderedEquals(['monstera-a', 'monstera-b']),
      );
      expect(merged.map((task) => task.plantName).toSet(), {'Monstera'});
    });
  });

  group('CareTaskPlanner.mergeByPlantAndType', () {
    test(
      'collapses DB and derived tasks while preserving every DB source ID',
      () {
        final firstDatabaseTask = _databaseTask(
          id: 'db-water-overdue',
          plantId: 'plant-1',
          taskType: 'water',
          dueDate: DateTime(2026, 7, 27),
        );
        final secondDatabaseTask = _databaseTask(
          id: 'db-water-today',
          plantId: 'plant-1',
          taskType: 'watering',
          dueDate: DateTime(2026, 7, 28),
        );
        final derivedTask = CareTask.derived(
          id: 'plant_water_plant-1',
          plantId: 'plant-1',
          plantName: 'Fern',
          taskType: 'Water',
          imageUrl: '',
          dueDate: DateTime(2026, 7, 28),
        );

        final merged = CareTaskPlanner.mergeByPlantAndType(
          databaseTasks: [firstDatabaseTask, secondDatabaseTask],
          derivedTasks: [derivedTask],
        );

        expect(merged, hasLength(1));
        expect(merged.single.id, 'db-water-overdue');
        expect(merged.single.isDerived, isFalse);
        expect(
          merged.single.sourceTaskIds,
          unorderedEquals(['db-water-overdue', 'db-water-today']),
        );
      },
    );
  });

  group('CareTask', () {
    test('fromDbRow preserves plant and source IDs', () {
      final dueDate = DateTime(2026, 7, 28, 10, 15);
      final task = _databaseTask(
        id: 'db-fertilizer',
        plantId: 'plant-42',
        plantName: 'Calathea',
        taskType: 'fertilize',
        dueDate: dueDate,
      );

      expect(task.id, 'db-fertilizer');
      expect(task.plantId, 'plant-42');
      expect(task.plantName, 'Calathea');
      expect(task.taskType, 'Fertilize');
      expect(task.dueDate, dueDate);
      expect(task.sourceTaskIds, ['db-fertilizer']);
      expect(task.isDerived, isFalse);
    });

    test('isOverdueAt compares calendar days and ignores completed tasks', () {
      final overdue = _task(
        id: 'overdue',
        plantId: 'plant-overdue',
        dueDate: DateTime(2026, 7, 27, 23, 59),
      );
      final dueToday = _task(
        id: 'today',
        plantId: 'plant-today',
        dueDate: DateTime(2026, 7, 28),
      );
      final completed = _task(
        id: 'completed',
        plantId: 'plant-completed',
        dueDate: DateTime(2026, 7, 27),
        isCompleted: true,
      );

      expect(overdue.isOverdueAt(now), isTrue);
      expect(dueToday.isOverdueAt(now), isFalse);
      expect(completed.isOverdueAt(now), isFalse);
    });
  });
}

CareTask _task({
  required String id,
  required String plantId,
  required DateTime dueDate,
  bool isCompleted = false,
}) {
  return CareTask(
    id: id,
    plantId: plantId,
    plantName: 'Plant $plantId',
    taskType: 'Water',
    dueDate: dueDate,
    isCompleted: isCompleted,
  );
}

CareTask _databaseTask({
  required String id,
  required String plantId,
  required String taskType,
  required DateTime dueDate,
  String plantName = 'Fern',
  bool isCompleted = false,
}) {
  return CareTask.fromDbRow({
    'id': id,
    'plant_id': plantId,
    'task_type': taskType,
    'due_date': dueDate.toIso8601String(),
    'is_completed': isCompleted,
    'plants': {'id': plantId, 'custom_name': plantName, 'image_url': ''},
  });
}
