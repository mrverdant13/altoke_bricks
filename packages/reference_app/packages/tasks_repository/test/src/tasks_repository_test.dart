import 'package:element_in_memory_cache/element_in_memory_cache.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tasks/tasks.dart';
import 'package:tasks_repository/tasks_repository.dart';
import 'package:tasks_storage/tasks_storage.dart';
import 'package:test/test.dart';

class MockLatestDeletedTaskInMemoryCache extends Mock
    implements ElementInMemoryCache<Task> {}

class MockTasksStorage extends Mock implements TasksStorage {}

void main() {
  setUpAll(
    () async {
      registerFallbackValue(
        const NewTask(
          title: '',
        ),
      );
      registerFallbackValue(
        Task(
          id: 5,
          title: 'title',
          isCompleted: false,
          createdAt: DateTime.now(),
        ),
      );
      registerFallbackValue(
        const PartialTask(),
      );
      registerFallbackValue(
        TasksStatusFilter.all,
      );
    },
  );

  test(
    '''

GIVEN a constructor for a tasks repo
├─ THAT uses a cache for the latest deleted task
├─ AND uses a storage for tasks
WHEN the constructor is called
THEN an instance of the repo is returned
''',
    () async {
      final repo = TasksRepository(
        latestDeletedTaskCache: MockLatestDeletedTaskInMemoryCache(),
        tasksStorage: MockTasksStorage(),
      );
      expect(repo, isNotNull);
      expect(repo, isA<TasksRepository>());
    },
  );

  group(
    '''

GIVEN a tasks repo
├─ THAT uses a cache for the latest deleted task
├─ AND uses a storage for tasks''',
    () {
      late TasksRepository repo;
      late ElementInMemoryCache<Task> latestDeletedTaskCache;
      late TasksStorage tasksStorage;

      setUp(
        () async {
          latestDeletedTaskCache = MockLatestDeletedTaskInMemoryCache();
          tasksStorage = MockTasksStorage();
          repo = TasksRepository(
            latestDeletedTaskCache: latestDeletedTaskCache,
            tasksStorage: tasksStorage,
          );
        },
      );

      tearDown(
        () async {
          verifyNoMoreInteractions(latestDeletedTaskCache);
          verifyNoMoreInteractions(tasksStorage);
          reset(latestDeletedTaskCache);
          reset(tasksStorage);
        },
      );

      test(
        '''

AND the valid data for a new task
WHEN the task is created
THEN the creation is delegated to the tasks storage
''',
        () async {
          when(
            () => tasksStorage.create(
              newTask: any(named: 'newTask'),
            ),
          ).thenAnswer(
            (_) async {},
          );
          const newTask = NewTask(title: 'title');
          await repo.createTask(newTask: newTask);
          verify(
            () => tasksStorage.create(newTask: newTask),
          ).called(1);
        },
      );

      test(
        '''

AND no latest deleted task
WHEN the latest deleted task is restored
THEN no action is taken
├─ BY checking the latest cached deleted task
''',
        () async {
          when(
            () => latestDeletedTaskCache.get(),
          ).thenAnswer(
            (_) async => null,
          );
          await repo.restoreLatestDeletedTask();
          verify(
            () => latestDeletedTaskCache.get(),
          ).called(1);
        },
      );

      test(
        '''

AND a latest deleted task
WHEN the latest deleted task is restored
THEN the task is restored
├─ BY checking the latest cached deleted task
├─ AND inserting the task into the tasks storage
├─ AND clearing the latest cached deleted task
''',
        () async {
          final latestDeletedTask = Task(
            id: 8,
            title: 'title',
            isCompleted: true,
            createdAt: DateTime.now(),
          );
          when(
            () => latestDeletedTaskCache.get(),
          ).thenAnswer(
            (_) async => latestDeletedTask,
          );
          when(
            () => tasksStorage.insert(
              task: any(named: 'task'),
            ),
          ).thenAnswer(
            (_) async {},
          );
          when(
            () => latestDeletedTaskCache.set(null),
          ).thenAnswer(
            (_) async {},
          );
          await repo.restoreLatestDeletedTask();
          verify(
            () => latestDeletedTaskCache.get(),
          ).called(1);
          verify(
            () => tasksStorage.insert(task: latestDeletedTask),
          ).called(1);
          verify(
            () => latestDeletedTaskCache.set(null),
          ).called(1);
        },
      );

      test(
        '''

AND a task ID
WHEN the task is retrieved
THEN the retrieval is delegated to the tasks storage
''',
        () async {
          const taskId = 8;
          final task = Task(
            id: taskId,
            title: 'title',
            isCompleted: true,
            createdAt: DateTime.now(),
          );
          when(
            () => tasksStorage.getById(
              any(),
            ),
          ).thenAnswer(
            (_) async => task,
          );
          final result = await repo.getTaskById(taskId);
          expect(result, task);
          verify(
            () => tasksStorage.getById(taskId),
          ).called(1);
        },
      );

      test(
        '''

AND pagination parameters
AND a status filter
AND a search term
WHEN a tasks page is watched
THEN the watch is delegated to the tasks storage
''',
        () async {
          const offset = 10;
          const limit = 10;
          const statusFilter = TasksStatusFilter.all;
          const searchTerm = 'searchTerm';
          const stream = Stream<List<Task>>.empty();
          when(
            () => tasksStorage.watchPaginated(
              offset: any(named: 'offset'),
              limit: any(named: 'limit'),
              statusFilter: any(named: 'statusFilter'),
              searchTerm: any(named: 'searchTerm'),
            ),
          ).thenAnswer(
            (_) => stream,
          );
          final resultingStream = repo.watchPaginatedTasks(
            offset: offset,
            limit: limit,
            statusFilter: statusFilter,
            searchTerm: searchTerm,
          );
          expect(resultingStream, stream);
          verify(
            () => tasksStorage.watchPaginated(
              offset: offset,
              limit: limit,
              statusFilter: statusFilter,
              searchTerm: searchTerm,
            ),
          ).called(1);
        },
      );

      test(
        '''

AND a status filter
AND a search term
WHEN the tasks count is watched
THEN the watch is delegated to the tasks storage
''',
        () async {
          const statusFilter = TasksStatusFilter.all;
          const searchTerm = 'searchTerm';
          const stream = Stream<int>.empty();
          when(
            () => tasksStorage.watchCount(
              statusFilter: any(named: 'statusFilter'),
              searchTerm: any(named: 'searchTerm'),
            ),
          ).thenAnswer(
            (_) => stream,
          );
          final resultingStream = repo.watchCount(
            statusFilter: statusFilter,
            searchTerm: searchTerm,
          );
          expect(resultingStream, stream);
          verify(
            () => tasksStorage.watchCount(
              statusFilter: statusFilter,
              searchTerm: searchTerm,
            ),
          ).called(1);
        },
      );

      test(
        '''

WHEN the latest deleted task is watched
THEN the watch is delegated to the latest deleted task cache
''',
        () async {
          const stream = Stream<Task?>.empty();
          when(
            () => latestDeletedTaskCache.watch(),
          ).thenAnswer(
            (_) => stream,
          );
          final resultingStream = repo.watchLatestDeletedTask();
          expect(resultingStream, stream);
          verify(
            () => latestDeletedTaskCache.watch(),
          ).called(1);
        },
      );

      test(
        '''

AND a task ID
AND a partial task
WHEN the task is updated
THEN the update is delegated to the tasks storage
''',
        () async {
          const taskId = 22;
          const partialTask = PartialTask();
          when(
            () => tasksStorage.update(
              taskId: any(named: 'taskId'),
              partialTask: any(named: 'partialTask'),
            ),
          ).thenAnswer(
            (_) async {},
          );
          await repo.updateTask(
            taskId: taskId,
            partialTask: partialTask,
          );
          verify(
            () => tasksStorage.update(
              taskId: taskId,
              partialTask: partialTask,
            ),
          ).called(1);
        },
      );

      test(
        '''

WHEN all tasks are marked as completed
THEN the update is delegated to the tasks storage
''',
        () async {
          when(
            () => tasksStorage.markAllAsCompleted(),
          ).thenAnswer(
            (_) async {},
          );
          await repo.markAllTasksAsCompleted();
          verify(
            () => tasksStorage.markAllAsCompleted(),
          ).called(1);
        },
      );

      test(
        '''

AND the ID of an existing task
WHEN the task is deleted
THEN the task is deleted
├─ BY using the tasks storage
AND the deleted task is cached
├─ BY using the latest deleted task cache
''',
        () async {
          const taskId = 6;
          final task = Task(
            id: taskId,
            title: 'title',
            isCompleted: true,
            createdAt: DateTime.now(),
          );
          when(
            () => tasksStorage.delete(
              taskId: any(named: 'taskId'),
            ),
          ).thenAnswer(
            (_) async => task,
          );
          when(
            () => latestDeletedTaskCache.set(
              any(),
            ),
          ).thenAnswer(
            (_) async {},
          );
          await repo.deleteTask(taskId: taskId);
          verify(
            () => tasksStorage.delete(
              taskId: taskId,
            ),
          ).called(1);
          verify(
            () => latestDeletedTaskCache.set(task),
          ).called(1);
        },
      );

      test(
        '''

AND the ID of a non-existing task
WHEN the task is deleted
THEN no action is taken
├─ BY trying to delete the task with the tasks storage
''',
        () async {
          const taskId = 43;
          when(
            () => tasksStorage.delete(
              taskId: any(named: 'taskId'),
            ),
          ).thenAnswer(
            (_) async => null,
          );
          await repo.deleteTask(taskId: taskId);
          verify(
            () => tasksStorage.delete(
              taskId: taskId,
            ),
          ).called(1);
        },
      );

      test(
        '''

AND a reference task
WHEN all tasks are deleted
THEN the deletion is delegated to the tasks storage
''',
        () async {
          const referenceTask = PartialTask();
          when(
            () => tasksStorage.deleteAll(
              referenceTask: any(named: 'referenceTask'),
            ),
          ).thenAnswer(
            (_) async {},
          );
          await repo.deleteAllTasks(referenceTask: referenceTask);
          verify(
            () => tasksStorage.deleteAll(
              referenceTask: referenceTask,
            ),
          ).called(1);
        },
      );
    },
  );
}
