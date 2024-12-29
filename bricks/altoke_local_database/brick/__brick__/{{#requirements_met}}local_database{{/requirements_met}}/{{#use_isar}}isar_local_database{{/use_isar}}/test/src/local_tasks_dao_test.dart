import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:common/common.dart';
import 'package:collection/collection.dart';
import 'package:isar/isar.dart';
import 'package:{{#use_isar}}isar_local_database{{/use_isar}}/{{#use_isar}}isar_local_database{{/use_isar}}.dart';
import 'package:{{#use_isar}}isar_local_database{{/use_isar}}/src/task.dart' as isar;
import 'package:{{#requirements_met}}local_database{{/requirements_met}}/{{#requirements_met}}local_database{{/requirements_met}}.dart';
import 'package:test/test.dart';

Future<Isar> openIsar(Directory dbDir) async {
  final isar = Isar.getInstance() ??
      await Isar.open(
        localDatabaseSchemas,
        directory: dbDir.path,
        inspector: false,
        relaxedDurability: false,
      );
  return isar;
}

extension on Abi {
  String get localName {
    switch (this) {
      case Abi.macosArm64 || Abi.macosX64:
        // cspell: disable-next-line
        return 'libisar.dylib';
      case Abi.linuxX64:
        // cspell: disable-next-line
        return 'libisar.so';
      case Abi.windowsArm64 || Abi.windowsX64:
        return 'isar.dll';
      default:
        throw UnsupportedError(
          'Unsupported processor architecture "$this" for tests',
        );
    }
  }
}

void main() {
  setUpAll(
    () async {
      // This step is a workaround to avoid issues affecting test suits.
      // See: https://github.com/isar/isar/issues/1518
      final isarLibDir = Directory.systemTemp.createTempSync('isar-test-lib-');
      final abi = Abi.current();
      await Isar.initializeIsarCore(
        download: true,
        libraries: {
          abi: '${isarLibDir.path}${Platform.pathSeparator}${abi.localName}',
        },
      );
    },
  );

  test(
    '''

GIVEN a constructor for a $LocalTasksIsarDao
WHEN the constructor is called
THEN an instance of $LocalTasksIsarDao is returned
''',
    () async {
      final dbDir = Directory.systemTemp.createTempSync('isar-testing-');
      final database = await openIsar(dbDir);
      final dao = LocalTasksIsarDao(database: database);
      expect(dao, isA<LocalTasksIsarDao>());
      expect(dao, isA<LocalTasksDao>());
      await database.close(deleteFromDisk: true);
      await dbDir.delete(recursive: true);
    },
  );

  group(
    '''

GIVEN a $LocalTasksIsarDao
├─ THAT uses an Isar database''',
    () {
      late Directory dbDir;
      late Isar database;
      late IsarCollection<isar.Task> tasksCollection;
      late LocalTasksIsarDao dao;

      setUp(() async {
        dbDir = Directory.systemTemp.createTempSync('isar-testing-');
        database = await openIsar(dbDir);
        tasksCollection = database.tasks;
        dao = LocalTasksIsarDao(database: database);
      });

      tearDown(() async {
        await database.close(deleteFromDisk: true);
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
          final query = tasksCollection
              .filter()
              .titleEqualTo(newTask.title)
              .priorityEqualTo(newTask.priority.identifier)
              .descriptionIsNull();
          final existingMatchingTasksCount = await query.count();
          expect(existingMatchingTasksCount, isZero);
          await dao.createOne(newTask);
          final resultingMatchingTasksCount = await query.count();
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
          final existingMatchingTasksCount = await tasksCollection.count();
          expect(existingMatchingTasksCount, isZero);
          expect(
            () async => dao.createOne(newTask),
            throwsA(isA<CreateTaskFailureInvalidData>()),
          );
          final resultingMatchingTasksCount = await tasksCollection.count();
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
                  List<Task>.empty(), // initially empty
                  orderedEquals(sortedTasksForStage00),
                  orderedEquals(sortedTasksForStage01),
                  orderedEquals(sortedTasksForStage02),
                  orderedEquals(sortedTasksForStage03),
                ],
              ),
            ),
          );

          // Stage 00
          await database.writeTxn(
            () async => tasksCollection.putAll([
              for (final task in tasksForStage00)
                isar.Task()
                  ..id = task.id
                  ..title = task.title
                  ..priority = task.priority.identifier
                  ..completed = task.completed
                  ..description = task.description,
            ]),
          );

          // Stage 01
          await database.writeTxn(
            () async => tasksCollection.put(
              isar.Task()
                ..id = newTaskInStage01.id
                ..title = newTaskInStage01.title
                ..priority = newTaskInStage01.priority.identifier
                ..completed = newTaskInStage01.completed
                ..description = newTaskInStage01.description,
            ),
          );

          // Stage 02
          await database.writeTxn(
            () async =>
                tasksCollection.filter().titleContains('01').deleteAll(),
          );

          // Stage 03
          await database.writeTxn(
            () async {
              final tasksWithoutDescription =
                  await tasksCollection.filter().descriptionIsNull().findAll();
              await tasksCollection.putAll([
                for (final task in tasksWithoutDescription)
                  task..description = 'updated description',
              ]);
            },
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
          final task = isar.Task()
            ..id = 31
            ..title = 'title'
            ..priority = TaskPriority.high.identifier
            ..completed = false
            ..description = 'description';
          await database.writeTxn(
            () async => tasksCollection.put(task),
          );
          final existingTasksCount = await tasksCollection.count();
          expect(existingTasksCount, 1);
          const newTitle = 'new title';
          const newPriority = TaskPriority.low;
          const newCompleted = true;
          const newDescription = 'new description';

          final query = tasksCollection
              .filter()
              .idEqualTo(task.id)
              .titleEqualTo(newTitle)
              .priorityEqualTo(newPriority.identifier)
              .completedEqualTo(newCompleted)
              .descriptionEqualTo(newDescription);

          final existingMatchingTasksCount = await query.count();
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
          final resultingMatchingTasksCount = await query.count();
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
          final existingTasksCount = await tasksCollection.count();
          expect(existingTasksCount, isZero);
          const taskId = 31;
          const newTitle = 'new title';
          const newPriority = TaskPriority.low;
          const newCompleted = true;
          const newDescription = 'new description';

          final query = tasksCollection
              .filter()
              .idEqualTo(taskId)
              .titleEqualTo(newTitle)
              .priorityEqualTo(newPriority.identifier)
              .completedEqualTo(newCompleted)
              .descriptionEqualTo(newDescription);

          final existingMatchingTasksCount = await query.count();
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
          final resultingMatchingTasksCount = await query.count();
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
          final task = isar.Task()
            ..id = 31
            ..title = 'title'
            ..priority = TaskPriority.low.identifier
            ..completed = true
            ..description = 'description';
          await database.writeTxn(
            () async => tasksCollection.put(task),
          );
          final existingTasksCount = await tasksCollection.count();
          expect(existingTasksCount, 1);
          const newTitle = '';
          const newPriority = TaskPriority.high;
          const newCompleted = false;
          const newDescription = '';

          final query = tasksCollection
              .filter()
              .idEqualTo(task.id)
              .titleEqualTo(newTitle)
              .priorityEqualTo(newPriority.identifier)
              .completedEqualTo(newCompleted)
              .descriptionEqualTo(newDescription);

          final existingMatchingTasksCount = await query.count();
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
          final resultingMatchingTasksCount = await query.count();
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
          final task = isar.Task()
            ..id = taskId
            ..title = 'title'
            ..priority = TaskPriority.low.identifier
            ..completed = true
            ..description = 'description';
          await database.writeTxn(
            () async => tasksCollection.put(task),
          );
          final query = tasksCollection.filter().idEqualTo(taskId);
          final initialMatchingTasksCount = await query.count();
          expect(initialMatchingTasksCount, 1);
          await dao.deleteOneById(taskId);
          final resultingMatchingTasksCount = await query.count();
          expect(resultingMatchingTasksCount, isZero);
        },
      );
    },
  );
}
