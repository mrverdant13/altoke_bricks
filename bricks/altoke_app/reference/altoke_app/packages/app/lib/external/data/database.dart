import 'dart:io';

import 'package:drift_flutter/drift_flutter.dart';
import 'package:drift_local_database/drift_local_database.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart' as p;

Future<LocalDatabase> buildLocalDatabase({
  required String? applicationDocumentsDirectoryPath,
  required String? temporaryDirectoryPath,
}) async {
  final nativeOptions = await () async {
    if (kIsWeb) return null;
    if (applicationDocumentsDirectoryPath == null) return null;
    if (temporaryDirectoryPath == null) return null;
    return DriftNativeOptions(
      databaseDirectory: () async => applicationDocumentsDirectoryPath,
      tempDirectoryPath: () async => temporaryDirectoryPath,
    );
  }();

  final webOptions = await () async {
    if (!kIsWeb) return null;
    return DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.js'),
    );
  }();

  return LocalDatabase(
    schemaVersion: 1,
    queryExecutor: driftDatabase(
      name: 'app_db',
      native: nativeOptions,
      web: webOptions,
    ),
  );
}

Future<void> initializeHive({
  required String? applicationDocumentsDirectoryPath,
}) async {
  if (kIsWeb) return;
  if (applicationDocumentsDirectoryPath == null) return;
  const dbName = 'app_db';
  final databasePath = p.joinAll([
    applicationDocumentsDirectoryPath,
    'hive_database',
    dbName,
  ]);
  final databaseDir = Directory(databasePath);
  if (!databaseDir.existsSync()) await databaseDir.create(recursive: true);
  Hive.init(databasePath);
}
