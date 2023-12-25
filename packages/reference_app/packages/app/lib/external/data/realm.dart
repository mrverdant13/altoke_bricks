import 'dart:developer';

import 'package:altoke_app/external/external.dart';
import 'package:flutter/foundation.dart';
import 'package:realm/realm.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tasks_realm_storage/tasks_realm_storage.dart';

part 'realm.g.dart';

@Riverpod(dependencies: [])
Realm realmDb(RealmDbRef ref) {
  throw UnimplementedError(
    '`realmDbPod` was not initialized.',
  );
}

Future<void> runRealmMigrations({
  required Migration migration,
  required int oldVersion,
  required int newVersion,
}) async {
  // Migration logic v
  if (kDebugMode) {
    // coverage:ignore-start
    log(
      'Realm migration: '
      'oldVersion: $oldVersion => newVersion: $newVersion',
    );
    final database = migration.newRealm;
    final existingTasksCount = database.all<RealmTask>().length;
    if (existingTasksCount > 0) return;
    for (final (index, fakeTask) in rawFakeTasks.indexed) {
      database.add<RealmTask>(
        RealmTask(
          index,
          fakeTask['title'] as String,
          fakeTask['isCompleted'] as bool,
          DateTime.parse(fakeTask['createdAt'] as String),
          description: fakeTask['description'] as String?,
        ),
      );
    }
    // coverage:ignore-end
  }
  // Migration logic ^
}
