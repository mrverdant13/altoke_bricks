import 'package:element_in_memory_cache/element_in_memory_cache.dart';
import 'package:meta/meta.dart';
import 'package:tasks/tasks.dart';
import 'package:tasks_storage/tasks_storage.dart';

/// {@template tasks_repository}
/// A repository that manages tasks.
/// {@endtemplate}
class TasksRepository {
  /// {@macro tasks_repository}
  TasksRepository({
    required this.latestDeletedTaskCache,
    required this.tasksStorage,
  });

  /// The cache of the latest deleted task.
  @visibleForTesting
  final ElementInMemoryCache<Task> latestDeletedTaskCache;

  /// The storage of tasks.
  @visibleForTesting
  final TasksStorage tasksStorage;

  /// Creates a new task.
  ///
  /// Throws a [CreateTaskFailure] if the task fails to be created.
  Future<void> createTask({
    required NewTask newTask,
  }) async {
    return tasksStorage.create(
      newTask: newTask,
    );
  }

  /// Restores the latest deleted task, if any.
  Future<void> restoreLatestDeletedTask() async {
    final task = await latestDeletedTaskCache.get();
    if (task == null) return;
    await tasksStorage.insert(task: task);
    await latestDeletedTaskCache.set(null);
  }

  /// Returns the task identified by the given [taskId].
  ///
  /// Returns `null` if no task is found.
  Future<Task?> getTaskById(
    int taskId,
  ) async {
    return tasksStorage.getById(taskId);
  }

  /// Returns a stream of the tasks that match the given [statusFilter] and
  /// [searchTerm], paginated by the given [offset] and [limit].
  Stream<List<Task>> watchPaginatedTasks({
    required int offset,
    required int limit,
    required TasksStatusFilter statusFilter,
    String? searchTerm,
  }) {
    return tasksStorage.watchPaginated(
      offset: offset,
      limit: limit,
      statusFilter: statusFilter,
      searchTerm: searchTerm,
    );
  }

  /// Returns the number of tasks that match the given [statusFilter] and
  /// [searchTerm].
  Stream<int> watchCount({
    required TasksStatusFilter statusFilter,
    String? searchTerm,
  }) {
    return tasksStorage.watchCount(
      statusFilter: statusFilter,
      searchTerm: searchTerm,
    );
  }

  /// Returns a stream of the latest deleted task, if any.
  Stream<Task?> watchLatestDeletedTask() {
    return latestDeletedTaskCache.watch();
  }

  /// Updates a task identified by its [taskId] with the given [partialTask].
  ///
  /// Throws an [UpdateTaskFailure] if the task fails to be updated.
  Future<void> updateTask({
    required int taskId,
    required PartialTask partialTask,
  }) async {
    return tasksStorage.update(
      taskId: taskId,
      partialTask: partialTask,
    );
  }

  /// Marks all tasks as completed.
  Future<void> markAllTasksAsCompleted() async {
    await tasksStorage.markAllAsCompleted();
  }

  /// Deletes a task identified by its [taskId].
  ///
  /// The deleted task is cached in [latestDeletedTaskCache] and can be restored
  /// by calling [restoreLatestDeletedTask].
  Future<void> deleteTask({
    required int taskId,
  }) async {
    final task = await tasksStorage.delete(
      taskId: taskId,
    );
    if (task == null) return;
    await latestDeletedTaskCache.set(task);
  }

  /// Deletes all tasks that match the given [referenceTask].
  Future<void> deleteAllTasks({
    PartialTask? referenceTask,
  }) async {
    await tasksStorage.deleteAll(
      referenceTask: referenceTask,
    );
  }
}
