import 'package:common/common.dart';
import 'package:isar/isar.dart';
import 'package:{{#use_isar}}isar_local_database{{/use_isar}}/src/helpers.dart';
import 'package:{{#use_isar}}isar_local_database{{/use_isar}}/src/task.dart' as isar;
import 'package:{{#preconditions_met}}local_database{{/preconditions_met}}/{{#preconditions_met}}local_database{{/preconditions_met}}.dart';
import 'package:meta/meta.dart';

/// {@template {{#use_isar}}isar_local_database{{/use_isar}}.local_tasks_dao}
/// A DAO that manages tasks in an Isar local database.
/// {@endtemplate}
class LocalTasksIsarDao implements LocalTasksDao {
  /// {@macro {{#use_isar}}isar_local_database{{/use_isar}}.local_tasks_dao}
  LocalTasksIsarDao({
    required this.database,
  });

  /// The internal Isar database.
  @visibleForTesting
  final Isar database;

  /// The internal Isar collection for tasks.
  @visibleForTesting
  IsarCollection<isar.Task> get tasksCollection => database.tasks;

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
    final rawTask = await database.writeTxn(
      () async {
        final taskId = await tasksCollection.put(
          isar.Task()
            ..title = title.trim()
            ..priority = priority.identifier
            ..description =
                (description ?? '').trim().isEmpty ? null : description?.trim()
            ..completed = false,
        );
        return tasksCollection.get(taskId);
      },
    );
    return rawTask!.toTask();
  }

  @override
  Stream<Iterable<Task>> watchAll() {
    return tasksCollection
        .filter()
        .noop()
        .watch(fireImmediately: true)
        .map((tasks) => tasks.toTasks());
  }

  @override
  Future<void> updateOneById({
    required int taskId,
    required PartialTask task,
  }) async {
    final rawTask = await tasksCollection.get(taskId);
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
        if (description case Some(value: final description)
            when (description ?? '').trim().isEmpty)
          TaskComplexValidationError.highPriorityWithNoDescription,
    };
    if (titleValidationErrors.isNotEmpty ||
        complexValidationErrors.isNotEmpty) {
      throw UpdateTaskFailureInvalidData(
        titleValidationErrors: titleValidationErrors,
        complexValidationErrors: complexValidationErrors,
      );
    }
    if (title case Some(value: final title)) {
      rawTask.title = title.trim();
    }
    if (priority case Some(value: final priority)) {
      rawTask.priority = priority.identifier;
    }
    if (completed case Some(value: final completed)) {
      rawTask.completed = completed;
    }
    if (description case Some(value: final description)) {
      rawTask.description =
          (description ?? '').trim().isEmpty ? null : description?.trim();
    }
    await database.writeTxn(
      () async {
        await tasksCollection.put(rawTask);
      },
    );
  }

  @override
  Future<void> deleteOneById(
    int taskId,
  ) async {
    await database.writeTxn(
      () async => tasksCollection.delete(taskId),
    );
  }
}

extension on isar.Task {
  Task toTask() => Task(
        id: id,
        title: title,
        priority: priority.toTaskPriority(),
        completed: completed,
        description: description,
      );
}

extension on List<isar.Task> {
  Iterable<Task> toTasks() => map(
        (result) => result.toTask(),
      );
}

const _identifiableTaskPriorityMap = {
  'low': TaskPriority.low,
  'medium': TaskPriority.medium,
  'high': TaskPriority.high,
};

/// An extension on [TaskPriority] to make it identifiable for the Isar
/// database.
@visibleForTesting
extension IdentifiableTaskPriority on TaskPriority {
  /// The priority internal identifier.
  String get identifier => _identifiableTaskPriorityMap.entries
      .firstWhere((entry) => entry.value == this)
      .key;
}

/// An extension on a [String] that represents a [TaskPriority] identifier.
@visibleForTesting
extension TaskPriorityIdentifier on String {
  /// Returns the corresponding [TaskPriority].
  TaskPriority toTaskPriority() => _identifiableTaskPriorityMap[this]!;
}
