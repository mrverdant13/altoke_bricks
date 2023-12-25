import 'package:common/common.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:tasks/tasks.dart';
import 'package:tasks_storage/tasks_storage.dart';

/// {@template tasks_hive_storage}
/// A persistent [TasksStorage] implementation using Hive.
/// {@endtemplate}
class TasksHiveStorage implements TasksStorage {
  /// {@macro tasks_hive_storage}
  TasksHiveStorage({
    required this.box,
  }) : assert(
          box.name == boxName,
          'The box name must be `$boxName`. '
          'You can use the `TasksHiveStorage.boxName` static constant.',
        );

  /// Name for the tasks box.
  static const boxName = '.tasks-hive-storage.';

  /// Box for the tasks.
  @visibleForTesting
  late final Box<Json> box;

  @override
  Future<void> create({
    required NewTask newTask,
  }) async {
    if (newTask.title.isEmpty) throw const CreateTaskFailureEmptyTitle();
    await box.add(newTask.toHiveJson());
  }

  @override
  Future<Task?> delete({
    required int taskId,
  }) async {
    final rawTask = box.get(taskId);
    if (rawTask == null) return null;
    await box.delete(taskId);
    return rawTask.toTaskWithId(taskId);
  }

  @override
  Future<void> deleteAll({
    PartialTask? referenceTask,
  }) async {
    final filter = referenceTask?.toHiveFilter();
    if (filter == null) {
      await box.clear();
      return;
    }
    final keysToDelete = box.tasks.where(filter).toTaskIds();
    await box.deleteAll(keysToDelete);
  }

  @override
  Future<void> insert({
    required Task task,
  }) async {
    await box.put(task.id, task.toHiveJson());
  }

  @override
  Future<void> markAllAsCompleted() async {
    await box.putAll({
      for (final task in box.tasks)
        task.id: task.copyWith(isCompleted: true).toHiveJson(),
    });
  }

  @override
  Future<void> update({
    required int taskId,
    required PartialTask partialTask,
  }) async {
    if (partialTask case PartialTask(:final title?) when title().isEmpty) {
      throw const UpdateTaskFailureEmptyTitle();
    }
    final rawTask = box.get(taskId);
    if (rawTask == null) return;
    await box.put(
      taskId,
      {
        ...rawTask,
        ...partialTask.toJson(),
      },
    );
  }

  @override
  Future<Task?> getById(
    int taskId,
  ) async {
    final rawTask = box.get(taskId);
    if (rawTask == null) return null;
    return rawTask.toTaskWithId(taskId);
  }

  @override
  Stream<List<Task>> watchPaginated({
    required int offset,
    required int limit,
    required TasksStatusFilter statusFilter,
    String? searchTerm,
  }) {
    final dbFilter = (
      statusFilter: statusFilter,
      nullableSearchTerm: searchTerm,
    ).toHiveFilter();
    return box
        .watch()
        .map(
          (_) => (box.tasks.where(dbFilter).toList()
                ..sort((a, b) => b.createdAt.compareTo(a.createdAt)))
              .skip(offset)
              .take(limit)
              .toList(),
        )
        .distinct(
      (previous, next) {
        if (previous.length != next.length) return false;
        for (var i = 0; i < previous.length; i++) {
          if (previous[i] != next[i]) return false;
        }
        return true;
      },
    );
  }

  @override
  Stream<int> watchCount({
    required TasksStatusFilter statusFilter,
    String? searchTerm,
  }) {
    final dbFilter = (
      statusFilter: statusFilter,
      nullableSearchTerm: searchTerm,
    ).toHiveFilter();
    return box.watch().map((_) => box.tasks.where(dbFilter).length).distinct();
  }
}

/// Abstract class that holds the field keys for the [Json] representation of
/// the different variants of a task.
extension HiveTask on Task {
  /// Field key for the task ID.
  static const idFieldJsonKey = 'id';

  /// Field key for the task title.
  static const titleFieldJsonKey = 'title';

  /// Field key for the task status.
  static const statusFieldJsonKey = 'isCompleted';

  /// Field key for the task description.
  static const descriptionFieldJsonKey = 'description';

  /// Field key for the task creation date.
  static const createdAtFieldJsonKey = 'createdAt';
}

/// An extension on [NewTask] to add serialization capabilities.
@visibleForTesting
extension SerializableHiveNewTask on NewTask {
  /// Converts a [NewTask] to a [Json].
  Json toHiveJson() {
    return {
      HiveTask.titleFieldJsonKey: title,
      HiveTask.statusFieldJsonKey: isCompleted,
      HiveTask.descriptionFieldJsonKey: description,
      HiveTask.createdAtFieldJsonKey: DateTime.now().toIso8601String(),
    };
  }
}

/// An extension on [Task] to add serialization capabilities.
@visibleForTesting
extension SerializableHiveTask on Task {
  /// Converts a [Task] to a [Json].
  Json toHiveJson() {
    return {
      HiveTask.titleFieldJsonKey: title,
      HiveTask.statusFieldJsonKey: isCompleted,
      HiveTask.descriptionFieldJsonKey: description,
      HiveTask.createdAtFieldJsonKey: createdAt.toIso8601String(),
    };
  }
}

extension on Json {
  Task toTask() {
    return Task(
      id: this[HiveTask.idFieldJsonKey] as int,
      title: this[HiveTask.titleFieldJsonKey] as String,
      isCompleted: this[HiveTask.statusFieldJsonKey] as bool,
      createdAt: DateTime.parse(
        this[HiveTask.createdAtFieldJsonKey] as String,
      ),
      description: this[HiveTask.descriptionFieldJsonKey] as String?,
    );
  }

  Task toTaskWithId(int id) {
    return {
      HiveTask.idFieldJsonKey: id,
      ...this,
    }.toTask();
  }
}

extension on PartialTask {
  Json toJson() {
    final PartialTask(
      title: titleSetter,
      isCompleted: isCompletedSetter,
      description: descriptionSetter,
    ) = this;
    return {
      if (titleSetter != null) HiveTask.titleFieldJsonKey: titleSetter(),
      if (isCompletedSetter != null)
        HiveTask.statusFieldJsonKey: isCompletedSetter(),
      if (descriptionSetter != null)
        HiveTask.descriptionFieldJsonKey: descriptionSetter(),
    };
  }

  WhereCallback<Task> toHiveFilter() {
    final PartialTask(
      title: partialTitle,
      isCompleted: partialIsCompleted,
      description: partialDescription,
    ) = this;
    final titleMatches = switch (partialTitle) {
      null => (_) => true,
      _ => switch (partialTitle().trim()) {
          final partialTitle when partialTitle.isEmpty => (_) => true,
          final partialTitle => (Task task) =>
              task.title.contains(partialTitle),
        },
    };
    final isCompletedMatches = switch (partialIsCompleted) {
      null => (_) => true,
      _ => (Task task) => task.isCompleted == partialIsCompleted(),
    };
    final descriptionMatches = switch (partialDescription) {
      null => (_) => true,
      _ => switch (partialDescription()?.trim()) {
          null => (Task task) => task.description == null,
          final partialDescription when partialDescription.isEmpty =>
            (Task task) => task.description != null,
          final partialDescription => (Task task) => switch (task.description) {
                null => false,
                final description => description.contains(partialDescription),
              },
        },
    };
    return (Task task) =>
        titleMatches(task) &&
        isCompletedMatches(task) &&
        descriptionMatches(task);
  }
}

/// A callback that can be used to filter a list of elements.
typedef WhereCallback<T> = bool Function(T element);

extension on TasksStatusFilter {
  WhereCallback<Task> toHiveFilter() {
    return switch (this) {
      TasksStatusFilter.all => (_) => true,
      TasksStatusFilter.uncompleted => (task) => !task.isCompleted,
      TasksStatusFilter.completed => (task) => task.isCompleted,
    };
  }
}

/// Converts a [nullableSearchTerm] to a [WhereCallback] that can be used to
/// filter a list of [Task]s.
@visibleForTesting
WhereCallback<Task> searchTermToHiveFilter(String? nullableSearchTerm) {
  return switch (nullableSearchTerm?.trim()) {
    null => (_) => true,
    String(:final isEmpty) when isEmpty => (_) => true,
    final searchTerm => (task) =>
        task.title.contains(searchTerm) ||
        (task.description?.contains(searchTerm) ?? false),
  };
}

/// A record that holds the filtering items for a tasks query.
typedef FilteringItems = ({
  TasksStatusFilter statusFilter,
  String? nullableSearchTerm,
});

extension on FilteringItems {
  WhereCallback<Task> toHiveFilter() {
    final dbStatusFilter = statusFilter.toHiveFilter();
    final dbSearchFilter = searchTermToHiveFilter(nullableSearchTerm);
    return (task) => dbStatusFilter(task) && dbSearchFilter(task);
  }
}

/// An extension on [TaskRecordEntry] to add deserialization capabilities.
@visibleForTesting
extension DeserializableTaskRecordEntry on TaskRecordEntry {
  /// Converts a [TaskRecordEntry] to a [Task].
  Task toTask() => value.toTaskWithId(key as int);
}

/// An extension on [TaskRecordEntriesIterable] to add deserialization
/// capabilities.
@visibleForTesting
extension DeserializableTaskRecordEntriesIterable on TaskRecordEntriesIterable {
  /// Converts an [Iterable] of [TaskRecordEntry]s to a list of [Task]s.
  Iterable<Task> toTasks() => map((entry) => entry.toTask());
}

/// An extension on [TasksIterable] to add serialization capabilities.
@visibleForTesting
extension SerializableTasksIterable on TasksIterable {
  /// Converts an [Iterable] of [Task]s to a list of their corresponding
  /// keys.
  Iterable<int> toTaskIds() => map((task) => task.id);
}

/// An entry that represents a task record.
typedef TaskRecordEntry = MapEntry<dynamic, Json>;

/// An [Iterable] of [TaskRecordEntry]s.
typedef TaskRecordEntriesIterable = Iterable<TaskRecordEntry>;

/// An [Iterable] of [Task]s.
typedef TasksIterable = Iterable<Task>;

extension on Box<Json> {
  Iterable<Task> get tasks => toMap().entries.toTasks();
}
