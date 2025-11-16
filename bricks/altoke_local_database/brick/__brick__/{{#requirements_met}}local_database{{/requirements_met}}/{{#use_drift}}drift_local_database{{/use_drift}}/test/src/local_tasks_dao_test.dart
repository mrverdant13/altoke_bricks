import 'dart:async';

import 'package:common/common.dart';
import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:{{#use_drift}}drift_local_database{{/use_drift}}/{{#use_drift}}drift_local_database{{/use_drift}}.dart';
import 'package:{{#use_drift}}drift_local_database{{/use_drift}}/src/tasks.drift.dart' as drift;
import 'package:{{#requirements_met}}local_database{{/requirements_met}}/{{#requirements_met}}local_database{{/requirements_met}}.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() {
    // cspell:disable-next-line
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  });

  test(
    '''

GIVEN a constructor for a $LocalTasksDriftDao
WHEN the constructor is called
THEN an instance of $LocalTasksDriftDao is returned
''',
    () {
      final database = LocalDatabase(
        queryExecutor: NativeDatabase.memory(),
        schemaVersion: 1,
      );
      final dao = LocalTasksDriftDao(tasksDrift: database.tasksDrift);
      expect(dao, isA<LocalTasksDriftDao>());
      expect(dao, isA<LocalTasksDao>());
    },
  );

  group(
    '''

GIVEN a $LocalTasksDriftDao
├─ THAT uses a Drift (SQLite) database''',
    () {
      late LocalDatabase database;
      late drift.Tasks tasksTable;
      late LocalTasksDriftDao dao;

      setUp(() {
        database = LocalDatabase(
          queryExecutor: NativeDatabase.memory(),
          schemaVersion: 1,
        );
        tasksTable = database.tasks;
        dao = LocalTasksDriftDao(tasksDrift: database.tasksDrift);
      });

      tearDown(() {
        unawaited(database.close());
      });

      test(
        '''

AND the valid data for a new task
WHEN the task is created
THEN a task record is registered
''',
        () async {
          const newTask = NewTask(title: 'title', priority: TaskPriority.low);
          Expression<bool> filter(drift.Tasks table) =>
              table.title.equals(newTask.title) &
              table.priority.equalsValue(newTask.priority) &
              table.description.isNull();
          final existingMatchingTasksCount = await tasksTable
              .count(where: filter)
              .getSingle();
          expect(existingMatchingTasksCount, isZero);
          await dao.createOne(newTask);
          final resultingMatchingTasksCount = await tasksTable
              .count(where: filter)
              .getSingle();
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
          final existingMatchingTasksCount = await tasksTable
              .count()
              .getSingle();
          expect(existingMatchingTasksCount, isZero);
          expect(
            () async => dao.createOne(newTask),
            throwsA(isA<CreateTaskFailureInvalidData>()),
          );
          final resultingMatchingTasksCount = await tasksTable
              .count()
              .getSingle();
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
          await database.transaction(() async {});

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
          await database.transaction(
            () async => tasksTable.insertAll(
              tasksForStage00.map((task) => task.toDrift()),
            ),
          );

          // Stage 01
          await database.transaction(
            () async => tasksTable.insertOne(newTaskInStage01.toDrift()),
          );

          // Stage 02
          await database.transaction(
            () async =>
                tasksTable.deleteWhere((table) => table.title.contains('01')),
          );

          // Stage 03
          await database.transaction(
            () async =>
                (tasksTable.update()
                      ..where((table) => table.description.isNull()))
                    .write(
                      const drift.TasksCompanion(
                        description: Value('updated description'),
                      ),
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
          const task = Task(
            id: 31,
            title: 'title',
            priority: TaskPriority.high,
            completed: false,
            description: 'description',
          );
          await tasksTable.insertOne(task.toDrift());
          final existingTasksCount = await tasksTable.count().getSingle();
          expect(existingTasksCount, 1);
          const newTitle = 'new title';
          const newPriority = TaskPriority.low;
          const newCompleted = true;
          const newDescription = 'new description';

          Expression<bool> filter(drift.Tasks tasksTable) {
            return tasksTable.id.equals(task.id) &
                tasksTable.title.equals(newTitle) &
                tasksTable.priority.equalsValue(newPriority) &
                tasksTable.completed.equals(newCompleted) &
                tasksTable.description.equals(newDescription);
          }

          final existingMatchingTasksCount = await tasksTable
              .count(where: filter)
              .getSingle();
          expect(existingMatchingTasksCount, isZero);
          await dao.updateOneById(
            taskId: task.id,
            task: const PartialTask(
              title: Some(newTitle),
              priority: Some(newPriority),
              completed: Some(newCompleted),
              description: Some(newDescription),
            ),
          );
          final resultingMatchingTasksCount = await tasksTable
              .count(where: filter)
              .getSingle();
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
          final existingTasksCount = await tasksTable.count().getSingle();
          expect(existingTasksCount, isZero);
          const taskId = 31;
          const newTitle = 'new title';
          const newPriority = TaskPriority.low;
          const newCompleted = true;
          const newDescription = 'new description';

          Expression<bool> filter(drift.Tasks tasksTable) {
            return tasksTable.id.equals(taskId) &
                tasksTable.title.equals(newTitle) &
                tasksTable.priority.equalsValue(newPriority) &
                tasksTable.completed.equals(newCompleted) &
                tasksTable.description.equals(newDescription);
          }

          final existingMatchingTasksCount = await tasksTable
              .count(where: filter)
              .getSingle();
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
          final resultingMatchingTasksCount = await tasksTable
              .count(where: filter)
              .getSingle();
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
          const task = Task(
            id: 31,
            title: 'title',
            priority: TaskPriority.low,
            completed: true,
            description: 'description',
          );
          await tasksTable.insertOne(task.toDrift());
          final existingTasksCount = await tasksTable.count().getSingle();
          expect(existingTasksCount, 1);
          const newTitle = '';
          const newPriority = TaskPriority.high;
          const newCompleted = false;
          const newDescription = '';

          Expression<bool> filter(drift.Tasks tasksTable) {
            return tasksTable.id.equals(task.id) &
                tasksTable.title.equals(newTitle) &
                tasksTable.priority.equalsValue(newPriority) &
                tasksTable.completed.equals(newCompleted) &
                tasksTable.description.equals(newDescription);
          }

          final existingMatchingTasksCount = await tasksTable
              .count(where: filter)
              .getSingle();
          expect(existingMatchingTasksCount, isZero);
          expect(
            () async => dao.updateOneById(
              taskId: task.id,
              task: const PartialTask(
                title: Some(newTitle),
                priority: Some(newPriority),
                completed: Some(newCompleted),
                description: Some(newDescription),
              ),
            ),
            throwsA(isA<UpdateTaskFailureInvalidData>()),
          );
          final resultingMatchingTasksCount = await tasksTable
              .count(where: filter)
              .getSingle();
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
          const task = Task(
            id: taskId,
            title: 'title',
            priority: TaskPriority.low,
            completed: true,
            description: 'description',
          );
          await tasksTable.insertOne(task.toDrift());
          final initialMatchingTasksCount = await tasksTable
              .count(where: (table) => table.id.equals(taskId))
              .getSingle();
          expect(initialMatchingTasksCount, 1);
          await dao.deleteOneById(taskId);
          final resultingMatchingTasksCount = await tasksTable
              .count(where: (table) => table.id.equals(taskId))
              .getSingle();
          expect(resultingMatchingTasksCount, isZero);
        },
      );
    },
  );
}

extension on Task {
  Insertable<Task> toDrift() {
    return drift.TasksCompanion(
      id: Value(id),
      title: Value(title),
      priority: Value(priority),
      completed: Value(completed),
      description: Value(description),
    );
  }
}
