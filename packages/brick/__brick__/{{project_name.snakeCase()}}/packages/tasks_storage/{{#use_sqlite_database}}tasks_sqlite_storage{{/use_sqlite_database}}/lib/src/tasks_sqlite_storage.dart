import 'package:drift/drift.dart';
import 'package:meta/meta.dart';
import 'package:tasks/tasks.dart';
import 'package:tasks_sqlite_storage/tasks_sqlite_storage.dart';
import 'package:tasks_storage/tasks_storage.dart';

/// {@template tasks_sqlite_storage}
/// A persistent [TasksStorage] implementation using SQLite.
/// {@endtemplate}
class TasksSqliteStorage implements TasksStorage {
  /// {@macro tasks_sqlite_storage}
  TasksSqliteStorage({
    required this.tasksDao,
  });

  /// The tasks DAO.
  @visibleForTesting
  late final DriftTasksDao tasksDao;

  /// The tasks table.
  DriftTasksTable get tasksTable => tasksDao.tasks;

  @override
  Future<void> create({
    required NewTask newTask,
  }) async {
    final NewTask(
      title: title,
      isCompleted: isCompleted,
      description: description,
    ) = newTask;
    if (title.isEmpty) throw const CreateTaskFailureEmptyTitle();
    await tasksDao.add(title, description, isCompleted);
  }

  @override
  Future<Task?> delete({
    required int taskId,
  }) async {
    final rawTask = await tasksDao.getById(taskId).getSingleOrNull();
    if (rawTask == null) return null;
    await tasksDao.deleteById(taskId);
    return rawTask.toTask();
  }

  @override
  Future<void> deleteAll({
    PartialTask? referenceTask,
  }) async {
    if (referenceTask == null) {
      await tasksTable.deleteAll();
      return;
    }
    await tasksTable.deleteWhere(
      (tasks) => tasks.matchesPartial(referenceTask),
    );
  }

  @override
  Future<void> insert({
    required Task task,
  }) async {
    final Task(
      id: id,
      title: title,
      isCompleted: isCompleted,
      createdAt: createdAt,
      description: description,
    ) = task;
    await tasksDao.insert(
      id,
      title,
      isCompleted,
      createdAt.microsecondsSinceEpoch,
      description,
    );
  }

  @override
  Future<void> markAllAsCompleted() async {
    await tasksDao.markAllAsCompleted();
  }

  @override
  Future<void> update({
    required int taskId,
    required PartialTask partialTask,
  }) async {
    if (partialTask case PartialTask(:final title?) when title().isEmpty) {
      throw const UpdateTaskFailureEmptyTitle();
    }
    final PartialTask(
      title: partialTitle,
      isCompleted: partialIsCompleted,
      description: partialDescription,
    ) = partialTask;
    await (tasksTable.update()..where((tasks) => tasks.id.equals(taskId)))
        .write(
      DriftTasksCompanion(
        title: switch (partialTitle?.call()) {
          null => const Value.absent(),
          final title when title.isEmpty => const Value.absent(),
          final title => Value(title),
        },
        isCompleted: switch (partialIsCompleted?.call()) {
          null => const Value.absent(),
          final isCompleted => Value(isCompleted),
        },
        description: switch (partialDescription) {
          null => const Value.absent(),
          _ => switch (partialDescription()?.trim()) {
              null => const Value(null),
              final description when description.isEmpty => const Value(null),
              final description => Value(description),
            },
        },
      ),
    );
  }

  @override
  Future<Task?> getById(
    int taskId,
  ) async {
    final rawTask = await tasksDao.getById(taskId).getSingleOrNull();
    return rawTask?.toTask();
  }

  @override
  Stream<List<Task>> watchPaginated({
    required int offset,
    required int limit,
    required TasksStatusFilter statusFilter,
    String? searchTerm,
  }) {
    final query = tasksTable.select()
      ..where(
        (table) =>
            tasksTable.statusEqualsTo(statusFilter) &
            tasksTable.contentMatches(searchTerm),
      )
      ..orderBy(
        [
          (tasks) => OrderingTerm(
                expression: tasks.createdAt,
                mode: OrderingMode.desc,
              ),
        ],
      )
      ..limit(limit, offset: offset);

    bool tasksListsAreEqual(List<Task> previous, List<Task> next) {
      if (previous.length != next.length) return false;
      for (var i = 0; i < previous.length; i++) {
        if (previous[i] != next[i]) return false;
      }
      return true;
    }

    return query
        .watch()
        .map((rows) => rows.toTasks())
        .distinct(tasksListsAreEqual);
  }

  @override
  Stream<int> watchCount({
    required TasksStatusFilter statusFilter,
    String? searchTerm,
  }) {
    return tasksTable
        .count(
          where: (table) =>
              tasksTable.statusEqualsTo(statusFilter) &
              tasksTable.contentMatches(searchTerm),
        )
        .watchSingle();
  }
}

extension on DriftTasksTable {
  Expression<bool> statusEqualsTo(TasksStatusFilter filter) {
    return switch (filter) {
      TasksStatusFilter.all => const Constant(true),
      TasksStatusFilter.uncompleted => isCompleted.equals(false),
      TasksStatusFilter.completed => isCompleted.equals(true),
    };
  }

  Expression<bool> contentMatches(String? content) {
    return switch (content?.trim().toLowerCase()) {
      null => const Constant(true),
      String(:final isEmpty) when isEmpty => const Constant(true),
      final content => Expression.or({
          title.contains(content),
          description.contains(content),
        }),
    };
  }

  Expression<bool> matchesPartial(PartialTask partialTask) {
    final PartialTask(
      title: partialTitle,
      isCompleted: partialIsCompleted,
      description: partialDescription,
    ) = partialTask;
    return Expression.and({
      switch (partialTitle?.call().trim().toLowerCase()) {
        null => const Constant(true),
        String(:final isEmpty) when isEmpty => Expression.and({}),
        final title => this.title.contains(title),
      },
      switch (partialIsCompleted?.call()) {
        null => const Constant(true),
        final isCompleted => this.isCompleted.equals(isCompleted),
      },
      switch (partialDescription) {
        null => const Constant(true),
        _ => switch (partialDescription()?.trim().toLowerCase()) {
            null => description.isNull(),
            String(:final isEmpty) when isEmpty => const Constant(true),
            final description => this.description.contains(description),
          },
      },
    });
  }
}

/// An [Iterable] of [DriftTask]s.
typedef TasksIterable = Iterable<DriftTask>;

/// An extension on [DriftTask] to add deserialization capabilities.
@visibleForTesting
extension DeserializableDriftTask on DriftTask {
  /// Converts a [DriftTask] to a [Task].
  Task toTask() {
    return Task(
      id: id,
      title: title,
      isCompleted: isCompleted,
      createdAt: DateTime.fromMicrosecondsSinceEpoch(createdAt),
      description: description,
    );
  }
}

extension on TasksIterable {
  List<Task> toTasks() {
    return map((task) => task.toTask()).toList();
  }
}
