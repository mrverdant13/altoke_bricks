import 'package:common/common.dart';
import 'package:local_database/local_database.dart';
import 'package:meta/meta.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast_local_database/src/helpers.dart' as sembast;

/// {@template sembast_local_database.local_tasks_dao}
/// A DAO that manages tasks in an Sembast local database.
/// {@endtemplate}
class LocalTasksSembastDao implements LocalTasksDao {
  /// {@macro sembast_local_database.local_tasks_dao}
  LocalTasksSembastDao({
    required this.database,
  });

  /// The internal Sembast database.
  @visibleForTesting
  final Database database;

  /// Name for the tasks store.
  @visibleForTesting
  static const tasksStoreName = '<tasks>';

  /// Reference for the tasks store.
  @visibleForTesting
  late final sembast.TasksStoreRef tasksStore = StoreRef(tasksStoreName);

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

    final id = await tasksStore.add(database, {
      sembast.Task.titleJsonKey: title,
      sembast.Task.priorityJsonKey: priority.identifier,
      sembast.Task.descriptionJsonKey:
          ((description ?? '').trim().isEmpty) ? null : description?.trim(),
      sembast.Task.completedJsonKey: false,
    });
    return newTask.toTaskWithId(id);
  }

  @override
  Stream<Iterable<Task>> watchAll() {
    return tasksStore
        .query()
        .onSnapshots(database)
        .map((tasks) => tasks.toTasks());
  }

  @override
  Future<void> updateOneById({
    required int taskId,
    required PartialTask task,
  }) async {
    final taskExists = await tasksStore.record(taskId).exists(database);
    if (!taskExists) {
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
    final taskPatch = <String, Object?>{};
    if (title case Some(value: final title)) {
      taskPatch[sembast.Task.titleJsonKey] = title.trim();
    }
    if (priority case Some(value: final priority)) {
      taskPatch[sembast.Task.priorityJsonKey] = priority.identifier;
    }
    if (completed case Some(value: final completed)) {
      taskPatch[sembast.Task.completedJsonKey] = completed;
    }
    if (description case Some(value: final description)) {
      taskPatch[sembast.Task.descriptionJsonKey] =
          (description ?? '').trim().isEmpty ? null : description?.trim();
    }
    await tasksStore.record(taskId).put(database, taskPatch, merge: true);
  }

  @override
  Future<void> deleteOneById(
    int taskId,
  ) async {
    await tasksStore.record(taskId).delete(database);
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

extension on Iterable<RecordSnapshot<int, Map<String, Object?>>> {
  Iterable<Task> toTasks() => map(
        (snapshot) {
          final RecordSnapshot(key: id, value: rawData) = snapshot;
          return Task(
            id: id,
            title: rawData[sembast.Task.titleJsonKey]! as String,
            priority: (rawData[sembast.Task.priorityJsonKey]! as String)
                .toTaskPriority(),
            completed: rawData[sembast.Task.completedJsonKey]! as bool,
            description: rawData[sembast.Task.descriptionJsonKey] as String?,
          );
        },
      );
}

const _identifiableTaskPriorityMap = {
  'low': TaskPriority.low,
  'medium': TaskPriority.medium,
  'high': TaskPriority.high,
};

/// An extension on [TaskPriority] to make it identifiable for the Sembast
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
