import 'dart:io';

import 'package:altoke_app/external/external.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

void main() {
  test(
    '''

GIVEN a migration handler
WHEN it is run
THEN the new version should be persisted
AND no further action should be performed
''',
    () async {
      final dbDir = Directory.systemTemp.createTempSync();
      Hive.init(dbDir.path);
      final box = await Hive.openBox<Object>('.hive-metadata.');
      await box.put('version', 3);
      final existingVersion = box.get('version');
      expect(existingVersion, 3);
      await runHiveMigrations(
        newVersion: 7,
        isDebugMode: false,
      );
      final newVersion = box.get('version');
      expect(newVersion, 7);
      await box.close();
      await Hive.close();
      await dbDir.delete(recursive: true);
    },
  );
}
