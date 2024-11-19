import 'dart:io';

import 'package:altoke_app/external/external.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:drift_local_database/drift_local_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:isar/isar.dart';
import 'package:isar_local_database/isar_local_database.dart';
import 'package:path/path.dart' as path;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database_pod.g.dart';

// coverage:ignore-start
@Riverpod(
  dependencies: [
    asyncApplicationDocumentsDirectory,
  ],
)
Future<LocalDatabase> asyncDriftLocalDatabase(Ref ref) async {
  const dbName = 'app_db';
  final databasePath = ref.watch(
    asyncApplicationDocumentsDirectoryPod.selectAsync(
      (dir) => path.joinAll([
        dir.path,
        'drift_database',
        '$dbName.sqlite',
      ]),
    ),
  );
  final db = LocalDatabase(
    schemaVersion: 1,
    queryExecutor: driftDatabase(
      name: dbName,
      native: DriftNativeOptions(
        databasePath: () async => databasePath,
      ),
    ),
  );
  ref.onDispose(db.close);
  return db;
}

@Riverpod(
  dependencies: [
    asyncApplicationDocumentsDirectory,
  ],
)
Future<void> asyncHiveInitialization(Ref ref) async {
  if (!kIsWeb) {
    const dbName = 'app_db';
    final databasePath = ref.watch(
      asyncApplicationDocumentsDirectoryPod.select(
        (asyncDir) => path.joinAll([
          asyncDir.requireValue.path,
          'hive_database',
          dbName,
        ]),
      ),
    );
    final databaseDir = Directory(databasePath);
    if (!databaseDir.existsSync()) {
      await databaseDir.create(recursive: true);
    }
    Hive.init(databasePath);
  }
}

@Riverpod(
  dependencies: [
    asyncApplicationDocumentsDirectory,
  ],
)
Future<Isar> asyncIsar(Ref ref) async {
  const dbName = 'app_db';
  final databasePath = ref.watch(
    asyncApplicationDocumentsDirectoryPod.select(
      (asyncDir) => path.joinAll([
        asyncDir.requireValue.path,
        'isar_database',
        dbName,
      ]),
    ),
  );
  final databaseDir = Directory(databasePath);
  if (!databaseDir.existsSync()) {
    await databaseDir.create(recursive: true);
  }
  final isar = await Isar.open(
    name: dbName,
    localDatabaseSchemas,
    directory: databasePath,
  );
  ref.onDispose(isar.close);
  return isar;
}
// coverage:ignore-end

/*drop*/
// coverage:ignore-start
enum LocalDatabasePackage {
  drift('drift', 'Drift (SQLite)'),
  hive('hive', 'Hive'),
  isar('isar', 'Isar'),
  ;

  const LocalDatabasePackage(this.identifier, this.displayName);

  final String identifier;
  final String displayName;
}

@Riverpod(
  dependencies: [],
  keepAlive: true,
)
class SelectedLocalDatabasePackage extends _$SelectedLocalDatabasePackage {
  @override
  LocalDatabasePackage build() {
    return LocalDatabasePackage.values.first;
  }

  // ignore: avoid_setters_without_getters
  set value(LocalDatabasePackage value) => state = value;
}
// coverage:ignore-end
