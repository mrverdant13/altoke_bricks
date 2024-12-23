import 'package:altoke_app/external/external.dart';
import 'package:drift_local_database/drift_local_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_local_database/hive_local_database.dart';
import 'package:isar_local_database/isar_local_database.dart';
import 'package:local_database/local_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_tasks_dao_pod.g.dart';

@Riverpod(
  dependencies: [
    SelectedLocalDatabasePackage,
    asyncDriftLocalDatabase,
    asyncHiveInitialization,
    asyncIsar,
  ],
)
LocalTasksDao localTasksDao(Ref ref) {
  final package = ref.watch(selectedLocalDatabasePackagePod);
  switch (package) {
    case LocalDatabasePackage.drift:
      return LocalTasksDriftDao(
        tasksDrift: ref.watch(
          asyncDriftLocalDatabasePod.select(
            (asyncDatabase) => asyncDatabase.requireValue.tasksDrift,
          ),
        ),
      );
    case LocalDatabasePackage.hive:
      ref.watch(
        asyncHiveInitializationPod.select(
          (asyncInitialization) => asyncInitialization.requireValue,
        ),
      );
      return LocalTasksHiveDao();
    case LocalDatabasePackage.isar:
      return LocalTasksIsarDao(
        database: ref.watch(
          asyncIsarPod.select(
            (asyncDatabase) => asyncDatabase.requireValue,
          ),
        ),
      );
  }
}
