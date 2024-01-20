import 'package:altoke_app/external/external.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  test(
    '''

GIVEN a scoped Sembast DB pod
WHEN the pod is invoked
THEN the pod should throw an error

''',
    () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      void action() => container.read(sembastDbPod);
      expect(
        action,
        throwsA(
          isA<UnimplementedError>().having(
            (error) => error.message,
            'message',
            '`sembastDbPod` was not initialized.',
          ),
        ),
      );
    },
  );

  test(
    '''

GIVEN a migration handler
WHEN it is run
THEN no action should be performed
''',
    () async {
      final database = MockSembastDatabase();
      await runSembastMigrations(
        database: database,
        oldVersion: 3,
        newVersion: 7,
        isDebugMode: false,
      );
      verifyNoMoreInteractions(database);
    },
  );
}
