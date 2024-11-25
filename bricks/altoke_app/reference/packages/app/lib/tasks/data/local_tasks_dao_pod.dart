import 'package:altoke_app/external/external.dart';
import 'package:drift_local_database/drift_local_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_local_database/hive_local_database.dart';
import 'package:isar_local_database/isar_local_database.dart';
import 'package:local_database/local_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_tasks_dao_pod.g.dart';

// coverage:ignore-start
@Riverpod(
  dependencies: [
    SelectedLocalDatabasePackage,
    asyncDriftLocalDatabase,
    asyncIsar,
  ],
)
LocalTasksDao localTasksDao(Ref ref) {
  final package = ref.watch(selectedLocalDatabasePackagePod);
  return switch (package) {
    LocalDatabasePackage.drift => LocalTasksDriftDao(
        tasksDrift: ref.watch(
          asyncDriftLocalDatabasePod.select(
            (asyncDatabase) => asyncDatabase.requireValue.tasksDrift,
          ),
        ),
      ),
    LocalDatabasePackage.hive => LocalTasksHiveDao(),
    LocalDatabasePackage.isar => LocalTasksIsarDao(
        database: ref.watch(
          asyncIsarPod.select(
            (asyncDatabase) => asyncDatabase.requireValue,
          ),
        ),
      ),
  };
}
// coverage:ignore-end
