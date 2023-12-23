import 'package:common/common.dart';
import 'package:meta/meta.dart';
import 'package:sembast/sembast.dart';
import 'package:tasks/tasks.dart';
import 'package:tasks_storage/tasks_storage.dart';

/// {@template tasks_sembast_storage}
/// A persistent [TasksStorage] implementation using Sembast.
/// {@endtemplate}
class TasksSembastStorage implements TasksStorage {
  /// {@macro tasks_sembast_storage}
  TasksSembastStorage({
    required this.database,
  });

  /// Store name for the tasks.
  @visibleForTesting
  static const storeName = '<tasks-sembast-storage>';

  /// Store reference for the tasks.
  @visibleForTesting
  late final TasksStoreRef store = StoreRef(storeName);

  /// The Sembast database.
  @visibleForTesting
  final Database database;

  @override
  Future<void> create({
    required NewTask newTask,
  }) async {
    if (newTask.title.isEmpty) throw const CreateTaskFailureEmptyTitle();
    await store.add(database, newTask.toSembastJson());
  }

  @override
  Future<Task?> delete({
    required int taskId,
  }) async {
    final taskSnapshot = await store.record(taskId).getSnapshot(database);
    if (taskSnapshot == null) return null;
    await store.record(taskId).delete(database);
    return taskSnapshot.toTask();
  }

  @override
  Future<void> deleteAll({
    PartialTask? referenceTask,
  }) async {
    referenceTask ??= const PartialTask();
    final PartialTask(:title, :isCompleted, :description) = referenceTask;
    final titleFilter = switch (title) {
      null => null,
      _ => Filter.matches(
          SembastTask.titleFieldJsonKey,
          title().trim(),
        ),
    };
    final isCompletedFilter = switch (isCompleted) {
      null => null,
      _ => Filter.equals(
          SembastTask.statusFieldJsonKey,
          isCompleted(),
        ),
    };
    final descriptionFilter = switch (description) {
      null => null,
      _ => switch (description()) {
          null => Filter.isNull(
              SembastTask.descriptionFieldJsonKey,
            ),
          final description => Filter.matches(
              SembastTask.descriptionFieldJsonKey,
              description.trim(),
            ),
        },
    };
    final dbFilter = Filter.and([
      if (titleFilter != null) titleFilter,
      if (isCompletedFilter != null) isCompletedFilter,
      if (descriptionFilter != null) descriptionFilter,
    ]);
    final dbFinder = Finder(filter: dbFilter);
    await store.delete(database, finder: dbFinder);
  }

  @override
  Future<void> insert({
    required Task task,
  }) async {
    await store.record(task.id).put(database, task.toSembastJson());
  }

  @override
  Future<void> markAllAsCompleted() async {
    await store.update(database, {SembastTask.statusFieldJsonKey: true});
  }

  @override
  Future<void> update({
    required int taskId,
    required PartialTask partialTask,
  }) async {
    if (partialTask case PartialTask(:final title?) when title().isEmpty) {
      throw const UpdateTaskFailureEmptyTitle();
    }
    await store.record(taskId).update(database, partialTask.toJson());
  }

  @override
  Future<Task?> getById(
    int taskId,
  ) async {
    final taskSnapshot = await store.record(taskId).getSnapshot(database);
    return taskSnapshot?.toTask();
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
    ).toSembastFilter();
    final dbFinder = Finder(
      filter: dbFilter,
      offset: offset,
      limit: limit,
      sortOrders: [
        SortOrder(
          SembastTask.createdAtFieldJsonKey,
          false,
        ),
      ],
    );
    return store
        .query(finder: dbFinder)
        .onSnapshots(database)
        .map(tasksFromSnapshots);
  }

  @override
  Stream<int> watchCount({
    required TasksStatusFilter statusFilter,
    String? searchTerm,
  }) {
    final dbFilter = (
      statusFilter: statusFilter,
      nullableSearchTerm: searchTerm,
    ).toSembastFilter();
    final dbFinder = Finder(filter: dbFilter);
    return store.query(finder: dbFinder).onCount(database);
  }
}

/// A reference to a raw tasks store.
typedef TasksStoreRef = StoreRef<int, Json>;

/// Abstract class that holds the field keys for the [Json] representation of
/// the different variants of a task.
abstract final class SembastTask {
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
extension SerializableSembastNewTask on NewTask {
  /// Converts a [NewTask] to a [Json].
  Json toSembastJson() {
    return {
      SembastTask.titleFieldJsonKey: title,
      SembastTask.statusFieldJsonKey: isCompleted,
      SembastTask.descriptionFieldJsonKey: description,
      SembastTask.createdAtFieldJsonKey: DateTime.now().toIso8601String(),
    };
  }
}

/// An extension on [Task] to add serialization capabilities.
@visibleForTesting
extension SerializableSembastTask on Task {
  /// Converts a [Task] to a [Json].
  Json toSembastJson() {
    return {
      SembastTask.titleFieldJsonKey: title,
      SembastTask.statusFieldJsonKey: isCompleted,
      SembastTask.descriptionFieldJsonKey: description,
      SembastTask.createdAtFieldJsonKey: createdAt.toIso8601String(),
    };
  }
}

extension on Json {
  Task toTask() {
    return Task(
      id: this[SembastTask.idFieldJsonKey] as int,
      title: this[SembastTask.titleFieldJsonKey] as String,
      isCompleted: this[SembastTask.statusFieldJsonKey] as bool,
      createdAt: DateTime.parse(
        this[SembastTask.createdAtFieldJsonKey] as String,
      ),
      description: this[SembastTask.descriptionFieldJsonKey] as String?,
    );
  }
}

extension on PartialTask {
  Json toJson() {
    final titleSetter = title;
    final isCompletedSetter = isCompleted;
    final descriptionSetter = description;
    return {
      if (titleSetter != null) SembastTask.titleFieldJsonKey: titleSetter(),
      if (isCompletedSetter != null)
        SembastTask.statusFieldJsonKey: isCompletedSetter(),
      if (descriptionSetter != null)
        SembastTask.descriptionFieldJsonKey: descriptionSetter(),
    };
  }
}

extension on TasksStatusFilter {
  Filter? toSembastFilter() {
    return switch (this) {
      TasksStatusFilter.all => null,
      TasksStatusFilter.uncompleted => Filter.equals(
          SembastTask.statusFieldJsonKey,
          false,
        ),
      TasksStatusFilter.completed => Filter.equals(
          SembastTask.statusFieldJsonKey,
          true,
        ),
    };
  }
}

/// Converts a [nullableSearchTerm] to a [Filter].
@visibleForTesting
Filter? searchTermToSembastFilter(String? nullableSearchTerm) {
  return switch (nullableSearchTerm?.trim()) {
    null => null,
    String(:final isEmpty) when isEmpty => null,
    final searchTerm => Filter.or([
        Filter.matches(
          SembastTask.titleFieldJsonKey,
          searchTerm.trim(),
        ),
        Filter.matches(
          SembastTask.descriptionFieldJsonKey,
          searchTerm.trim(),
        ),
      ]),
  };
}

/// A record that holds the filtering items for a tasks query.
typedef FilteringItems = ({
  TasksStatusFilter statusFilter,
  String? nullableSearchTerm,
});

extension on FilteringItems {
  Filter? toSembastFilter() {
    final dbStatusFilter = statusFilter.toSembastFilter();
    final dbSearchFilter = searchTermToSembastFilter(nullableSearchTerm);
    return Filter.and([
      if (dbStatusFilter != null) dbStatusFilter,
      if (dbSearchFilter != null) dbSearchFilter,
    ]);
  }
}

/// An extension on [TaskSnapshot] to add deserialization capabilities.
@visibleForTesting
extension DeserializableTaskSnapshot on TaskSnapshot {
  /// Converts a [TaskSnapshot] to a [Task].
  Task toTask() {
    return <String, dynamic>{
      SembastTask.idFieldJsonKey: key,
      ...value,
    }.toTask();
  }
}

/// Converts a list of [TaskSnapshot]s to a list of [Task]s.
@visibleForTesting
List<Task> tasksFromSnapshots(List<TaskSnapshot> snapshots) {
  return [for (final snapshot in snapshots) snapshot.toTask()];
}

/// A snapshot that represents a task.
typedef TaskSnapshot = RecordSnapshot<int, Json>;

/// The signature of a migration callback that can unsafely access the
/// [tasksStore].
typedef MigrationCallback<O> = Future<O> Function({
  required TasksStoreRef tasksStore,
});

/// An extension on [Database] that exposes migration capabilities.
extension MigratingDatabase on Database {
  /// Performs a raw migration.
  ///
  /// **NOTE:** The [rawMigration] callback can access an inner tasks store,
  /// which can be used to perform **UNSAFE** operations.
  Future<O> performRawMigration<O>({
    required MigrationCallback<O> rawMigration,
  }) async {
    return rawMigration(
      tasksStore: TasksStoreRef(TasksSembastStorage.storeName),
    );
  }
}
