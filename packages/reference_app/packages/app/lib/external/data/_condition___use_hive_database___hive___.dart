import 'dart:developer';

import 'package:altoke_app/external/external.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:tasks_hive_storage/tasks_hive_storage.dart';

Future<void> runHiveMigrations({
  required int newVersion,
}) async {
  final metadataBox = await Hive.openBox<Object>('.hive-metadata.');
  final oldVersion = metadataBox.get('version');
  // Migration logic v
  if (kDebugMode) {
    // coverage:ignore-start
    log(
      'Hive migration: '
      'oldVersion: $oldVersion => newVersion: $newVersion',
    );
    final tasksBox =
        await Hive.openBox<Map<dynamic, dynamic>>(TasksHiveStorage.boxName);
    final existingTasksCount = tasksBox.length;
    if (existingTasksCount > 0) return;
    await tasksBox.addAll(rawFakeTasks);
    // coverage:ignore-end
  }
  // Migration logic ^
  await metadataBox.put('version', newVersion);
}