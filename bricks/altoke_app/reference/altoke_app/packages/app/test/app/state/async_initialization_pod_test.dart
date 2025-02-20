import 'dart:io';

import 'package:altoke_app/app/app.dart';
/*remove-start*/
import 'package:altoke_app/external/external.dart';
import 'package:drift_local_database/drift_local_database.dart';
/*remove-end*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
/*remove-start*/
import 'package:isar/isar.dart';

import '../../helpers/helpers.dart';
/*remove-end*/

void main() {
  test(
    '''

GIVEN an async initializer sequence
WHEN the async initializer sequence is run
THEN the async initializer sequence should complete
''',
    () async {
      final container = ProviderContainer(
        /*remove-start*/
        overrides: [
          asyncApplicationDocumentsDirectoryPod.overrideWith((ref) async {
            final dir = await Directory.systemTemp.createTemp();
            ref.onDispose(dir.delete);
            return dir;
          }),
          asyncDriftLocalDatabasePod.overrideWith(
            (ref) async => MockLocalDatabase(),
          ),
          asyncHiveInitializationPod.overrideWith((ref) async {}),
          asyncIsarPod.overrideWith((ref) async => MockIsar()),
        ],
        /*remove-end*/
      );
      addTearDown(container.dispose);
      final subscription = container.listen(
        asyncInitializationPod.future,
        (_, __) {},
      );
      addTearDown(subscription.close);
      final future = container.read(asyncInitializationPod.future);
      await expectLater(future, completes);
      /*remove-start*/
      final applicationDocumentsDirectory = container.read(
        asyncApplicationDocumentsDirectoryPod.future,
      );
      await expectLater(
        applicationDocumentsDirectory,
        completion(isA<Directory>()),
      );
      final driftLocalDatabase = container.read(
        asyncDriftLocalDatabasePod.future,
      );
      await expectLater(driftLocalDatabase, completion(isA<LocalDatabase>()));
      final hiveInitialization = container.read(
        asyncHiveInitializationPod.future,
      );
      await expectLater(hiveInitialization, completes);
      final isar = container.read(asyncIsarPod.future);
      await expectLater(isar, completion(isA<Isar>()));
      /*remove-end*/
    },
  );
}
