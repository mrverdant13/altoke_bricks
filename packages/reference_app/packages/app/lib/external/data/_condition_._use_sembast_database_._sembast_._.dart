import 'dart:developer';

import 'package:altoke_app/external/external.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sembast/sembast.dart';
import 'package:tasks_sembast_storage/tasks_sembast_storage.dart';

part '_condition_._use_sembast_database_._sembast_._.g.dart';

@Riverpod(dependencies: [])
Database sembastDb(SembastDbRef ref) {
  throw UnimplementedError(
    '`sembastDbPod` was not initialized.',
  );
}

Future<void> runSembastMigrations(
  Database database,
  int oldVersion,
  int newVersion,
) async {
  // Migration logic v
  if (kDebugMode) {
    // coverage:ignore-start
    log(
      'Sembast migration: '
      'oldVersion: $oldVersion => newVersion: $newVersion',
    );
    await database.performRawMigration(
      rawMigration: ({required tasksStore}) async {
        final existingTasksCount = await tasksStore.count(database);
        if (existingTasksCount > 0) return;
        await tasksStore.addAll(
          database,
          [...rawFakeTasks],
        );
      },
    );
    // coverage:ignore-end
  }
  // Migration logic ^
}
