import 'package:altoke_local_database/altoke_local_database.dart';

/// {@template altoke_local_database.local_tasks_dao}
/// An interface for a DAO that manages tasks in a local database.
/// {@endtemplate}
abstract interface class LocalTasksDao {
  /// {@macro altoke_local_database.local_tasks_dao}
  const LocalTasksDao();

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
