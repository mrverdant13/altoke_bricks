import 'dart:ffi';
import 'dart:io';

import 'package:altoke_app/external/external.dart';
import 'package:drift_local_database/drift_local_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:path/path.dart' as path;

extension on Abi {
  String get localName {
    switch (this) {
      case Abi.macosArm64 || Abi.macosX64:
        // cspell: disable-next-line
        return 'libisar.dylib';
      case Abi.linuxX64:
        // cspell: disable-next-line
        return 'libisar.so';
      case Abi.windowsArm64 || Abi.windowsX64:
        return 'isar.dll';
      default:
        throw UnsupportedError(
          'Unsupported processor architecture "$this" for tests',
        );
    }
  }
}

void main() {
  setUpAll(
    () async {
      // This step is a workaround to avoid issues affecting test suits.
      // See: https://github.com/isar/isar/issues/1518
      final isarLibDir = Directory.systemTemp.createTempSync('isar-test-lib-');
      final abi = Abi.current();
      await Isar.initializeIsarCore(
        download: true,
        libraries: {
          abi: '${isarLibDir.path}${Platform.pathSeparator}${abi.localName}',
        },
      );
    },
  );

  test('''

GIVEN an async pod for a local Drift database
WHEN it is invoked
THEN it should return a LocalDatabase
''', () async {
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
    final asyncDriftLocalDatabase =
        container.read(asyncDriftLocalDatabasePod.future);
    await expectLater(
      asyncDriftLocalDatabase,
      completion(isA<LocalDatabase>()),
    );
  });

  test('''

GIVEN an async pod for a Hive initialization
WHEN it is invoked
THEN it should complete without issues
''', () async {
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
    final subscription =
        container.listen(asyncHiveInitializationPod.future, (_, __) {});
    addTearDown(subscription.close);
    final asyncHiveInitialization = subscription.read();
    await expectLater(asyncHiveInitialization, completes);
  });

  test('''

GIVEN an async pod for an Isar database
WHEN it is invoked
THEN it should return an Isar instance
''', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final fakeDir = await Directory.systemTemp.createTemp();
    addTearDown(() => fakeDir.delete(recursive: true));
    final container = ProviderContainer(
      overrides: [
        asyncApplicationDocumentsDirectoryPod.overrideWith(
          (ref) async => fakeDir,
        ),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(asyncIsarPod.future, (_, __) {});
    addTearDown(subscription.close);
    final asyncIsar = subscription.read();
    await expectLater(asyncIsar, completion(isA<Isar>()));
  });
}
