import 'package:local_database/local_database.dart';

/// {@template local_database.local_tasks_dao}
/// An interface for a DAO that manages tasks in a local database.
/// {@endtemplate}
abstract interface class LocalTasksDao {
  /// Creates a new task.
  Future<Task> createOne(
    NewTask newTask,
  );

  /// Watches all tasks.
  Stream<Iterable<Task>> watchAll();

  /// Updates a task, identified by its [taskId], with the provided [task] data.
  Future<void> updateOneById({
    required int taskId,
    required PartialTask task,
  });

  /// Deletes a task, identified by its [taskId].
  Future<void> deleteOneById(
    int taskId,
  );
}