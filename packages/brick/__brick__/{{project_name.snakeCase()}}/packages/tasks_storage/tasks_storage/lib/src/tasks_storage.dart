import 'package:tasks/tasks.dart';
import 'package:tasks_storage/tasks_storage.dart';

/// {@template tasks_storage}
/// An interface for a storage system for tasks.
/// {@endtemplate}
abstract interface class TasksStorage {
  /// Creates a new task.
  ///
  /// Throws a [CreateTaskFailure] if the task fails to be created.
  Future<void> create({
    required NewTask newTask,
  });

  /// Inserts a new task.
  Future<void> insert({
    required Task task,
  });

  /// Retrieves a task by its ID.
  Future<Task?> getById(
    int taskId,
  );

  /// Returns a stream of the tasks that match the given [statusFilter] and
  /// [searchTerm], paginated by the given [offset] and [limit].
  Stream<List<Task>> watchPaginated({
    required int offset,
    required int limit,
    required TasksStatusFilter statusFilter,
    String? searchTerm,
  });

  /// Returns the number of tasks that match the given [statusFilter] and
  /// [searchTerm].
  Stream<int> watchCount({
    required TasksStatusFilter statusFilter,
    String? searchTerm,
  });

  /// Updates a task identified by its [taskId] with the given [partialTask].
  ///
  /// Throws an [UpdateTaskFailure] if the task fails to be updated.
  Future<void> update({
    required int taskId,
    required PartialTask partialTask,
  });

  /// Marks all tasks as completed.
  Future<void> markAllAsCompleted();

  /// Deletes a task identified by its [taskId].
  Future<Task?> delete({
    required int taskId,
  });

  /// Deletes all tasks that match the given [referenceTask].
  Future<void> deleteAll({
    PartialTask? referenceTask,
  });
}
