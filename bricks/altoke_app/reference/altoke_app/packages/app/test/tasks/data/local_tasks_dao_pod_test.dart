import 'dart:io';

import 'package:altoke_app/external/external.dart';
import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_database/local_database.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  test('''

GIVEN a local tasks DAO pod
WHEN it is invoked
THEN a local tasks Drift DAO should be returned
''', () async {
    final localDatabase = MockLocalDatabase();
    final tasksDrift = MockTasksDrift();
    when(() => localDatabase.tasksDrift).thenReturn(tasksDrift);
    final container = ProviderContainer(
      overrides: [
        asyncDriftLocalDatabasePod.overrideWith(
          (ref) => localDatabase,
        ),
      ],
    );
    addTearDown(container.dispose);
    container.read(selectedLocalDatabasePackagePod.notifier).value =
        LocalDatabasePackage.drift;
    final dao = container.read(localTasksDaoPod);
    expect(dao, isA<LocalTasksDao>());
  });

  test('''

GIVEN a local tasks DAO pod
WHEN it is invoked
THEN a local tasks Hive DAO should be returned
''', () async {
    final dir = Directory.systemTemp.createTempSync();
    addTearDown(() => dir.deleteSync(recursive: true));
    final container = ProviderContainer(
      overrides: [
        asyncHiveInitializationPod.overrideWith(
          (ref) {},
        ),
      ],
    );
    addTearDown(container.dispose);
    container.read(selectedLocalDatabasePackagePod.notifier).value =
        LocalDatabasePackage.hive;
    final dao = container.read(localTasksDaoPod);
    expect(dao, isA<LocalTasksDao>());
  });

  test('''

GIVEN a local tasks DAO pod
WHEN it is invoked
THEN a local tasks Isar DAO should be returned
''', () async {
    final isar = MockIsar();
    final container = ProviderContainer(
      overrides: [
        asyncIsarPod.overrideWith(
          (ref) => isar,
        ),
      ],
    );
    addTearDown(container.dispose);
    container.read(selectedLocalDatabasePackagePod.notifier).value =
        LocalDatabasePackage.isar;
    final dao = container.read(localTasksDaoPod);
    expect(dao, isA<LocalTasksDao>());
  });
}
