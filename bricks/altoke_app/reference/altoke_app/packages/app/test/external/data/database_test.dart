import 'dart:io';

import 'package:altoke_app/external/external.dart';
import 'package:drift_local_database/drift_local_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

void main() {
  group('buildLocalDatabase', () {
    test('returns a $LocalDatabase', () async {
      final tempSysDir = await Directory.systemTemp.createTemp();
      addTearDown(() => tempSysDir.delete(recursive: true));
      final appDocsDir = p.join(tempSysDir.path, 'app_docs');
      final tempDir = p.join(tempSysDir.path, 'temp');
      final database = await buildLocalDatabase(
        applicationDocumentsDirectoryPath: appDocsDir,
        temporaryDirectoryPath: tempDir,
      );
      addTearDown(database.close);
      expect(database, isA<LocalDatabase>());
    });

    // TODO(mrverdant13): Add test to check database version
  });

  group('initializeHive', () {
    test('initializes Hive', () async {
      final tempSysDir = await Directory.systemTemp.createTemp();
      addTearDown(() => tempSysDir.delete(recursive: true));
      final appDocsDir = p.join(tempSysDir.path, 'app_docs');
      Future<void> action() => initializeHive(
        applicationDocumentsDirectoryPath: appDocsDir,
      );
      await expectLater(action(), completes);
    });
  });
}
