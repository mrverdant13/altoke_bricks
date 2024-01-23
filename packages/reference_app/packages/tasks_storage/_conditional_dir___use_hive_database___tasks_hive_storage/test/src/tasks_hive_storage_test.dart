import 'dart:async';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:tasks/tasks.dart';
import 'package:tasks_hive_storage/src/tasks_hive_storage.dart';
import 'package:tasks_storage/tasks_storage.dart';
import 'package:test/test.dart';

void main() {
  test(
    '''

GIVEN a constructor for a tasks storage
├─ THAT uses a Hive box
WHEN the constructor is called
THEN an instance of the storage is returned
''',
    () async {
      final databaseDir = Directory.systemTemp.createTempSync('hive-testing-');
      Hive.init(databaseDir.path);
      final box =
          await Hive.openBox<Map<dynamic, dynamic>>(TasksHiveStorage.boxName);
      final storage = TasksHiveStorage(box: box);
      expect(storage, isNotNull);
      expect(storage, isA<TasksStorage>());
      await Hive.close();
      await databaseDir.delete(recursive: true);
    },
  );

  group(
    '''

GIVEN a tasks storage
├─ THAT uses a Hive box''',
    () {
      late Directory databaseDir;
      late Box<Map<dynamic, dynamic>> box;
      late TasksHiveStorage storage;

      setUp(() async {
        databaseDir = Directory.systemTemp.createTempSync(
          'hive-testing-',
        );
        Hive.init(databaseDir.path);
        box = await Hive.openBox(TasksHiveStorage.boxName);
        storage = TasksHiveStorage(box: box);
      });

      tearDown(() async {
        await box.close();
        await Hive.close();
        await databaseDir.delete(recursive: true);
      });

      test(
        '''

│  ├─ THAT does not have task records
AND the valid data for a new task
WHEN the task is created
THEN a task record is registered
''',
        () async {
          const newTask = NewTask(
            title: 'title',
            description: 'description',
          );
          final existingTasksCount = box.length;
          expect(existingTasksCount, isZero);
          await storage.create(newTask: newTask);
          bool filter(Map<dynamic, dynamic> rawTask) =>
              rawTask[HiveTask.titleFieldJsonKey] == newTask.title &&
              rawTask[HiveTask.descriptionFieldJsonKey] == newTask.description;
          final resultingMatchingTasksCount = box.values.where(filter).length;
          expect(resultingMatchingTasksCount, existingTasksCount + 1);
        },
      );

      test(
        '''

│  ├─ THAT has task records
AND the valid data for a new task
WHEN the task is created
THEN a task record is registered
''',
        () async {
          const existingTaskId = 13;
          const existingTask = NewTask(
            title: 'title',
            description: 'description',
          );
          await box.put(existingTaskId, existingTask.toHiveJson());
          final initialTasksCount = box.length;
          expect(initialTasksCount, 1);
          const newTask = NewTask(
            title: 'title',
            description: 'description',
          );
          await storage.create(newTask: newTask);
          bool filter(Map<dynamic, dynamic> rawTask) =>
              rawTask[HiveTask.titleFieldJsonKey] == newTask.title &&
              rawTask[HiveTask.descriptionFieldJsonKey] == newTask.description;
          final resultingMatchingTasksCount = box.values.where(filter).length;
          expect(resultingMatchingTasksCount, initialTasksCount + 1);
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
            description: 'description',
          );
          final existingTasksCount = box.length;
          expect(existingTasksCount, isZero);
          expect(
            () async => storage.create(newTask: newTask),
            throwsA(isA<CreateTaskFailureEmptyTitle>()),
          );
          final resultingTasksCount = box.length;
          expect(resultingTasksCount, isZero);
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
          const newTask = NewTask(title: 'title', description: 'description');
          await box.put(taskId, newTask.toHiveJson());
          bool filter(dynamic key) => key == taskId;
          final initialMatchingTasksCount = box.keys.where(filter).length;
          expect(initialMatchingTasksCount, 1);
          final deletedTask = await storage.delete(taskId: taskId);
          expect(deletedTask, isNotNull);
          expect(deletedTask?.id, taskId);
          final resultingMatchingTasksCount = box.keys.where(filter).length;
          expect(resultingMatchingTasksCount, isZero);
        },
      );

      test(
        '''

│  ├─ THAT has task records
AND the ID of an unregistered task
WHEN the task is deleted
THEN no task record is dropped
AND null is returned
''',
        () async {
          const taskId = 17;
          const newTask = NewTask(title: 'title', description: 'description');
          await box.add(newTask.toHiveJson());
          final initialTaskEntries = box.toMap().entries;
          expect(initialTaskEntries, hasLength(1));
          final initialTaskEntry = initialTaskEntries.single;
          expect(initialTaskEntry.key, isNot(taskId));
          final deletedTask = await storage.delete(taskId: taskId);
          expect(deletedTask, isNull);
          final resultingTaskEntries = box.toMap().entries;
          expect(resultingTaskEntries, hasLength(1));
          final resultingTaskEntry = resultingTaskEntries.single;
          expect(resultingTaskEntry.toTask(), initialTaskEntry.toTask());
        },
      );

      test(
        '''

│  ├─ THAT has several task records
AND a reference task
├─ THAT includes a non-null title matcher
├─ AND includes a non-null status matcher
├─ AND includes a non-null description matcher
WHEN a delete operation is performed with the reference task
THEN the task records matching the reference task are dropped
AND the task records not matching the reference task are kept
''',
        () async {
          final tasks = [
            Task(
              id: 0,
              title: 'title 0',
              description: 'description 0',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 0),
            ),
            Task(
              id: 1,
              title: 'title 1 matching-pattern',
              description: 'description 1',
              isCompleted: true,
              // ignore: avoid_redundant_argument_values
              createdAt: DateTime(2020, 1, 1),
            ),
            Task(
              id: 2,
              title: 'title 2',
              description: 'description 2 matching-pattern',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 2),
            ),
            Task(
              id: 3,
              title: 'title 3 matching-pattern',
              description: 'description 3 matching-pattern',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 3),
            ),
            Task(
              id: 4,
              title: 'title 4',
              description: 'description 4',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 4),
            ),
            Task(
              id: 5,
              title: 'title 5 matching-pattern',
              description: 'description 5',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 5),
            ),
            Task(
              id: 6,
              title: 'title 6',
              description: 'description 6 matching-pattern',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 6),
            ),
            Task(
              id: 7,
              title: 'title 7 matching-pattern',
              description: 'description 7 matching-pattern',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 7),
            ),
            Task(
              id: 8,
              title: 'title 8',
              description: 'description 8',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 8),
            ),
            Task(
              id: 9,
              title: 'title 9 matching-pattern',
              description: 'description 9',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 9),
            ),
            Task(
              id: 10,
              title: 'title 10',
              description: 'description 10 matching-pattern',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 10),
            ),
            Task(
              id: 11,
              title: 'title 11 matching-pattern',
              description: 'description 11 matching-pattern',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 11),
            ),
            Task(
              id: 12,
              title: 'title 12',
              description: 'description 12',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 12),
            ),
            Task(
              id: 13,
              title: 'title 13 matching-pattern',
              description: 'description 13',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 13),
            ),
            Task(
              id: 14,
              title: 'title 14',
              description: 'description 14 matching-pattern',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 14),
            ),
            Task(
              id: 15,
              title: 'title 15 matching-pattern',
              description: 'description 15 matching-pattern',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 15),
            ),
          ];
          await box.putAll({
            for (final task in tasks) task.id: task.toHiveJson(),
          });
          final initialTasksCount = box.length;
          expect(initialTasksCount, tasks.length);
          final referenceTask = PartialTask(
            title: () => 'matching-pattern',
            description: () => 'matching-pattern',
            isCompleted: () => false,
          );
          await storage.deleteAll(referenceTask: referenceTask);
          final resultingTaskRecordEntries = box.toMap().entries;

          bool shouldBeKept(Task task) {
            final Task(:title, :description, :isCompleted) = task;
            final noMatchInTitle = !title.contains('matching-pattern');
            if (noMatchInTitle) return true;
            if (description == null) return true;
            final noMatchInDescription =
                !description.contains('matching-pattern');
            if (noMatchInDescription) return true;
            final noMatchInStatus = isCompleted != false;
            return noMatchInStatus;
          }

          final expectedResultingTasks = [
            for (final task in tasks)
              if (shouldBeKept(task)) task,
          ];
          expect(
            resultingTaskRecordEntries,
            hasLength(expectedResultingTasks.length),
          );
          final resultingTasks = [
            for (final taskRecordEntry in resultingTaskRecordEntries)
              taskRecordEntry.toTask(),
          ];
          expect(resultingTasks, unorderedEquals(expectedResultingTasks));
        },
      );

      test(
        '''

│  ├─ THAT has several task records
AND a reference task
├─ THAT includes a null title matcher
├─ AND includes a non-null status matcher
├─ AND includes a non-null description matcher
WHEN a delete operation is performed with the reference task
THEN the task records matching the reference task are dropped
AND the task records not matching the reference task are kept
''',
        () async {
          final tasks = [
            Task(
              id: 0,
              title: 'title 0',
              description: 'description 0',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 0),
            ),
            Task(
              id: 1,
              title: 'title 1 matching-pattern',
              description: 'description 1',
              isCompleted: true,
              // ignore: avoid_redundant_argument_values
              createdAt: DateTime(2020, 1, 1),
            ),
            Task(
              id: 2,
              title: 'title 2',
              description: 'description 2 matching-pattern',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 2),
            ),
            Task(
              id: 3,
              title: 'title 3 matching-pattern',
              description: 'description 3 matching-pattern',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 3),
            ),
            Task(
              id: 4,
              title: 'title 4',
              description: 'description 4',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 4),
            ),
            Task(
              id: 5,
              title: 'title 5 matching-pattern',
              description: 'description 5',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 5),
            ),
            Task(
              id: 6,
              title: 'title 6',
              description: 'description 6 matching-pattern',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 6),
            ),
            Task(
              id: 7,
              title: 'title 7 matching-pattern',
              description: 'description 7 matching-pattern',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 7),
            ),
            Task(
              id: 8,
              title: 'title 8',
              description: 'description 8',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 8),
            ),
            Task(
              id: 9,
              title: 'title 9 matching-pattern',
              description: 'description 9',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 9),
            ),
            Task(
              id: 10,
              title: 'title 10',
              description: 'description 10 matching-pattern',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 10),
            ),
            Task(
              id: 11,
              title: 'title 11 matching-pattern',
              description: 'description 11 matching-pattern',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 11),
            ),
            Task(
              id: 12,
              title: 'title 12',
              description: 'description 12',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 12),
            ),
            Task(
              id: 13,
              title: 'title 13 matching-pattern',
              description: 'description 13',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 13),
            ),
            Task(
              id: 14,
              title: 'title 14',
              description: 'description 14 matching-pattern',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 14),
            ),
            Task(
              id: 15,
              title: 'title 15 matching-pattern',
              description: 'description 15 matching-pattern',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 15),
            ),
          ];
          await box.putAll({
            for (final task in tasks) task.id: task.toHiveJson(),
          });
          final initialTasksCount = box.length;
          expect(initialTasksCount, tasks.length);
          final referenceTask = PartialTask(
            description: () => 'matching-pattern',
            isCompleted: () => false,
          );
          await storage.deleteAll(referenceTask: referenceTask);
          final resultingTaskRecordEntries = box.toMap().entries;

          bool shouldBeKept(Task task) {
            final Task(:description, :isCompleted) = task;
            if (description == null) return true;
            final noMatchInDescription =
                !description.contains('matching-pattern');
            if (noMatchInDescription) return true;
            final noMatchInStatus = isCompleted != false;
            return noMatchInStatus;
          }

          final expectedResultingTasks = [
            for (final task in tasks)
              if (shouldBeKept(task)) task,
          ];
          expect(
            resultingTaskRecordEntries,
            hasLength(expectedResultingTasks.length),
          );
          final resultingTasks = [
            for (final taskRecordEntry in resultingTaskRecordEntries)
              taskRecordEntry.toTask(),
          ];
          expect(resultingTasks, unorderedEquals(expectedResultingTasks));
        },
      );

      test(
        '''

│  ├─ THAT has several task records
AND a reference task
├─ THAT includes a non-null title matcher
├─ AND includes a null status matcher
├─ AND includes a non-null description matcher
WHEN a delete operation is performed with the reference task
THEN the task records matching the reference task are dropped
AND the task records not matching the reference task are kept
''',
        () async {
          final tasks = [
            Task(
              id: 0,
              title: 'title 0',
              description: 'description 0',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 0),
            ),
            Task(
              id: 1,
              title: 'title 1 matching-pattern',
              description: 'description 1',
              isCompleted: true,
              // ignore: avoid_redundant_argument_values
              createdAt: DateTime(2020, 1, 1),
            ),
            Task(
              id: 2,
              title: 'title 2',
              description: 'description 2 matching-pattern',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 2),
            ),
            Task(
              id: 3,
              title: 'title 3 matching-pattern',
              description: 'description 3 matching-pattern',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 3),
            ),
            Task(
              id: 4,
              title: 'title 4',
              description: 'description 4',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 4),
            ),
            Task(
              id: 5,
              title: 'title 5 matching-pattern',
              description: 'description 5',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 5),
            ),
            Task(
              id: 6,
              title: 'title 6',
              description: 'description 6 matching-pattern',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 6),
            ),
            Task(
              id: 7,
              title: 'title 7 matching-pattern',
              description: 'description 7 matching-pattern',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 7),
            ),
            Task(
              id: 8,
              title: 'title 8',
              description: 'description 8',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 8),
            ),
            Task(
              id: 9,
              title: 'title 9 matching-pattern',
              description: 'description 9',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 9),
            ),
            Task(
              id: 10,
              title: 'title 10',
              description: 'description 10 matching-pattern',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 10),
            ),
            Task(
              id: 11,
              title: 'title 11 matching-pattern',
              description: 'description 11 matching-pattern',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 11),
            ),
            Task(
              id: 12,
              title: 'title 12',
              description: 'description 12',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 12),
            ),
            Task(
              id: 13,
              title: 'title 13 matching-pattern',
              description: 'description 13',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 13),
            ),
            Task(
              id: 14,
              title: 'title 14',
              description: 'description 14 matching-pattern',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 14),
            ),
            Task(
              id: 15,
              title: 'title 15 matching-pattern',
              description: 'description 15 matching-pattern',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 15),
            ),
          ];
          await box.putAll({
            for (final task in tasks) task.id: task.toHiveJson(),
          });
          final initialTasksCount = box.length;
          expect(initialTasksCount, tasks.length);
          final referenceTask = PartialTask(
            title: () => 'matching-pattern',
            description: () => 'matching-pattern',
          );
          await storage.deleteAll(referenceTask: referenceTask);
          final resultingTaskRecordEntries = box.toMap().entries;

          bool shouldBeKept(Task task) {
            final Task(:title, :description) = task;
            final noMatchInTitle = !title.contains('matching-pattern');
            if (noMatchInTitle) return true;
            if (description == null) return true;
            final noMatchInDescription =
                !description.contains('matching-pattern');
            return noMatchInDescription;
          }

          final expectedResultingTasks = [
            for (final task in tasks)
              if (shouldBeKept(task)) task,
          ];
          expect(
            resultingTaskRecordEntries,
            hasLength(expectedResultingTasks.length),
          );
          final resultingTasks = [
            for (final taskRecordEntry in resultingTaskRecordEntries)
              taskRecordEntry.toTask(),
          ];
          expect(resultingTasks, unorderedEquals(expectedResultingTasks));
        },
      );

      test(
        '''

│  ├─ THAT has several task records
AND a reference task
├─ THAT includes a non-null title matcher
├─ AND includes a non-null status matcher
├─ AND includes a null description matcher
WHEN a delete operation is performed with the reference task
THEN the task records matching the reference task are dropped
AND the task records not matching the reference task are kept
''',
        () async {
          final tasks = [
            Task(
              id: 0,
              title: 'title 0',
              description: 'description 0',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 0),
            ),
            Task(
              id: 1,
              title: 'title 1 matching-pattern',
              description: 'description 1',
              isCompleted: true,
              // ignore: avoid_redundant_argument_values
              createdAt: DateTime(2020, 1, 1),
            ),
            Task(
              id: 2,
              title: 'title 2',
              description: 'description 2 matching-pattern',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 2),
            ),
            Task(
              id: 3,
              title: 'title 3 matching-pattern',
              description: 'description 3 matching-pattern',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 3),
            ),
            Task(
              id: 4,
              title: 'title 4',
              description: 'description 4',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 4),
            ),
            Task(
              id: 5,
              title: 'title 5 matching-pattern',
              description: 'description 5',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 5),
            ),
            Task(
              id: 6,
              title: 'title 6',
              description: 'description 6 matching-pattern',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 6),
            ),
            Task(
              id: 7,
              title: 'title 7 matching-pattern',
              description: 'description 7 matching-pattern',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 7),
            ),
            Task(
              id: 8,
              title: 'title 8',
              description: 'description 8',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 8),
            ),
            Task(
              id: 9,
              title: 'title 9 matching-pattern',
              description: 'description 9',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 9),
            ),
            Task(
              id: 10,
              title: 'title 10',
              description: 'description 10 matching-pattern',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 10),
            ),
            Task(
              id: 11,
              title: 'title 11 matching-pattern',
              description: 'description 11 matching-pattern',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 11),
            ),
            Task(
              id: 12,
              title: 'title 12',
              description: 'description 12',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 12),
            ),
            Task(
              id: 13,
              title: 'title 13 matching-pattern',
              description: 'description 13',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 13),
            ),
            Task(
              id: 14,
              title: 'title 14',
              description: 'description 14 matching-pattern',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 14),
            ),
            Task(
              id: 15,
              title: 'title 15 matching-pattern',
              description: 'description 15 matching-pattern',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 15),
            ),
          ];
          await box.putAll({
            for (final task in tasks) task.id: task.toHiveJson(),
          });
          final initialTasksCount = box.length;
          expect(initialTasksCount, tasks.length);
          final referenceTask = PartialTask(
            title: () => 'matching-pattern',
            isCompleted: () => false,
          );
          await storage.deleteAll(referenceTask: referenceTask);
          final resultingTaskRecordEntries = box.toMap().entries;

          bool shouldBeKept(Task task) {
            final Task(:title, :isCompleted) = task;
            final noMatchInTitle = !title.contains('matching-pattern');
            if (noMatchInTitle) return true;
            final noMatchInStatus = isCompleted != false;
            return noMatchInStatus;
          }

          final expectedResultingTasks = [
            for (final task in tasks)
              if (shouldBeKept(task)) task,
          ];
          expect(
            resultingTaskRecordEntries,
            hasLength(expectedResultingTasks.length),
          );
          final resultingTasks = [
            for (final taskRecordEntry in resultingTaskRecordEntries)
              taskRecordEntry.toTask(),
          ];
          expect(resultingTasks, unorderedEquals(expectedResultingTasks));
        },
      );

      test(
        '''

│  ├─ THAT has several task records
AND a reference task
├─ THAT includes a non-null title matcher
├─ AND includes a non-null status matcher
├─ AND includes a non-null empty description matcher
WHEN a delete operation is performed with the reference task
THEN the task records matching the reference task are dropped
AND the task records not matching the reference task are kept
''',
        () async {
          final tasks = [
            Task(
              id: 0,
              title: 'title 0',
              description: 'description 0',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 0),
            ),
            Task(
              id: 1,
              title: 'title 1 matching-pattern',
              description: 'description 1',
              isCompleted: true,
              // ignore: avoid_redundant_argument_values
              createdAt: DateTime(2020, 1, 1),
            ),
            Task(
              id: 2,
              title: 'title 2',
              description: 'description 2 matching-pattern',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 2),
            ),
            Task(
              id: 3,
              title: 'title 3 matching-pattern',
              description: 'description 3 matching-pattern',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 3),
            ),
            Task(
              id: 4,
              title: 'title 4',
              description: 'description 4',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 4),
            ),
            Task(
              id: 5,
              title: 'title 5 matching-pattern',
              description: 'description 5',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 5),
            ),
            Task(
              id: 6,
              title: 'title 6',
              description: 'description 6 matching-pattern',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 6),
            ),
            Task(
              id: 7,
              title: 'title 7 matching-pattern',
              description: 'description 7 matching-pattern',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 7),
            ),
            Task(
              id: 8,
              title: 'title 8',
              description: 'description 8',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 8),
            ),
            Task(
              id: 9,
              title: 'title 9 matching-pattern',
              description: 'description 9',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 9),
            ),
            Task(
              id: 10,
              title: 'title 10',
              description: 'description 10 matching-pattern',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 10),
            ),
            Task(
              id: 11,
              title: 'title 11 matching-pattern',
              description: 'description 11 matching-pattern',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 11),
            ),
            Task(
              id: 12,
              title: 'title 12',
              description: 'description 12',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 12),
            ),
            Task(
              id: 13,
              title: 'title 13 matching-pattern',
              description: 'description 13',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 13),
            ),
            Task(
              id: 14,
              title: 'title 14',
              description: 'description 14 matching-pattern',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 14),
            ),
            Task(
              id: 15,
              title: 'title 15 matching-pattern',
              description: 'description 15 matching-pattern',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 15),
            ),
          ];
          await box.putAll({
            for (final task in tasks) task.id: task.toHiveJson(),
          });
          final initialTasksCount = box.length;
          expect(initialTasksCount, tasks.length);
          final referenceTask = PartialTask(
            title: () => 'matching-pattern',
            isCompleted: () => false,
            description: () => '',
          );
          await storage.deleteAll(referenceTask: referenceTask);
          final resultingTaskRecordEntries = box.toMap().entries;

          bool shouldBeKept(Task task) {
            final Task(:title, :isCompleted) = task;
            final noMatchInTitle = !title.contains('matching-pattern');
            if (noMatchInTitle) return true;
            final noMatchInStatus = isCompleted != false;
            return noMatchInStatus;
          }

          final expectedResultingTasks = [
            for (final task in tasks)
              if (shouldBeKept(task)) task,
          ];
          expect(
            resultingTaskRecordEntries,
            hasLength(expectedResultingTasks.length),
          );
          final resultingTasks = [
            for (final taskRecordEntry in resultingTaskRecordEntries)
              taskRecordEntry.toTask(),
          ];
          expect(resultingTasks, unorderedEquals(expectedResultingTasks));
        },
      );

      test(
        '''

│  ├─ THAT has several task records
AND a reference task
├─ THAT includes an empty description matcher
WHEN a delete operation is performed with the reference task
THEN the task records matching the reference task are dropped
AND the task records not matching the reference task are kept
''',
        () async {
          final tasks = [
            Task(
              id: 0,
              title: 'title 0',
              description: 'description 0',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 0),
            ),
            Task(
              id: 1,
              title: 'title 1 matching-pattern',
              description: 'description 1',
              isCompleted: true,
              // ignore: avoid_redundant_argument_values
              createdAt: DateTime(2020, 1, 1),
            ),
            Task(
              id: 2,
              title: 'title 2',
              // ignore: avoid_redundant_argument_values
              description: null,
              isCompleted: true,
              createdAt: DateTime(2020, 1, 2),
            ),
            Task(
              id: 3,
              title: 'title 3 matching-pattern',
              // ignore: avoid_redundant_argument_values
              description: null,
              isCompleted: true,
              createdAt: DateTime(2020, 1, 3),
            ),
            Task(
              id: 4,
              title: 'title 4',
              description: 'description 4',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 4),
            ),
            Task(
              id: 5,
              title: 'title 5 matching-pattern',
              description: 'description 5',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 5),
            ),
            Task(
              id: 6,
              title: 'title 6',
              // ignore: avoid_redundant_argument_values
              description: null,
              isCompleted: false,
              createdAt: DateTime(2020, 1, 6),
            ),
            Task(
              id: 7,
              title: 'title 7 matching-pattern',
              // ignore: avoid_redundant_argument_values
              description: null,
              isCompleted: false,
              createdAt: DateTime(2020, 1, 7),
            ),
            Task(
              id: 8,
              title: 'title 8',
              description: 'description 8',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 8),
            ),
            Task(
              id: 9,
              title: 'title 9 matching-pattern',
              description: 'description 9',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 9),
            ),
            Task(
              id: 10,
              title: 'title 10',
              // ignore: avoid_redundant_argument_values
              description: null,
              isCompleted: true,
              createdAt: DateTime(2020, 1, 10),
            ),
            Task(
              id: 11,
              title: 'title 11 matching-pattern',
              // ignore: avoid_redundant_argument_values
              description: null,
              isCompleted: true,
              createdAt: DateTime(2020, 1, 11),
            ),
            Task(
              id: 12,
              title: 'title 12',
              description: 'description 12',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 12),
            ),
            Task(
              id: 13,
              title: 'title 13 matching-pattern',
              description: 'description 13',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 13),
            ),
            Task(
              id: 14,
              title: 'title 14',
              // ignore: avoid_redundant_argument_values
              description: null,
              isCompleted: false,
              createdAt: DateTime(2020, 1, 14),
            ),
            Task(
              id: 15,
              title: 'title 15 matching-pattern',
              // ignore: avoid_redundant_argument_values
              description: null,
              isCompleted: false,
              createdAt: DateTime(2020, 1, 15),
            ),
          ];
          await box.putAll({
            for (final task in tasks) task.id: task.toHiveJson(),
          });
          final initialTasksCount = box.length;
          expect(initialTasksCount, tasks.length);
          final referenceTask = PartialTask(
            title: () => 'matching-pattern',
            description: () => null,
            isCompleted: () => false,
          );
          await storage.deleteAll(referenceTask: referenceTask);
          final resultingTasksRecordEntries = box.toMap().entries;

          bool shouldBeKept(Task task) {
            final Task(:title, :description, :isCompleted) = task;
            final noMatchInTitle = !title.contains('matching-pattern');
            if (noMatchInTitle) return true;
            final noMatchInDescription =
                description != null && description.isNotEmpty;
            if (noMatchInDescription) return true;
            final noMatchInStatus = isCompleted != false;
            return noMatchInStatus;
          }

          final expectedResultingTasks = [
            for (final task in tasks)
              if (shouldBeKept(task)) task,
          ];
          expect(
            resultingTasksRecordEntries,
            hasLength(expectedResultingTasks.length),
          );
          final resultingTasks = [
            for (final taskRecordEntry in resultingTasksRecordEntries)
              taskRecordEntry.toTask(),
          ];
          expect(resultingTasks, unorderedEquals(expectedResultingTasks));
        },
      );

      test(
        '''

│  ├─ THAT has several task records
WHEN a delete operation is performed with no reference task
THEN all task records are dropped
''',
        () async {
          final tasks = List.generate(
            30,
            (index) => Task(
              id: index,
              title: 'title $index',
              description: 'description $index',
              isCompleted: index % 7 == 0,
              createdAt: DateTime.now(),
            ),
          );
          await box.putAll({
            for (final task in tasks) task.id: task.toHiveJson(),
          });
          final initialTasksCount = box.length;
          expect(initialTasksCount, tasks.length);
          await storage.deleteAll();
          final resultingTaskRecordEntriesCount = box.length;
          expect(resultingTaskRecordEntriesCount, isZero);
        },
      );

      test(
        '''

AND a task
WHEN the task is inserted
THEN a task record is registered
''',
        () async {
          final task = Task(
            id: 83,
            title: 'title',
            description: 'description',
            isCompleted: false,
            createdAt: DateTime.now(),
          );
          final existingTasksCount = box.length;
          expect(existingTasksCount, isZero);
          await storage.insert(task: task);
          final resultingTaskRecordEntries = box.toMap().entries;
          expect(resultingTaskRecordEntries, hasLength(1));
          final resultingTaskRecordEntry = resultingTaskRecordEntries.single;
          expect(resultingTaskRecordEntry.toTask(), task);
        },
      );

      test(
        '''

│  ├─ THAT has several task records
WHEN all tasks are marked as completed
THEN all task records are updated
''',
        () async {
          final tasks = List.generate(
            30,
            (index) => Task(
              id: index,
              title: 'title $index',
              description: 'description $index',
              isCompleted: index % 7 == 0,
              createdAt: DateTime.now(),
            ),
          );
          await box.putAll({
            for (final task in tasks) task.id: task.toHiveJson(),
          });
          bool filter(Map<dynamic, dynamic> rawTask) =>
              !(rawTask[HiveTask.statusFieldJsonKey] as bool);
          final initialIncompleteTasksCount = box.values.where(filter).length;
          expect(initialIncompleteTasksCount, isPositive);
          await storage.markAllAsCompleted();
          final resultingIncompleteTasksCount = box.values.where(filter).length;
          expect(resultingIncompleteTasksCount, isZero);
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
          final task = Task(
            id: 31,
            title: 'title',
            description: 'description',
            isCompleted: false,
            createdAt: DateTime.now(),
          );
          await box.put(task.id, task.toHiveJson());
          final existingTasksCount = box.length;
          expect(existingTasksCount, 1);
          const newTitle = 'new title';
          const newDescription = 'new description';
          const newStatus = true;
          bool filter(TaskRecordEntry rawTask) =>
              rawTask.key == task.id &&
              rawTask.value[HiveTask.titleFieldJsonKey] == newTitle &&
              rawTask.value[HiveTask.descriptionFieldJsonKey] ==
                  newDescription &&
              rawTask.value[HiveTask.statusFieldJsonKey] == newStatus;
          final existingMatchingTasksCount =
              box.toMap().entries.where(filter).length;
          expect(existingMatchingTasksCount, isZero);
          await storage.update(
            taskId: task.id,
            partialTask: PartialTask(
              title: () => newTitle,
              description: () => newDescription,
              isCompleted: () => newStatus,
            ),
          );
          final resultingMatchingTasksCount =
              box.toMap().entries.where(filter).length;
          expect(resultingMatchingTasksCount, existingMatchingTasksCount + 1);
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
            description: 'description',
          );
          final existingTasksCount = box.length;
          expect(existingTasksCount, isZero);
          expect(
            () async => storage.create(newTask: newTask),
            throwsA(isA<CreateTaskFailureEmptyTitle>()),
          );
          final resultingTasksCount = box.length;
          expect(resultingTasksCount, isZero);
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
          final task = Task(
            id: 103,
            title: 'title',
            description: 'description',
            isCompleted: false,
            createdAt: DateTime.now(),
          );
          await box.put(task.id, task.toHiveJson());
          final existingTasksCount = box.length;
          expect(existingTasksCount, 1);
          const newTitle = '';
          const newDescription = 'new description';
          const newStatus = true;
          bool filter(TaskRecordEntry rawTask) =>
              rawTask.key == task.id &&
              rawTask.value[HiveTask.titleFieldJsonKey] == newTitle &&
              rawTask.value[HiveTask.descriptionFieldJsonKey] ==
                  newDescription &&
              rawTask.value[HiveTask.statusFieldJsonKey] == newStatus;
          final existingMatchingTasksCount =
              box.toMap().entries.where(filter).length;
          expect(existingMatchingTasksCount, isZero);
          expect(
            () async => storage.update(
              taskId: task.id,
              partialTask: PartialTask(
                title: () => newTitle,
                description: () => newDescription,
                isCompleted: () => newStatus,
              ),
            ),
            throwsA(isA<UpdateTaskFailureEmptyTitle>()),
          );
          final resultingMatchingTasksCount =
              box.toMap().entries.where(filter).length;
          expect(resultingMatchingTasksCount, isZero);
        },
      );

      test(
        '''

│  ├─ THAT has task records
AND the ID of a registered task
WHEN the task is requested
THEN the task is returned
''',
        () async {
          const taskId = 991;
          final task = Task(
            id: taskId,
            title: 'title',
            description: 'description',
            isCompleted: false,
            createdAt: DateTime.now(),
          );
          await box.put(task.id, task.toHiveJson());
          bool filter(dynamic key) => key == task.id;
          final initialMatchingTasksCount = box.keys.where(filter).length;
          expect(initialMatchingTasksCount, 1);
          final retrievedTask = await storage.getById(taskId);
          expect(retrievedTask, isNotNull);
          expect(retrievedTask, task);
        },
      );

      test(
        '''

│  ├─ THAT has task records
AND the ID of an unregistered task
WHEN the task is requested
THEN null is returned
''',
        () async {
          const taskId = 325;
          bool filter(dynamic key) => key == taskId;
          final initialMatchingTasksCount = box.keys.where(filter).length;
          expect(initialMatchingTasksCount, isZero);
          final retrievedTask = await storage.getById(taskId);
          expect(retrievedTask, isNull);
        },
      );

      test(
        '''

│  ├─ THAT has task records
AND pagination parameters
WHEN a tasks page is watched
├─ THAT are not filtered by their status
├─ AND are not filtered by their content
THEN the paginated tasks that match the conditions are continuously emitted as they change
''',
        () async {
          final stream = storage.watchPaginated(
            offset: 2,
            limit: 2,
            statusFilter: TasksStatusFilter.all,
          );

          // Stage 00
          final tasksForStage00 = <Task>[
            Task(
              id: 0,
              title: 'title 00',
              description: 'description 00',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 0),
            ),
            Task(
              id: 1,
              title: 'title 01',
              isCompleted: false,
              // ignore: avoid_redundant_argument_values
              createdAt: DateTime(2020, 1, 1),
            ),
            Task(
              id: 2,
              title: 'title 02',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 2),
            ),
          ];
          final sortedTasksForStage00 = [...tasksForStage00]
            ..sort((tA, tB) => tB.createdAt.compareTo(tA.createdAt));
          final expectedTasksForStage00 =
              sortedTasksForStage00.skip(2).take(2).toList();

          // Stage 01
          final newTaskInStage01 = Task(
            id: 3,
            title: 'title 03',
            isCompleted: true,
            createdAt: DateTime(2020, 1, 3),
          );
          final tasksForStage01 = <Task>[
            ...tasksForStage00,
            newTaskInStage01,
          ];
          final sortedTasksForStage01 = [...tasksForStage01]
            ..sort((tA, tB) => tB.createdAt.compareTo(tA.createdAt));
          final expectedTasksForStage01 =
              sortedTasksForStage01.skip(2).take(2).toList();

          // Stage 02
          final tasksForStage02 = <Task>[
            for (final task in tasksForStage01)
              if (!task.isCompleted) task,
          ];
          final sortedTasksForStage02 = [...tasksForStage02]
            ..sort((tA, tB) => tB.createdAt.compareTo(tA.createdAt));
          final expectedTasksForStage02 =
              sortedTasksForStage02.skip(2).take(2).toList();

          // Stage 03
          // final tasksForStage03 = <Task>[
          //   for (final task in tasksForStage02)
          //     if (task.description == null)
          //       task.copyWith(description: 'updated description')
          //     else
          //       task,
          // ];
          // final sortedTasksForStage03 = [...tasksForStage03]
          //   ..sort((tA, tB) => tB.createdAt.compareTo(tA.createdAt));
          // final expectedTasksForStage03 =
          //     sortedTasksForStage03.skip(2).take(2).toList();

          unawaited(
            expectLater(
              stream,
              emitsInOrder(
                [
                  orderedEquals(expectedTasksForStage00),
                  orderedEquals(expectedTasksForStage01),
                  orderedEquals(expectedTasksForStage02),

                  // Not emitted since the tasks have not been updated
                  // orderedEquals(expectedTasksForStage03),
                ],
              ),
            ),
          );

          // Stage 00
          await box.putAll({
            for (final task in tasksForStage00) task.id: task.toHiveJson(),
          });

          // Stage 01
          await box.put(newTaskInStage01.id, newTaskInStage01.toHiveJson());

          // Stage 02
          {
            final keysToDelete = box
                .toMap()
                .entries
                .where(
                  (entry) => entry.value[HiveTask.statusFieldJsonKey] == true,
                )
                .map(
                  (taskRecordEntry) => taskRecordEntry.key,
                );
            await box.deleteAll(keysToDelete);
          }

          // Stage 03
          {
            final updatedTaskRecordEntries = box
                .toMap()
                .entries
                .where(
                  (entry) =>
                      entry.value[HiveTask.descriptionFieldJsonKey] == null,
                )
                .map(
                  (entry) => entry
                    ..value[HiveTask.descriptionFieldJsonKey] =
                        'updated description',
                );
            await box.putAll(Map.fromEntries(updatedTaskRecordEntries));
          }
        },
      );

      test(
        '''

│  ├─ THAT has task records
AND pagination parameters
WHEN a tasks page is watched
├─ THAT are filtered by their status (completed)
├─ AND are filtered by their content
THEN the paginated tasks that match the conditions are continuously emitted as they change
''',
        () async {
          final stream = storage.watchPaginated(
            offset: 2,
            limit: 2,
            statusFilter: TasksStatusFilter.completed,
            searchTerm: 'matching-pattern',
          );

          bool matches(Task task) =>
              task.isCompleted &&
              (task.title.contains('matching-pattern') ||
                  (task.description?.contains('matching-pattern') ?? false));

          // Stage 00
          final tasksForStage00 = <Task>[
            Task(
              id: 0,
              title: 'title 00',
              description: 'description 00 matching-pattern',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 0),
            ),
            Task(
              id: 1,
              title: 'title 01',
              isCompleted: false,
              // ignore: avoid_redundant_argument_values
              createdAt: DateTime(2020, 1, 1),
            ),
            Task(
              id: 2,
              title: 'title 02',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 2),
            ),
            Task(
              id: 3,
              title: 'title 03',
              description: 'description 03 matching-pattern',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 3),
            ),
            Task(
              id: 4,
              title: 'title 04',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 4),
            ),
            Task(
              id: 5,
              title: 'title 05',
              description: 'description 05 matching-pattern',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 5),
            ),
          ];
          final sortedTasksForStage00 = [...tasksForStage00]
            ..sort((tA, tB) => tB.createdAt.compareTo(tA.createdAt));
          final expectedTasksForStage00 =
              sortedTasksForStage00.where(matches).skip(2).take(2).toList();

          // Stage 01
          final newTaskInStage01 = Task(
            id: 6,
            title: 'title 06 matching-pattern',
            isCompleted: true,
            createdAt: DateTime(2020, 1, 6),
          );
          final tasksForStage01 = <Task>[
            ...tasksForStage00,
            newTaskInStage01,
          ];
          final sortedTasksForStage01 = [...tasksForStage01]
            ..sort((tA, tB) => tB.createdAt.compareTo(tA.createdAt));
          final expectedTasksForStage01 =
              sortedTasksForStage01.where(matches).skip(2).take(2).toList();

          // Stage 02
          final tasksForStage02 = <Task>[
            for (final task in tasksForStage01)
              if (!task.title.contains('00')) task,
          ];
          final sortedTasksForStage02 = [...tasksForStage02]
            ..sort((tA, tB) => tB.createdAt.compareTo(tA.createdAt));
          final expectedTasksForStage02 =
              sortedTasksForStage02.where(matches).skip(2).take(2).toList();

          // Stage 03
          // final tasksForStage03 = <Task>[
          //   for (final task in tasksForStage02)
          //     if (task.description == null)
          //       task.copyWith(description: 'updated description')
          //     else
          //       task,
          // ];
          // final sortedTasksForStage03 = [...tasksForStage03]
          //   ..sort((tA, tB) => tB.createdAt.compareTo(tA.createdAt));
          // final expectedTasksForStage03 = sortedTasksForStage03
          //     .where(matches)
          //     .skip(2)
          //     .take(2)
          //     .toList();

          unawaited(
            expectLater(
              stream,
              emitsInOrder(
                [
                  orderedEquals(expectedTasksForStage00),
                  orderedEquals(expectedTasksForStage01),
                  orderedEquals(expectedTasksForStage02),

                  // Not emitted since the tasks have not been updated
                  // orderedEquals(expectedTasksForStage03),
                ],
              ),
            ),
          );

          // Stage 00
          await box.putAll({
            for (final task in tasksForStage00) task.id: task.toHiveJson(),
          });

          // Stage 01
          await box.put(newTaskInStage01.id, newTaskInStage01.toHiveJson());

          // Stage 02
          {
            final keysToDelete = box.toMap().entries.where(
              (entry) {
                final rawTitle = entry.value[HiveTask.titleFieldJsonKey];
                if (rawTitle is! String) return false;
                return rawTitle.contains('00');
              },
            ).map(
              (taskRecordEntry) => taskRecordEntry.key,
            );
            await box.deleteAll(keysToDelete);
          }

          // Stage 03
          {
            final updatedTaskRecordEntries = box
                .toMap()
                .entries
                .where(
                  (entry) =>
                      entry.value[HiveTask.descriptionFieldJsonKey] == null,
                )
                .map(
                  (entry) => entry
                    ..value[HiveTask.descriptionFieldJsonKey] =
                        'updated description',
                );
            await box.putAll(Map.fromEntries(updatedTaskRecordEntries));
          }
        },
      );

      test(
        '''

│  ├─ THAT has task records
AND pagination parameters
WHEN a tasks page is watched
├─ THAT are filtered by their status (uncompleted)
├─ AND are not filtered by their content
THEN the paginated tasks that match the conditions are continuously emitted as they change
''',
        () async {
          final stream = storage.watchPaginated(
            offset: 2,
            limit: 2,
            statusFilter: TasksStatusFilter.uncompleted,
          );

          bool matches(Task task) => !task.isCompleted;

          // Stage 00
          final tasksForStage00 = <Task>[
            Task(
              id: 0,
              title: 'title 00',
              description: 'description 00',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 0),
            ),
            Task(
              id: 1,
              title: 'title 01',
              isCompleted: false,
              // ignore: avoid_redundant_argument_values
              createdAt: DateTime(2020, 1, 1),
            ),
            Task(
              id: 2,
              title: 'title 02',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 2),
            ),
            Task(
              id: 3,
              title: 'title 03',
              description: 'description 03',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 3),
            ),
            Task(
              id: 4,
              title: 'title 04',
              description: 'description 04',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 4),
            ),
            Task(
              id: 5,
              title: 'title 05',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 5),
            ),
          ];
          final sortedTasksForStage00 = [...tasksForStage00]
            ..sort((tA, tB) => tB.createdAt.compareTo(tA.createdAt));
          final expectedTasksForStage00 =
              sortedTasksForStage00.where(matches).skip(2).take(2).toList();

          // Stage 01
          final newTaskInStage01 = Task(
            id: 6,
            title: 'title 06',
            isCompleted: true,
            createdAt: DateTime(2020, 1, 6),
          );
          final tasksForStage01 = <Task>[
            ...tasksForStage00,
            newTaskInStage01,
          ];
          // final sortedTasksForStage01 = [...tasksForStage01]
          //   ..sort((tA, tB) => tB.createdAt.compareTo(tA.createdAt));
          // final expectedTasksForStage01 = sortedTasksForStage01
          //     .where(matches)
          //     .skip(2)
          //     .take(2)
          //     .toList();

          // Stage 02
          final tasksForStage02 = <Task>[
            for (final task in tasksForStage01)
              if (task.title != '0') task,
          ];
          // final sortedTasksForStage02 = [...tasksForStage02]
          //   ..sort((tA, tB) => tB.createdAt.compareTo(tA.createdAt));
          // final expectedTasksForStage02 = sortedTasksForStage02
          //     .where(matches)
          //     .skip(2)
          //     .take(2)
          //     .toList();

          // Stage 03
          final tasksForStage03 = <Task>[
            for (final task in tasksForStage02)
              if (task.description == null)
                task.copyWith(description: 'updated description')
              else
                task,
          ];
          final sortedTasksForStage03 = [...tasksForStage03]
            ..sort((tA, tB) => tB.createdAt.compareTo(tA.createdAt));
          final expectedTasksForStage03 =
              sortedTasksForStage03.where(matches).skip(2).take(2).toList();

          unawaited(
            expectLater(
              stream,
              emitsInOrder(
                [
                  orderedEquals(expectedTasksForStage00),

                  // Not emitted since the tasks have not been updated
                  // orderedEquals(expectedTasksForStage01),

                  // Not emitted since the tasks have not been updated
                  // orderedEquals(expectedTasksForStage02),

                  orderedEquals(expectedTasksForStage03),
                ],
              ),
            ),
          );

          // Stage 00
          await box.putAll({
            for (final task in tasksForStage00) task.id: task.toHiveJson(),
          });

          // Stage 01
          await box.put(newTaskInStage01.id, newTaskInStage01.toHiveJson());

          // Stage 02
          {
            final keysToDelete = box
                .toMap()
                .entries
                .where(
                  (entry) => entry.value[HiveTask.titleFieldJsonKey] == '0',
                )
                .map(
                  (taskRecordEntry) => taskRecordEntry.key,
                );
            await box.deleteAll(keysToDelete);
          }

          // Stage 03
          {
            final updatedTaskRecordEntries = box
                .toMap()
                .entries
                .where(
                  (entry) =>
                      entry.value[HiveTask.descriptionFieldJsonKey] == null,
                )
                .map(
                  (entry) => entry
                    ..value[HiveTask.descriptionFieldJsonKey] =
                        'updated description',
                );
            await box.putAll(Map.fromEntries(updatedTaskRecordEntries));
          }
        },
      );

      test(
        '''

│  ├─ THAT has task records
WHEN the tasks count is watched
├─ THAT are not filtered by their status
├─ AND are not filtered by their content
THEN the quantity of persisted tasks that match the conditions is continuously emitted as it changes
''',
        () async {
          final stream = storage.watchCount(
            statusFilter: TasksStatusFilter.all,
          );

          unawaited(
            expectLater(
              stream,
              emitsInOrder(
                [
                  2,
                  3,
                  1,

                  // Not emitted since the tasks count has not changed
                  // 1,
                ],
              ),
            ),
          );

          // Stage 00
          {
            final initialTasks = [
              Task(
                id: 0,
                title: 'title 00',
                description: 'description 00',
                isCompleted: true,
                createdAt: DateTime(2020, 1, 0),
              ),
              Task(
                id: 1,
                title: 'title 01',
                isCompleted: false,
                // ignore: avoid_redundant_argument_values
                createdAt: DateTime(2020, 1, 1),
              ),
            ];
            await box.putAll({
              for (final task in initialTasks) task.id: task.toHiveJson(),
            });
          }

          // Stage 01
          {
            final newTask = Task(
              id: 3,
              title: 'title 03',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 3),
            );
            await box.put(newTask.id, newTask.toHiveJson());
          }

          // Stage 02
          {
            final keysToDelete = box
                .toMap()
                .entries
                .where(
                  (entry) => entry.value[HiveTask.statusFieldJsonKey] as bool,
                )
                .map(
                  (taskRecordEntry) => taskRecordEntry.key,
                );
            await box.deleteAll(keysToDelete);
          }

          // Stage 03
          {
            final updatedTaskRecordEntries = box
                .toMap()
                .entries
                .where(
                  (entry) =>
                      entry.value[HiveTask.descriptionFieldJsonKey] == null,
                )
                .map(
                  (entry) => entry
                    ..value[HiveTask.descriptionFieldJsonKey] =
                        'updated description',
                );
            await box.putAll(Map.fromEntries(updatedTaskRecordEntries));
          }
        },
      );

      test(
        '''

│  ├─ THAT has task records
WHEN the tasks count is watched
├─ THAT are filtered by their status (completed)
├─ AND are filtered by their content
THEN the quantity of persisted tasks that match the conditions is continuously emitted as it changes
''',
        () async {
          final stream = storage.watchCount(
            statusFilter: TasksStatusFilter.completed,
            searchTerm: 'matching-pattern',
          );

          unawaited(
            expectLater(
              stream,
              emitsInOrder(
                [
                  1,
                  2,
                  0,
                ],
              ),
            ),
          );

          // Stage 00
          {
            final initialTasks = [
              Task(
                id: 0,
                title: 'title 00',
                description: 'description 00 matching-pattern',
                isCompleted: true,
                createdAt: DateTime(2020, 1, 0),
              ),
              Task(
                id: 1,
                title: 'title 01',
                isCompleted: false,
                // ignore: avoid_redundant_argument_values
                createdAt: DateTime(2020, 1, 1),
              ),
            ];
            await box.putAll({
              for (final task in initialTasks) task.id: task.toHiveJson(),
            });
          }

          // Stage 01
          {
            final newTask = Task(
              id: 3,
              title: 'title 03 matching-pattern',
              isCompleted: true,
              createdAt: DateTime(2020, 1, 3),
            );
            await box.put(newTask.id, newTask.toHiveJson());
          }

          // Stage 02
          {
            final keysToDelete = box
                .toMap()
                .entries
                .where(
                  (entry) => entry.value[HiveTask.statusFieldJsonKey] as bool,
                )
                .map(
                  (taskRecordEntry) => taskRecordEntry.key,
                );
            await box.deleteAll(keysToDelete);
          }

          // Stage 03
          {
            final updatedTaskRecordEntries = box
                .toMap()
                .entries
                .where(
                  (entry) =>
                      entry.value[HiveTask.descriptionFieldJsonKey] == null,
                )
                .map(
                  (entry) => entry
                    ..value[HiveTask.descriptionFieldJsonKey] =
                        'updated description',
                );
            await box.putAll(Map.fromEntries(updatedTaskRecordEntries));
          }
        },
      );
    },
  );
}
