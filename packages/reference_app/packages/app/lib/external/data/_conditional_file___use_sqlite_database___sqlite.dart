import 'dart:developer';

import 'package:altoke_app/external/data/_conditional_file___use_sqlite_database___sqlite.drift.dart';
import 'package:altoke_app/external/external.dart';
import 'package:drift/drift.dart';
import 'package:meta/meta.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tasks_sqlite_storage/tasks_sqlite_storage.dart';

part '_conditional_file___use_sqlite_database___sqlite.g.dart';

@DriftDatabase(
  include: {
    'package:tasks_sqlite_storage/tasks.drift',
  },
)
class SqliteDatabase extends $SqliteDatabase {
  SqliteDatabase({
    required QueryExecutor openConnection,
    this.migrationStrategy,
  }) : super(openConnection);

  @override
  int get schemaVersion => 1;

  @visibleForTesting
  final MigrationStrategy? migrationStrategy;

  @override
  MigrationStrategy get migration => migrationStrategy ?? super.migration;
}

@Riverpod(dependencies: [])
SqliteDatabase sqliteDb(SqliteDbRef ref) {
  throw UnimplementedError(
    '`${sqliteDbPod.name}` was not initialized.',
  );
}

Future<void> runSqliteMigrations({
  required Migrator migrator,
  required int oldVersion,
  required int newVersion,
  required bool isDebugMode,
}) async {
  // Migration logic v
  if (isDebugMode) {
    // coverage:ignore-start
    log(
      'SQLite migration: '
      'oldVersion: $oldVersion => newVersion: $newVersion',
    );
    final database = migrator.database as SqliteDatabase;
    final tasksTable = database.tasks;
    await database.transaction<void>(
      () async {
        final existingTasksCount = await tasksTable.count().getSingle();
        if (existingTasksCount > 0) return;
        await database.batch((batch) {
          return batch.insertAll(
            tasksTable,
            {
              for (final task in rawFakeTasks)
                DriftTasksCompanion.insert(
                  title: task['title'] as String,
                  isCompleted: Value(task['isCompleted'] as bool),
                  createdAt: Value(
                    DateTime.parse(task['createdAt'] as String)
                        .microsecondsSinceEpoch,
                  ),
                  description: Value(task['description'] as String?),
                ),
            },
          );
        });
      },
    );
    // coverage:ignore-end
  }
  // Migration logic ^
}
