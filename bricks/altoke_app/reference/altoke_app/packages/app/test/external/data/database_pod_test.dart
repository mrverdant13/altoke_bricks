import 'dart:io';

import 'package:altoke_app/external/external.dart';
import 'package:drift_local_database/drift_local_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;

void main() {
  test(
    '''

GIVEN an async pod for a local Drift database
WHEN it is invoked
THEN it should return a LocalDatabase
''',
    () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      final tempSysDir = await Directory.systemTemp.createTemp();
      addTearDown(() => tempSysDir.delete(recursive: true));
      final appDocsDir = path.join(tempSysDir.path, 'app_docs');
      final tempDir = path.join(tempSysDir.path, 'temp');
      final container = ProviderContainer(
        overrides: [
          asyncApplicationDocumentsDirectoryPod.overrideWith(
            (ref) async => Directory(appDocsDir),
          ),
          asyncTemporaryDirectoryPod.overrideWith(
            (ref) async => Directory(tempDir),
          ),
        ],
      );
      addTearDown(container.dispose);
      final asyncDriftLocalDatabase = container.read(
        asyncDriftLocalDatabasePod.future,
      );
      await expectLater(
        asyncDriftLocalDatabase,
        completion(isA<LocalDatabase>()),
      );
    },
  );

  test(
    '''

GIVEN an async pod for a Hive initialization
WHEN it is invoked
THEN it should complete without issues
''',
    () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      final fakeDir = await Directory.systemTemp.createTemp();
      addTearDown(() async => fakeDir.delete(recursive: true));
      final container = ProviderContainer(
        overrides: [
          asyncApplicationDocumentsDirectoryPod.overrideWith(
            (ref) async => fakeDir,
          ),
        ],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(
        asyncHiveInitializationPod.future,
        (_, _) {},
      );
      addTearDown(subscription.close);
      final asyncHiveInitialization = subscription.read();
      await expectLater(asyncHiveInitialization, completes);
    },
  );
}
