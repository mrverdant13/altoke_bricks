/*remove-start*/
import 'dart:io';

/*remove-end-x*/
import 'package:altoke_app/app/app.dart';
/*remove-start*/
import 'package:altoke_app/external/external.dart';
import 'package:drift_local_database/drift_local_database.dart';
/*remove-end-x*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/*x-remove-start*/

import '../../helpers/helpers.dart';
/*remove-end*/

@Dependencies([
  asyncInitialization,
  /*x-remove-start*/
  asyncApplicationDocumentsDirectory,
  asyncDriftLocalDatabase,
  asyncHiveInitialization,
  /*remove-end*/
])
void main() {
  test(
    '''

GIVEN an async initializer sequence
WHEN the async initializer sequence is run
THEN the async initializer sequence should complete
''',
    () async {
      final container = ProviderContainer(
        /*x-remove-start*/
        overrides: [
          asyncApplicationDocumentsDirectoryPod.overrideWith((ref) async {
            final dir = await Directory.systemTemp.createTemp();
            ref.onDispose(dir.delete);
            return dir;
          }),
          asyncTemporaryDirectoryPod.overrideWith((ref) async {
            final dir = await Directory.systemTemp.createTemp();
            ref.onDispose(dir.delete);
            return dir;
          }),
          asyncDriftLocalDatabasePod.overrideWith(
            (ref) async => MockLocalDatabase(),
          ),
          asyncHiveInitializationPod.overrideWith((ref) async {}),
        ],
        /*remove-end-x*/
      );
      addTearDown(container.dispose);
      final subscription = container.listen(
        asyncInitializationPod.future,
        (_, _) {},
      );
      addTearDown(subscription.close);
      final future = container.read(asyncInitializationPod.future);
      await expectLater(future, completes);
      /*x-remove-start*/
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
      /*remove-end*/
    },
  );
}
