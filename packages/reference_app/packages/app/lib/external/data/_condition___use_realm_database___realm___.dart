import 'dart:developer';

import 'package:altoke_app/external/external.dart';
import 'package:realm/realm.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tasks_realm_storage/tasks_realm_storage.dart';

part '_condition___use_realm_database___realm___.g.dart';

@Riverpod(dependencies: [])
Realm realmDb(RealmDbRef ref) {
  throw UnimplementedError(
    '`${realmDbPod.name}` was not initialized.',
  );
}

Future<void> runRealmMigrations({
  required Migration migration,
  required int oldVersion,
  required int newVersion,
  required bool isDebugMode,
}) async {
  // Migration logic v
  if (isDebugMode) {
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
