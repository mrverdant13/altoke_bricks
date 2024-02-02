import 'package:isar/isar.dart';
import 'package:meta/meta.dart';
import 'package:tasks/tasks.dart';
import 'package:tasks_storage/tasks_storage.dart';

part 'tasks_isar_storage.g.dart';

/// Task representation for Isar.
@visibleForTesting
@collection
class IsarTask {
  /// Task ID.
  late Id id = Isar.autoIncrement;

  /// Task title.
  late String title;

  /// Task status.
  late bool isCompleted;

  /// Task creation date.
  late DateTime createdAt = DateTime.now();

  /// Task description.
  late String? description;
}

/// {@template tasks_isar_storage}
/// A persistent [TasksStorage] implementation using Isar.
/// {@endtemplate}
class TasksIsarStorage implements TasksStorage {
  /// {@macro tasks_isar_storage}
  const TasksIsarStorage({
    required this.database,
  });

  /// Box for the tasks.
  @visibleForTesting
  final Isar database;

  /// The tasks collection.
  @visibleForTesting
  IsarTasksCollection get tasksCollection => database.isarTasks;

  @override
  Future<void> create({
    required NewTask newTask,
  }) async {
    if (newTask.title.isEmpty) throw const CreateTaskFailureEmptyTitle();
    await database.writeTxn(
      () async => tasksCollection.put(
        newTask.toIsarTask(),
      ),
    );
  }

  @override
  Future<Task?> delete({
    required int taskId,
  }) async {
    final isarTask = await tasksCollection.get(taskId);
    if (isarTask == null) return null;
    await database.writeTxn(
      () async => tasksCollection.delete(taskId),
    );
    return isarTask.toTask();
  }

  @override
  Future<void> deleteAll({
    PartialTask? referenceTask,
  }) async {
    final query = tasksCollection.filter().matchesPartial(referenceTask);
    await database.writeTxn(
      () async => query.deleteAll(),
    );
  }

  @override
  Future<void> insert({
    required Task task,
  }) async {
    final foundTask = await tasksCollection.get(task.id);
    if (foundTask != null) return;
    await database.writeTxn(
      () async => tasksCollection.put(task.toIsarTask()),
    );
  }

  @override
  Future<void> markAllAsCompleted() async {
    await database.writeTxn(
      () async {
        final tasks =
            await tasksCollection.filter().isCompletedEqualTo(false).findAll();
        await tasksCollection.putAll([
          for (final task in tasks) task..isCompleted = true,
        ]);
      },
    );
  }

  @override
  Future<void> update({
    required int taskId,
    required PartialTask partialTask,
  }) async {
    if (partialTask case PartialTask(:final title?) when title().isEmpty) {
      throw const UpdateTaskFailureEmptyTitle();
    }
    await database.writeTxn(
      () async {
        final isarTask = await tasksCollection.get(taskId);
        if (isarTask == null) return;
        await tasksCollection.put(isarTask..applyPartial(partialTask));
      },
    );
  }

  @override
  Future<Task?> getById(
    int taskId,
  ) async {
    final isarTask = await tasksCollection.get(taskId);
    return isarTask?.toTask();
  }

  @override
  Stream<List<Task>> watchPaginated({
    required int offset,
    required int limit,
    required TasksStatusFilter statusFilter,
    String? searchTerm,
  }) {
    final query = tasksCollection
        .filter()
        .statusEqualsTo(statusFilter)
        .and()
        .contentMatches(searchTerm)
        .sortByCreatedAtDesc()
        .offset(offset)
        .limit(limit);

    bool tasksListsAreEqual(List<Task> previous, List<Task> next) {
      if (previous.length != next.length) return false;
      for (var i = 0; i < previous.length; i++) {
        if (previous[i] != next[i]) return false;
      }
      return true;
    }

    return query
        .watch(fireImmediately: true)
        .map(tasksFromIsarTasks)
        .distinct(tasksListsAreEqual);
  }

  @override
  Stream<int> watchCount({
    required TasksStatusFilter statusFilter,
    String? searchTerm,
  }) {
    return tasksCollection
        .filter()
        .statusEqualsTo(statusFilter)
        .and()
        .contentMatches(searchTerm)
        .watch(fireImmediately: true)
        .map((tasks) => tasks.length);
  }
}

/// An Isar collection of [IsarTask]s.
typedef IsarTasksCollection = IsarCollection<IsarTask>;

/// An extension on [NewTask] to add serialization capabilities.
@visibleForTesting
extension SerializableIsarNewTask on NewTask {
  /// Converts a [NewTask] to a [IsarTask].
  IsarTask toIsarTask() {
    return IsarTask()
      ..title = title
      ..isCompleted = isCompleted
      ..description = description;
  }
}

/// An extension on [Task] to add serialization capabilities.
@visibleForTesting
extension SerializableIsarTask on Task {
  /// Converts a [Task] to a [IsarTask].
  IsarTask toIsarTask() {
    return IsarTask()
      ..id = id
      ..title = title
      ..isCompleted = isCompleted
      ..createdAt = createdAt
      ..description = description;
  }
}

/// A callback that can be used to filter a list of elements.
typedef WhereCallback<T> = bool Function(T element);

/// A query builder to be applied over [IsarTasksCollection].
typedef TasksQueryBuilder = QueryBuilder<IsarTask, IsarTask, QFilterCondition>;

/// A conditioned query builder to be applied over [IsarTasksCollection].
typedef TasksConditionedQueryBuilder
    = QueryBuilder<IsarTask, IsarTask, QAfterFilterCondition>;

extension on TasksQueryBuilder {
  TasksConditionedQueryBuilder noop() {
    // ignore: invalid_use_of_protected_member
    return QueryBuilder.apply<IsarTask, IsarTask, QAfterFilterCondition>(
      this,
      (q) => q,
    );
  }

  TasksConditionedQueryBuilder statusEqualsTo(TasksStatusFilter? filter) {
    return switch (filter) {
      null || TasksStatusFilter.all => noop(),
      TasksStatusFilter.uncompleted => isCompletedEqualTo(false),
      TasksStatusFilter.completed => isCompletedEqualTo(true),
    };
  }

  TasksConditionedQueryBuilder contentMatches(String? title) {
    return switch (title?.trim()) {
      null => noop(),
      String(:final isEmpty) when isEmpty => noop(),
      final title => group(
          (q) => q
              .titleContains(title, caseSensitive: false)
              .or()
              .descriptionContains(title, caseSensitive: false),
        ),
    };
  }

  TasksConditionedQueryBuilder matchesPartial(PartialTask? partialTask) {
    if (partialTask == null) return noop();
    final PartialTask(
      title: titleSetter,
      isCompleted: isCompletedSetter,
      description: descriptionSetter,
    ) = partialTask;
    var query = noop();
    if (titleSetter != null) {
      query = query.and().titleContains(titleSetter());
    }
    if (isCompletedSetter != null) {
      query = query.and().isCompletedEqualTo(isCompletedSetter());
    }
    if (descriptionSetter != null) {
      final description = descriptionSetter();
      if (description == null) {
        query = query.and().descriptionIsNull();
      } else {
        query = query.and().descriptionContains(description);
      }
    }
    return query;
  }
}

/// An extension on [IsarTask] to add deserialization capabilities.
@visibleForTesting
extension DeserializableIsarTask on IsarTask {
  /// Converts a [IsarTask] to a [Task].
  Task toTask() {
    return Task(
      id: id,
      title: title,
      isCompleted: isCompleted,
      createdAt: createdAt,
      description: description,
    );
  }
}

/// An extension on [IsarTask] to add update utilities.
@visibleForTesting
extension UpdatableIsarTask on IsarTask {
  /// Applies a [PartialTask] to an [IsarTask].
  void applyPartial(PartialTask partialTask) {
    final PartialTask(
      title: titleSetter,
      isCompleted: isCompletedSetter,
      description: descriptionSetter,
    ) = partialTask;
    if (titleSetter != null) title = titleSetter();
    if (isCompletedSetter != null) isCompleted = isCompletedSetter();
    if (descriptionSetter != null) description = descriptionSetter();
  }
}

/// An [Iterable] of [IsarTask]s.
typedef IsarTasksIterable = Iterable<IsarTask>;

/// Converts an [IsarTask] to a [Task]s.
@visibleForTesting
Task taskFromIsarTask(IsarTask isarTask) {
  return isarTask.toTask();
}

/// Converts an [IsarTasksIterable] to a list of [Task]s.
@visibleForTesting
List<Task> tasksFromIsarTasks(IsarTasksIterable isarTasks) {
  return isarTasks.map(taskFromIsarTask).toList();
}
