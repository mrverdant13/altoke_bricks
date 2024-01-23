/*{{^use_hive_database}}*/
import 'package:altoke_app/external/external.dart' /*remove-start*/
    show
        DatabasePackage,
        databasePod,
        realmDbPod,
        sembastDbPod /*remove-end*/;
/*{{/use_hive_database}}*/
import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tasks_storage/tasks_storage.dart';

import '../../helpers/helpers.dart';

void main() {
  /*w 1v w*/
  /*{{#use_hive_database}}*/
  test(
    '''

GIVEN an injected tasks storage
AND an injected tasks Hive box
WHEN the pod is read
THEN the pod should return the storage
''',
    () async {
      final container = ProviderContainer(
        overrides: [
          /*remove-start*/
          databasePod.overrideWithValue(
            DatabasePackage.hive,
          ),
          /*remove-end*/
          tasksBoxPod.overrideWithValue(
            FakeTasksBox(),
          ),
        ],
      );
      addTearDown(container.dispose);
      final storage = container.read(tasksStoragePod);
      expect(
        storage,
        isA<TasksStorage>(),
      );
    },
  );
  /*{{/use_hive_database}}*/

  /*{{#use_realm_database}}*/
  test(
    '''

GIVEN an injected tasks storage
AND an injected Realm database
WHEN the pod is read
THEN the pod should return the storage
''',
    () async {
      final container = ProviderContainer(
        overrides: [
          /*remove-start*/
          databasePod.overrideWithValue(
            DatabasePackage.realm,
          ),
          /*remove-end*/
          realmDbPod.overrideWithValue(
            FakeRealm(),
          ),
        ],
      );
      addTearDown(container.dispose);
      final storage = container.read(tasksStoragePod);
      expect(
        storage,
        isA<TasksStorage>(),
      );
    },
  );
  /*{{/use_realm_database}}*/

  /*{{#use_sembast_database}}*/
  test(
    '''

GIVEN an injected tasks storage
AND an injected Sembast database
WHEN the pod is read
THEN the pod should return the storage
''',
    () async {
      final container = ProviderContainer(
        overrides: [
          /*remove-start*/
          databasePod.overrideWithValue(
            DatabasePackage.sembast,
          ),
          /*remove-end*/
          sembastDbPod.overrideWithValue(
            FakeSembastDatabase(),
          ),
        ],
      );
      addTearDown(container.dispose);
      final storage = container.read(tasksStoragePod);
      expect(
        storage,
        isA<TasksStorage>(),
      );
    },
  );
  /*{{/use_sembast_database}}*/

  /*w 1v w*/
}
