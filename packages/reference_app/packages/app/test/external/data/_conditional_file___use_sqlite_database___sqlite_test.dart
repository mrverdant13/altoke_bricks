import 'package:altoke_app/external/external.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  test(
    '''

GIVEN a scoped SQlite DB pod
WHEN the pod is invoked
THEN the pod should throw an error

''',
    () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      void action() => container.read(sqliteDbPod);
      expect(
        action,
        throwsA(
          isA<UnimplementedError>().having(
            (error) => error.message,
            'message',
            '`sqliteDbPod` was not initialized.',
          ),
        ),
      );
    },
  );

  test('''

GIVEN a SQLite database constructor
AND a migration strategy
WHEN it is invoked
THEN the SQLite database should be created
AND the schema version should be 1
AND the migration strategy should be the provided one
''', () {
    final migrationStrategy = MigrationStrategy();
    final database = SqliteDatabase(
      openConnection: NativeDatabase.memory(),
      migrationStrategy: migrationStrategy,
    );
    expect(database.schemaVersion, 1);
    expect(database.migration, migrationStrategy);
  });

  test(
    '''

GIVEN a migration handler
WHEN it is run
THEN no action should be performed
''',
    () async {
      final migrator = MockSqliteMigrator();
      await runSqliteMigrations(
        migrator: migrator,
        oldVersion: 3,
        newVersion: 7,
        isDebugMode: false,
      );
      verifyNoMoreInteractions(migrator);
    },
  );
}
