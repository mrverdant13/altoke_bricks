import 'dart:async';

import 'package:common/common.dart';
import 'package:collection/collection.dart';
import 'package:{{#requirements_met}}local_database{{/requirements_met}}/{{#requirements_met}}local_database{{/requirements_met}}.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:{{#use_sembast}}sembast_local_database{{/use_sembast}}/{{#use_sembast}}sembast_local_database{{/use_sembast}}.dart';
import 'package:{{#use_sembast}}sembast_local_database{{/use_sembast}}/src/helpers.dart' as sembast;
import 'package:test/test.dart';

void main() {
  test(
    '''

GIVEN a constructor for a $LocalTasksSembastDao
WHEN the constructor is called
THEN an instance of $LocalTasksSembastDao is returned
''',
    () async {
      final database = await newDatabaseFactoryMemory().openDatabase('');
      final dao = LocalTasksSembastDao(database: database);
      expect(dao, isA<LocalTasksSembastDao>());
      expect(dao, isA<LocalTasksDao>());
      expect(dao.tasksStore, isNotNull);
      await database.close();
    },
  );

  group(
    '''

GIVEN a $LocalTasksSembastDao
├─ THAT uses an Sembast database''',
    () {
      late Database database;
      late LocalTasksSembastDao dao;
      late sembast.TasksStoreRef tasksStore;

      setUp(() async {
        database = await newDatabaseFactoryMemory().openDatabase('');
        dao = LocalTasksSembastDao(database: database);
        tasksStore = dao.tasksStore;
      });

      tearDown(() async {
        await database.close();
      });

      test(
        '''

AND the valid data for a new task
WHEN the task is created
THEN a task record is registered
''',
        () async {
          const newTask = NewTask(title: 'title', priority: TaskPriority.low);
          final filter = Filter.and([
            Filter.equals(sembast.Task.titleJsonKey, newTask.title),
            Filter.equals(
              sembast.Task.priorityJsonKey,
              newTask.priority.identifier,
            ),
            Filter.isNull(sembast.Task.descriptionJsonKey),
          ]);
          final existingMatchingTasksCount = await tasksStore.count(
            database,
            filter: filter,
          );
          expect(existingMatchingTasksCount, isZero);
          await dao.createOne(newTask);
          final resultingMatchingTasksCount = await tasksStore.count(
            database,
            filter: filter,
          );
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
          const newTask = NewTask(title: '', priority: TaskPriority.high);
          final existingMatchingTasksCount = await tasksStore.count(database);
          expect(existingMatchingTasksCount, isZero);
          expect(
            () async => dao.createOne(newTask),
            throwsA(isA<CreateTaskFailureInvalidData>()),
          );
          final resultingMatchingTasksCount = await tasksStore.count(database);
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
          final sortedTasksForStage00 = [
            ...tasksForStage00,
          ].sorted((tA, tB) => tA.title.compareTo(tB.title));

          // Stage 01
          const newTaskInStage01 = Task(
            id: 3,
            title: 'title 03',
            priority: TaskPriority.low,
            completed: true,
          );
          final tasksForStage01 = <Task>[...tasksForStage00, newTaskInStage01];
          final sortedTasksForStage01 = [
            ...tasksForStage01,
          ].sorted((tA, tB) => tA.title.compareTo(tB.title));

          // Stage 02
          final tasksForStage02 = <Task>[
            for (final task in tasksForStage01)
              if (!task.title.contains('01')) task,
          ];
          final sortedTasksForStage02 = [
            ...tasksForStage02,
          ].sorted((tA, tB) => tA.title.compareTo(tB.title));

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
          final sortedTasksForStage03 = [
            ...tasksForStage03,
          ].sorted((tA, tB) => tA.title.compareTo(tB.title));

          unawaited(
            expectLater(
              stream,
              emitsInOrder([
                List<Task>.empty(), // initially empty
                orderedEquals(sortedTasksForStage00),
                orderedEquals(sortedTasksForStage01),
                orderedEquals(sortedTasksForStage02),
                orderedEquals(sortedTasksForStage03),
              ]),
            ),
          );

          // Stage 00
          {
            final tasksMap = {
              for (final task in tasksForStage00)
                task.id: {
                  sembast.Task.titleJsonKey: task.title,
                  sembast.Task.priorityJsonKey: task.priority.identifier,
                  sembast.Task.completedJsonKey: task.completed,
                  sembast.Task.descriptionJsonKey: task.description,
                },
            };
            await tasksStore
                .records(tasksMap.keys)
                .put(database, tasksMap.values.toList());
          }

          // Stage 01
          await tasksStore.record(newTaskInStage01.id).put(database, {
            sembast.Task.titleJsonKey: newTaskInStage01.title,
            sembast.Task.priorityJsonKey: newTaskInStage01.priority.identifier,
            sembast.Task.completedJsonKey: newTaskInStage01.completed,
            sembast.Task.descriptionJsonKey: newTaskInStage01.description,
          });

          // Stage 02

          await tasksStore.delete(
            database,
            finder: Finder(
              filter: Filter.matches(sembast.Task.titleJsonKey, '01'),
            ),
          );

          // Stage 03
          await tasksStore.update(
            database,
            {sembast.Task.descriptionJsonKey: 'updated description'},
            finder: Finder(
              filter: Filter.isNull(sembast.Task.descriptionJsonKey),
            ),
          );
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
            sembast.Task.titleJsonKey: 'title',
            sembast.Task.priorityJsonKey: TaskPriority.high.identifier,
            sembast.Task.completedJsonKey: false,
            sembast.Task.descriptionJsonKey: 'description',
          };
          await tasksStore.record(taskId).put(database, task);
          final existingTasksCount = await tasksStore.count(database);
          expect(existingTasksCount, 1);
          const newTitle = 'new title';
          const newPriority = TaskPriority.low;
          const newCompleted = true;
          const newDescription = 'new description';
          final filter = Filter.and([
            Filter.byKey(taskId),
            Filter.equals(sembast.Task.titleJsonKey, newTitle),
            Filter.equals(sembast.Task.priorityJsonKey, newPriority.identifier),
            Filter.equals(sembast.Task.completedJsonKey, newCompleted),
            Filter.equals(sembast.Task.descriptionJsonKey, newDescription),
          ]);
          final existingMatchingTasksCount = await tasksStore.count(
            database,
            filter: filter,
          );
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
          final resultingMatchingTasksCount = await tasksStore.count(
            database,
            filter: filter,
          );
          expect(resultingMatchingTasksCount, existingMatchingTasksCount + 1);
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
          final existingTasksCount = await tasksStore.count(database);
          expect(existingTasksCount, isZero);
          const taskId = 31;
          const newTitle = 'new title';
          const newPriority = TaskPriority.low;
          const newCompleted = true;
          const newDescription = 'new description';

          final filter = Filter.and([
            Filter.byKey(taskId),
            Filter.equals(sembast.Task.titleJsonKey, newTitle),
            Filter.equals(sembast.Task.priorityJsonKey, newPriority.identifier),
            Filter.equals(sembast.Task.completedJsonKey, newCompleted),
            Filter.equals(sembast.Task.descriptionJsonKey, newDescription),
          ]);
          final existingMatchingTasksCount = await tasksStore.count(
            database,
            filter: filter,
          );
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
          final resultingMatchingTasksCount = await tasksStore.count(
            database,
            filter: filter,
          );
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
            sembast.Task.titleJsonKey: 'title',
            sembast.Task.priorityJsonKey: TaskPriority.low.identifier,
            sembast.Task.completedJsonKey: true,
            sembast.Task.descriptionJsonKey: 'description',
          };
          await tasksStore.record(taskId).put(database, task);
          final existingTasksCount = await tasksStore.count(database);
          expect(existingTasksCount, 1);
          const newTitle = '';
          const newPriority = TaskPriority.high;
          const newCompleted = false;
          const newDescription = '';
          final filter = Filter.and([
            Filter.byKey(taskId),
            Filter.equals(sembast.Task.titleJsonKey, newTitle),
            Filter.equals(sembast.Task.priorityJsonKey, newPriority.identifier),
            Filter.equals(sembast.Task.completedJsonKey, newCompleted),
            Filter.equals(sembast.Task.descriptionJsonKey, newDescription),
          ]);
          final existingMatchingTasksCount = await tasksStore.count(
            database,
            filter: filter,
          );
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
          final resultingMatchingTasksCount = await tasksStore.count(
            database,
            filter: filter,
          );
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
            sembast.Task.titleJsonKey: 'title',
            sembast.Task.priorityJsonKey: TaskPriority.low.identifier,
            sembast.Task.completedJsonKey: true,
            sembast.Task.descriptionJsonKey: 'description',
          };
          await tasksStore.record(taskId).put(database, task);
          final filter = Filter.byKey(taskId);
          final initialMatchingTasksCount = await tasksStore.count(
            database,
            filter: filter,
          );
          expect(initialMatchingTasksCount, 1);
          await dao.deleteOneById(taskId);
          final resultingMatchingTasksCount = await tasksStore.count(
            database,
            filter: filter,
          );
          expect(resultingMatchingTasksCount, isZero);
        },
      );
    },
  );
}
