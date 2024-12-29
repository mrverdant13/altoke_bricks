import 'package:common/common.dart';
import 'package:hive/hive.dart';
import 'package:{{#use_hive}}hive_local_database{{/use_hive}}/src/helpers.dart' as hive;
import 'package:{{#requirements_met}}local_database{{/requirements_met}}/{{#requirements_met}}local_database{{/requirements_met}}.dart';
import 'package:meta/meta.dart';

/// {@template {{#use_hive}}hive_local_database{{/use_hive}}.local_tasks_dao}
/// A DAO that manages tasks in an Hive local database.
/// {@endtemplate}
class LocalTasksHiveDao implements LocalTasksDao {
  /// {@macro {{#use_hive}}hive_local_database{{/use_hive}}.local_tasks_dao}
  LocalTasksHiveDao();

  /// Name for the tasks tasksBox.
  static const tasksBoxName = '.tasks.';

  /// Box for the tasks.
  @visibleForTesting
  final Future<hive.TasksBox> asyncTasksBox = Hive.openBox(tasksBoxName);

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
    final tasksBox = await asyncTasksBox;
    final id = await tasksBox.add({
      hive.Task.titleJsonKey: title,
      hive.Task.priorityJsonKey: priority.identifier,
      hive.Task.descriptionJsonKey:
          ((description ?? '').trim().isEmpty) ? null : description?.trim(),
      hive.Task.completedJsonKey: false,
    });
    return newTask.toTaskWithId(id);
  }

  @override
  Stream<Iterable<Task>> watchAll() async* {
    final tasksBox = await asyncTasksBox;

    Iterable<Task> getTasks() {
      return tasksBox.toMap().entries.toTasks();
    }

    yield* () async* {
      yield getTasks();
      yield* tasksBox.watch().map((_) => getTasks());
    }();
  }

  @override
  Future<void> updateOneById({
    required int taskId,
    required PartialTask task,
  }) async {
    final tasksBox = await asyncTasksBox;
    final rawTask = tasksBox.get(taskId);
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
      rawTask[hive.Task.titleJsonKey] = title.trim();
    }
    if (priority case Some(value: final priority)) {
      rawTask[hive.Task.priorityJsonKey] = priority.identifier;
    }
    if (completed case Some(value: final completed)) {
      rawTask[hive.Task.completedJsonKey] = completed;
    }
    if (description case Some(value: final description)) {
      rawTask[hive.Task.descriptionJsonKey] =
          (description ?? '').trim().isEmpty ? null : description?.trim();
    }
    await tasksBox.put(taskId, rawTask);
  }

  @override
  Future<void> deleteOneById(
    int taskId,
  ) async {
    final tasksBox = await asyncTasksBox;
    return tasksBox.delete(taskId);
  }
}

extension on NewTask {
  Task toTaskWithId(int id) => Task(
        id: id,
        title: title,
        priority: priority,
        completed: false,
        description: description,
      );
}

extension on Iterable<MapEntry<dynamic, Map<dynamic, dynamic>>> {
  Iterable<Task> toTasks() => map(
        (entry) {
          final MapEntry(key: id, value: rawData) = entry;
          return Task(
            id: id as int,
            title: rawData[hive.Task.titleJsonKey] as String,
            priority:
                (rawData[hive.Task.priorityJsonKey] as String).toTaskPriority(),
            completed: rawData[hive.Task.completedJsonKey] as bool,
            description: rawData[hive.Task.descriptionJsonKey] as String?,
          );
        },
      );
}

const _identifiableTaskPriorityMap = {
  'low': TaskPriority.low,
  'medium': TaskPriority.medium,
  'high': TaskPriority.high,
};

/// An extension on [TaskPriority] to make it identifiable for the Hive
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
