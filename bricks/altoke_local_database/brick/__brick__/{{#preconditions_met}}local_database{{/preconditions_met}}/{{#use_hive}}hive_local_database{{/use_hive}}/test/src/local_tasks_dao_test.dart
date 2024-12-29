import 'dart:async';
import 'dart:io';

import 'package:common/common.dart';
import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:{{#use_hive}}hive_local_database{{/use_hive}}/{{#use_hive}}hive_local_database{{/use_hive}}.dart';
import 'package:{{#use_hive}}hive_local_database{{/use_hive}}/src/helpers.dart' as hive;
import 'package:{{#preconditions_met}}local_database{{/preconditions_met}}/{{#preconditions_met}}local_database{{/preconditions_met}}.dart';
import 'package:test/test.dart';

void main() {
  test(
    '''

GIVEN a constructor for a $LocalTasksHiveDao
WHEN the constructor is called
THEN an instance of $LocalTasksHiveDao is returned
''',
    () async {
      final dbDir = Directory.systemTemp.createTempSync('isar-testing-');
      Hive.init(dbDir.path);
      final dao = LocalTasksHiveDao();
      expect(dao, isA<LocalTasksHiveDao>());
      expect(dao, isA<LocalTasksDao>());
      expect(await dao.asyncTasksBox, isNotNull);
      await Hive.close();
      await dbDir.delete(recursive: true);
    },
  );

  group(
    '''

GIVEN a $LocalTasksHiveDao
├─ THAT uses an Isar database''',
    () {
      late Directory dbDir;
      late LocalTasksHiveDao dao;
      late hive.TasksBox tasksBox;

      setUp(() async {
        dbDir = Directory.systemTemp.createTempSync('isar-testing-');
        Hive.init(dbDir.path);
        dao = LocalTasksHiveDao();
        tasksBox = await dao.asyncTasksBox;
      });

      tearDown(() async {
        await Hive.close();
        await dbDir.delete(recursive: true);
      });

      test(
        '''

AND the valid data for a new task
WHEN the task is created
THEN a task record is registered
''',
        () async {
          const newTask = NewTask(
            title: 'title',
            priority: TaskPriority.low,
          );
          bool filter(Map<dynamic, dynamic> task) =>
              task[hive.Task.titleJsonKey] == newTask.title &&
              task[hive.Task.priorityJsonKey] == newTask.priority.identifier &&
              task[hive.Task.descriptionJsonKey] == null;
          final existingMatchingTasksCount =
              tasksBox.values.where(filter).length;
          expect(existingMatchingTasksCount, isZero);
          await dao.createOne(newTask);
          final resultingMatchingTasksCount =
              tasksBox.values.where(filter).length;
          expect(
            resultingMatchingTasksCount,
            existingMatchingTasksCount + 1,
          );
        },
      );

      test(
        '''

AND the invalid data for a new task
WHEN the task is created
THEN an exception is thrown
AND no task record is registered
''',
        () async {
          const newTask = NewTask(
            title: '',
            priority: TaskPriority.high,
          );
          final existingMatchingTasksCount = tasksBox.length;
          expect(existingMatchingTasksCount, isZero);
          expect(
            () async => dao.createOne(newTask),
            throwsA(isA<CreateTaskFailureInvalidData>()),
          );
          final resultingMatchingTasksCount = tasksBox.length;
          expect(resultingMatchingTasksCount, isZero);
        },
      );

      test(
        '''

WHEN all the tasks are watched
THEN the tasks are continuously emitted as they change
''',
        () async {
          final stream = dao.watchAll();

          // Stage 00
          final tasksForStage00 = <Task>[
            const Task(
              id: 0,
              title: 'title 00',
              priority: TaskPriority.high,
              completed: false,
              description: 'description 00',
            ),
            const Task(
              id: 1,
              title: 'title 01',
              priority: TaskPriority.medium,
              completed: true,
            ),
            const Task(
              id: 2,
              title: 'title 02',
              priority: TaskPriority.medium,
              completed: false,
            ),
          ];
          final sortedTasksForStage00 = [...tasksForStage00]
              .sorted((tA, tB) => tA.title.compareTo(tB.title));

          // Stage 01
          const newTaskInStage01 = Task(
            id: 3,
            title: 'title 03',
            priority: TaskPriority.low,
            completed: true,
          );
          final tasksForStage01 = <Task>[
            ...tasksForStage00,
            newTaskInStage01,
          ];
          final sortedTasksForStage01 = [...tasksForStage01]
              .sorted((tA, tB) => tA.title.compareTo(tB.title));

          // Stage 02
          final tasksForStage02 = <Task>[
            for (final task in tasksForStage01)
              if (!task.title.contains('01')) task,
          ];
          final sortedTasksForStage02 = [...tasksForStage02]
              .sorted((tA, tB) => tA.title.compareTo(tB.title));

          // Stage 03
          final tasksForStage03 = <Task>[
            for (final task in tasksForStage02)
              if (task.description == null)
                Task(
                  id: task.id,
                  title: task.title,
                  priority: task.priority,
                  completed: task.completed,
                  description: 'updated description',
                )
              else
                task,
          ];
          final sortedTasksForStage03 = [...tasksForStage03]
              .sorted((tA, tB) => tA.title.compareTo(tB.title));

          unawaited(
            expectLater(
              stream,
              emitsInOrder(
                [
                  orderedEquals(sortedTasksForStage00),
                  orderedEquals(sortedTasksForStage01),
                  orderedEquals(sortedTasksForStage02),
                  orderedEquals(sortedTasksForStage03),
                ],
              ),
            ),
          );

          // Stage 00
          await tasksBox.putAll({
            for (final task in tasksForStage00)
              task.id: {
                hive.Task.titleJsonKey: task.title,
                hive.Task.priorityJsonKey: task.priority.identifier,
                hive.Task.completedJsonKey: task.completed,
                hive.Task.descriptionJsonKey: task.description,
              },
          });

          // Stage 01
          await tasksBox.put(
            newTaskInStage01.id,
            {
              hive.Task.titleJsonKey: newTaskInStage01.title,
              hive.Task.priorityJsonKey: newTaskInStage01.priority.identifier,
              hive.Task.completedJsonKey: newTaskInStage01.completed,
              hive.Task.descriptionJsonKey: newTaskInStage01.description,
            },
          );

          // Stage 02
          {
            final keysToDelete = tasksBox.toMap().entries.where(
              (entry) {
                final title = entry.value[hive.Task.titleJsonKey];
                if (title is! String) return false;
                return title.contains('01');
              },
            ).map(
              (taskRecordEntry) => taskRecordEntry.key,
            );
            await tasksBox.deleteAll(keysToDelete);
          }

          // Stage 03
          {
            final updatedTaskRecordEntries = tasksBox
                .toMap()
                .entries
                .where(
                  (entry) => entry.value[hive.Task.descriptionJsonKey] == null,
                )
                .map(
                  (entry) => entry
                    ..value[hive.Task.descriptionJsonKey] =
                        'updated description',
                );
            await tasksBox.putAll(Map.fromEntries(updatedTaskRecordEntries));
          }
        },
      );

      test(
        '''

AND the ID of a registered task
AND the valid partial task data
WHEN the task is updated
THEN a task record is updated
''',
        () async {
          const taskId = 31;
          final task = {
            hive.Task.titleJsonKey: 'title',
            hive.Task.priorityJsonKey: TaskPriority.high.identifier,
            hive.Task.completedJsonKey: false,
            hive.Task.descriptionJsonKey: 'description',
          };
          await tasksBox.put(taskId, task);
          final existingTasksCount = tasksBox.length;
          expect(existingTasksCount, 1);
          const newTitle = 'new title';
          const newPriority = TaskPriority.low;
          const newCompleted = true;
          const newDescription = 'new description';

          bool filter(MapEntry<dynamic, Map<dynamic, dynamic>> rawTask) {
            final MapEntry(key: id, value: data) = rawTask;
            return id == taskId &&
                (data[hive.Task.titleJsonKey] as String) == newTitle &&
                (data[hive.Task.priorityJsonKey] as String).toTaskPriority() ==
                    newPriority &&
                (data[hive.Task.completedJsonKey] as bool) == newCompleted &&
                data[hive.Task.descriptionJsonKey] == newDescription;
          }

          final existingMatchingTasksCount =
              tasksBox.toMap().entries.where(filter).length;
          expect(existingMatchingTasksCount, isZero);
          await dao.updateOneById(
            taskId: taskId,
            task: const PartialTask(
              title: Some(newTitle),
              priority: Some(newPriority),
              completed: Some(newCompleted),
              description: Some(newDescription),
            ),
          );
          final resultingMatchingTasksCount =
              tasksBox.toMap().entries.where(filter).length;
          expect(
            resultingMatchingTasksCount,
            existingMatchingTasksCount + 1,
          );
        },
      );

      test(
        '''

AND the ID of an unregistered task
AND the valid partial task data
WHEN the task is updated
THEN an exception is thrown
AND no task record is updated
''',
        () async {
          final existingTasksCount = tasksBox.length;
          expect(existingTasksCount, isZero);
          const taskId = 31;
          const newTitle = 'new title';
          const newPriority = TaskPriority.low;
          const newCompleted = true;
          const newDescription = 'new description';

          bool filter(MapEntry<dynamic, Map<dynamic, dynamic>> rawTask) {
            final MapEntry(key: id, value: data) = rawTask;
            return id == taskId &&
                (data[hive.Task.titleJsonKey] as String) == newTitle &&
                (data[hive.Task.priorityJsonKey] as String).toTaskPriority() ==
                    newPriority &&
                (data[hive.Task.completedJsonKey] as bool) == newCompleted &&
                data[hive.Task.descriptionJsonKey] == newDescription;
          }

          final existingMatchingTasksCount =
              tasksBox.toMap().entries.where(filter).length;
          expect(existingMatchingTasksCount, isZero);
          expect(
            () async => dao.updateOneById(
              taskId: taskId,
              task: const PartialTask(
                title: Some(newTitle),
                priority: Some(newPriority),
                completed: Some(newCompleted),
                description: Some(newDescription),
              ),
            ),
            throwsA(isA<UpdateTaskFailureNotFound>()),
          );
          final resultingMatchingTasksCount =
              tasksBox.toMap().entries.where(filter).length;
          expect(resultingMatchingTasksCount, isZero);
        },
      );

      test(
        '''

AND the ID of a registered task
AND the invalid partial task data
WHEN the task is updated
THEN an exception is thrown
AND no task record is updated
''',
        () async {
          const taskId = 31;
          final task = {
            hive.Task.titleJsonKey: 'title',
            hive.Task.priorityJsonKey: TaskPriority.low.identifier,
            hive.Task.completedJsonKey: true,
            hive.Task.descriptionJsonKey: 'description',
          };
          await tasksBox.put(taskId, task);
          final existingTasksCount = tasksBox.length;
          expect(existingTasksCount, 1);
          const newTitle = '';
          const newPriority = TaskPriority.high;
          const newCompleted = false;
          const newDescription = '';

          bool filter(MapEntry<dynamic, Map<dynamic, dynamic>> rawTask) {
            final MapEntry(key: id, value: data) = rawTask;
            return id == taskId &&
                (data[hive.Task.titleJsonKey] as String) == newTitle &&
                (data[hive.Task.priorityJsonKey] as String).toTaskPriority() ==
                    newPriority &&
                (data[hive.Task.completedJsonKey] as bool) == newCompleted &&
                data[hive.Task.descriptionJsonKey] == newDescription;
          }

          final existingMatchingTasksCount =
              tasksBox.toMap().entries.where(filter).length;
          expect(existingMatchingTasksCount, isZero);
          expect(
            () async => dao.updateOneById(
              taskId: taskId,
              task: const PartialTask(
                title: Some(newTitle),
                priority: Some(newPriority),
                completed: Some(newCompleted),
                description: Some(newDescription),
              ),
            ),
            throwsA(isA<UpdateTaskFailureInvalidData>()),
          );
          final resultingMatchingTasksCount =
              tasksBox.toMap().entries.where(filter).length;
          expect(resultingMatchingTasksCount, isZero);
        },
      );

      test(
        '''

│  ├─ THAT has task records
AND the ID of a registered task
WHEN the task is deleted
THEN the task record is dropped
AND the deleted task is returned
''',
        () async {
          const taskId = 13;
          final task = {
            hive.Task.titleJsonKey: 'title',
            hive.Task.priorityJsonKey: TaskPriority.low.identifier,
            hive.Task.completedJsonKey: true,
            hive.Task.descriptionJsonKey: 'description',
          };
          await tasksBox.put(taskId, task);
          bool filter(MapEntry<dynamic, Map<dynamic, dynamic>> rawTask) =>
              rawTask.key == taskId;
          final initialMatchingTasksCount =
              tasksBox.toMap().entries.where(filter).length;
          expect(initialMatchingTasksCount, 1);
          await dao.deleteOneById(taskId);
          final resultingMatchingTasksCount =
              tasksBox.toMap().entries.where(filter).length;
          expect(resultingMatchingTasksCount, isZero);
        },
      );
    },
  );
}
