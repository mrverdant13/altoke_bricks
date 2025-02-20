import 'package:altoke_common/common.dart';
import 'package:drift/drift.dart';
import 'package:drift_local_database/src/tasks.drift.dart';
import 'package:local_database/local_database.dart';

/// {@template drift_local_database.local_tasks_dao}
/// A DAO that manages tasks in a Drift local database.
/// {@endtemplate}
class LocalTasksDriftDao implements LocalTasksDao {
  /// {@macro drift_local_database.local_tasks_dao}
  LocalTasksDriftDao({required this.tasksDrift});

  /// The internal Drift DAO for tasks.
  final TasksDrift tasksDrift;

  @override
  Future<Task> createOne(NewTask newTask) async {
    final NewTask(:title, :priority, :description) = newTask;
    final titleValidationErrors = {
      if (title.trim().isEmpty) TaskTitleValidationError.empty,
    };
    final complexValidationErrors = {
      if (priority == TaskPriority.high && (description ?? '').trim().isEmpty)
        TaskComplexValidationError.highPriorityWithNoDescription,
    };
    if (titleValidationErrors.isNotEmpty ||
        complexValidationErrors.isNotEmpty) {
      throw CreateTaskFailureInvalidData(
        titleValidationErrors: titleValidationErrors,
        complexValidationErrors: complexValidationErrors,
      );
    }
    return tasksDrift.transaction(() async {
      final taskId = await tasksDrift.createTask(
        title: title.trim(),
        priority: priority,
        description: (description ?? '').trim().isEmpty ? null : description,
      );
      return tasksDrift.getTaskById(id: taskId).getSingle();
    });
  }

  @override
  Stream<Iterable<Task>> watchAll() {
    return tasksDrift.tasks.select().watch();
  }

  @override
  Future<void> updateOneById({
    required int taskId,
    required PartialTask task,
  }) async {
    final rawTask = await tasksDrift.getTaskById(id: taskId).getSingleOrNull();
    if (rawTask == null) {
      throw UpdateTaskFailureNotFound(taskId: taskId);
    }
    final PartialTask(:title, :priority, :completed, :description) = task;
    final titleValidationErrors = {
      if (title case Some(value: final title) when title.trim().isEmpty)
        TaskTitleValidationError.empty,
    };
    final complexValidationErrors = {
      if (priority == const Some(TaskPriority.high))
        if (description case Some(
          value: final description,
        ) when (description ?? '').trim().isEmpty)
          TaskComplexValidationError.highPriorityWithNoDescription,
    };
    if (titleValidationErrors.isNotEmpty ||
        complexValidationErrors.isNotEmpty) {
      throw UpdateTaskFailureInvalidData(
        titleValidationErrors: titleValidationErrors,
        complexValidationErrors: complexValidationErrors,
      );
    }
    final resultingTask = TasksCompanion(
      id: Value(taskId),
      title: Value(switch (title) {
        None() => rawTask.title,
        Some(value: final title) => title.trim(),
      }),
      priority: Value(switch (priority) {
        None() => rawTask.priority,
        Some(value: final priority) => priority,
      }),
      completed: Value(switch (completed) {
        None() => rawTask.completed,
        Some(value: final completed) => completed,
      }),
      description: switch (description) {
        None() => const Value.absent(),
        Some(value: final description) => Value(switch (description?.trim() ??
            '') {
          '' => null,
          final description => description,
        }),
      },
    );
    await tasksDrift.tasks.replaceOne(resultingTask);
  }

  @override
  Future<void> deleteOneById(int taskId) async {
    await tasksDrift.tasks.deleteWhere((tasks) => tasks.id.equals(taskId));
  }
}
