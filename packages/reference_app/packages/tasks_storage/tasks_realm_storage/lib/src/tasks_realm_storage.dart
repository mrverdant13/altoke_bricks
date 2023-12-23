import 'package:meta/meta.dart';
import 'package:realm_dart/realm.dart';
import 'package:tasks/tasks.dart';
import 'package:tasks_storage/tasks_storage.dart';

part 'tasks_realm_storage.g.dart';

/// Task representation for Realm.
@RealmModel()
class _RealmTask {
  /// Task ID.
  @PrimaryKey()
  late int id;

  /// Task title.
  late String title;

  /// Task status.
  late bool isCompleted;

  /// Task creation date.
  late DateTime createdAt;

  /// Task description.
  late String? description;
}

/// Realm schema for tasks.
// ignore: non_constant_identifier_names
final RealmTaskSchema = RealmTask.schema;

/// {@template tasks_realm_storage}
/// A persistent [TasksStorage] implementation using Realm.
/// {@endtemplate}
class TasksRealmStorage implements TasksStorage {
  /// {@macro tasks_realm_storage}
  TasksRealmStorage({
    required this.database,
  });

  /// The Realm database.
  @visibleForTesting
  final Realm database;

  @override
  Future<void> create({
    required NewTask newTask,
  }) async {
    if (newTask.title.isEmpty) throw const CreateTaskFailureEmptyTitle();
    await database.write(() async {
      final latestTaskId = database
              .query<RealmTask>('id != 0 SORT(id DESC) LIMIT(1)')
              .firstOrNull
              ?.id ??
          0;
      final newId = latestTaskId + 1;
      database.add<RealmTask>(newTask.toRealmTask(newId));
    });
  }

  @override
  Future<Task?> delete({
    required String taskId,
  }) async {
    final numericTaskId = int.parse(taskId);
    final existingRealmTask = database.find<RealmTask>(numericTaskId);
    if (existingRealmTask == null) return null;
    final existingTask = existingRealmTask.toTask();
    await database.write(() async {
      database.delete<RealmTask>(existingRealmTask);
    });
    return existingTask;
  }

  @override
  Future<void> deleteAll({
    PartialTask? referenceTask,
  }) async {
    final queryExpression = referenceTask?.toQueryExpression();
    if (queryExpression == null) {
      await database.write(() async {
        database.deleteAll<RealmTask>();
      });
      return;
    }
    await database.write(() async {
      final matchingTasks = database.all<RealmTask>().query(queryExpression);
      database.deleteMany<RealmTask>(matchingTasks);
    });
  }

  @override
  Future<void> insert({
    required Task task,
  }) async {
    await database.write(() async {
      database.add<RealmTask>(task.toRealmTask());
    });
  }

  @override
  Future<void> markAllAsCompleted() async {
    final incompleteTasks =
        database.all<RealmTask>().query('isCompleted == false');
    await database.write(() async {
      for (final task in incompleteTasks) {
        task.isCompleted = true;
      }
    });
  }

  @override
  Future<void> update({
    required String taskId,
    required PartialTask partialTask,
  }) async {
    if (partialTask case PartialTask(:final title?)
        when title().trim().isEmpty) {
      throw const UpdateTaskFailureEmptyTitle();
    }
    final existingTask = database.find<RealmTask>(int.parse(taskId));
    if (existingTask == null) return;
    await database.write(() async {
      existingTask.applyPartial(partialTask);
    });
  }

  @override
  Future<Task?> getById(
    String taskId,
  ) async {
    final task = database.find<RealmTask>(int.parse(taskId));
    if (task == null) return null;
    return task.toTask();
  }

  @override
  Stream<List<Task>> watchPaginated({
    required int offset,
    required int limit,
    required TasksStatusFilter statusFilter,
    String? searchTerm,
  }) {
    final queryExpression = (
      statusFilter: statusFilter,
      nullableSearchTerm: searchTerm,
    ).toQueryExpression();
    final filteredTasksQuery = switch (queryExpression) {
      String() => database.query<RealmTask>(
          '$queryExpression SORT(createdAt DESC)',
        ),
      null => database.query<RealmTask>(
          // cspell:disable-next-line
          'TRUEPREDICATE SORT(createdAt DESC)',
        ),
    };
    return filteredTasksQuery.changes
        .asBroadcastStream()
        .map((changes) => changes.results.skip(offset).take(limit))
        .map(tasksFromRealmTasks);
  }

  @override
  Stream<int> watchCount({
    required TasksStatusFilter statusFilter,
    String? searchTerm,
  }) {
    final queryExpression = (
      statusFilter: statusFilter,
      nullableSearchTerm: searchTerm,
    ).toQueryExpression();
    final allTasksQuery = database.all<RealmTask>();
    final filteredTasksQuery = queryExpression == null
        ? allTasksQuery
        : allTasksQuery.query(queryExpression);
    return filteredTasksQuery.changes.map((changes) => changes.results.length);
  }
}

/// An extension on [NewTask] to add serialization capabilities.
@visibleForTesting
extension SerializableRealmNewTask on NewTask {
  /// Converts a [NewTask] to an [RealmTask].
  RealmTask toRealmTask(int id) {
    return RealmTask(
      id,
      title,
      isCompleted,
      DateTime.now(),
      description: description,
    );
  }
}

/// An extension on [Task] to add serialization capabilities.
@visibleForTesting
extension SerializableRealmTask on Task {
  /// Converts a [Task] to a [RealmTask].
  RealmTask toRealmTask() {
    return RealmTask(
      int.parse(id),
      title,
      isCompleted,
      createdAt,
      description: description,
    );
  }
}

/// An extension on [RealmTask] to add deserialization capabilities.
@visibleForTesting
extension DeserializableRealmTask on RealmTask {
  /// Converts an [RealmTask] to a [Task].
  Task toTask() {
    return Task(
      id: '$id',
      title: title,
      isCompleted: isCompleted,
      createdAt: createdAt,
      description: description,
    );
  }
}

/// An extension on [RealmTask] to add update utilities.
@visibleForTesting
extension UpdatableRealmTask on RealmTask {
  /// Applies the [partialTask] to the current [RealmTask].
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

extension on PartialTask {
  String? toQueryExpression() {
    final PartialTask(
      title: titleSetter,
      isCompleted: isCompletedSetter,
      description: descriptionSetter,
    ) = this;
    final queryBuffer = StringBuffer();
    if (titleSetter != null) {
      if (queryBuffer.isNotEmpty) queryBuffer.write(' AND ');
      final sanitizedTitle = titleSetter().trim();
      queryBuffer.write('title CONTAINS "$sanitizedTitle"');
    }
    if (isCompletedSetter != null) {
      if (queryBuffer.isNotEmpty) queryBuffer.write(' AND ');
      final isCompleted = isCompletedSetter() ? 'true' : 'false';
      queryBuffer.write('isCompleted == $isCompleted');
    }
    if (descriptionSetter != null) {
      if (queryBuffer.isNotEmpty) queryBuffer.write(' AND ');
      final description = descriptionSetter();
      if (description == null) {
        queryBuffer.write('description == null');
      } else {
        final sanitizedDescription = description.trim();
        queryBuffer.write('description CONTAINS "$sanitizedDescription"');
      }
    }
    final queryExpression = queryBuffer.toString().trim();
    return queryExpression.isEmpty ? null : queryExpression;
  }
}

/// A record that holds the filtering items for a tasks query.
typedef FilteringItems = ({
  TasksStatusFilter statusFilter,
  String? nullableSearchTerm,
});

extension on FilteringItems {
  String? toQueryExpression() {
    final queryBuffer = StringBuffer();
    switch (statusFilter) {
      case TasksStatusFilter.all:
        break;
      case TasksStatusFilter.completed:
        queryBuffer.write('isCompleted == true');
      case TasksStatusFilter.uncompleted:
        queryBuffer.write('isCompleted == false');
    }
    final nullableSearchTerm = this.nullableSearchTerm;
    if (nullableSearchTerm != null && nullableSearchTerm.isNotEmpty) {
      final sanitizedTerm = nullableSearchTerm.trim();
      final hasPreviousQuery = queryBuffer.isNotEmpty;
      if (hasPreviousQuery) queryBuffer.write(' AND (');
      queryBuffer
        ..write('title CONTAINS "$sanitizedTerm"')
        ..write(' OR ')
        ..write('description CONTAINS "$sanitizedTerm"');
      if (hasPreviousQuery) queryBuffer.write(')');
    }
    final queryExpression = queryBuffer.toString().trim();
    return queryExpression.isEmpty ? null : queryExpression;
  }
}

/// Converts a list of [RealmTask]s to a list of [Task]s.
@visibleForTesting
List<Task> tasksFromRealmTasks(Iterable<RealmTask> realmTasks) {
  return [for (final realmTask in realmTasks) realmTask.toTask()];
}
