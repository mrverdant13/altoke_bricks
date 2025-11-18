import 'dart:io';

import 'package:altoke_app/app/app.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:drift_local_database/drift_local_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockLocalDatabase extends Mock implements LocalDatabase {}

void main() {
  group('$AppInitializationBloc', () {
    AppInitializationBloc buildSubjectBloc({
      required Future<Directory> Function() applicationDocumentsDirectoryGetter,
      required Future<Directory> Function() temporaryDirectoryGetter,
      required Future<LocalDatabase> Function({
        required String applicationDocumentsDirectoryPath,
        required String temporaryDirectoryPath,
      })
      localDatabaseBuilder,
      required Future<void> Function({
        required String applicationDocumentsDirectoryPath,
      })
      hiveInitializer,
    }) {
      return AppInitializationBloc(
        applicationDocumentsDirectoryGetter:
            applicationDocumentsDirectoryGetter,
        temporaryDirectoryGetter: temporaryDirectoryGetter,
        localDatabaseBuilder: localDatabaseBuilder,
        hiveInitializer: hiveInitializer,
      );
    }

    test('initial state is $AppUninitialized', () {
      final bloc = buildSubjectBloc(
        applicationDocumentsDirectoryGetter: () async => fail(
          'applicationDocumentsDirectoryGetter should not be called',
        ),
        temporaryDirectoryGetter: () async => fail(
          'temporaryDirectoryGetter should not be called',
        ),
        localDatabaseBuilder:
            ({
              required applicationDocumentsDirectoryPath,
              required temporaryDirectoryPath,
            }) => fail(
              'localDatabaseBuilder should not be called',
            ),
        hiveInitializer:
            ({
              required applicationDocumentsDirectoryPath,
            }) => fail(
              'hiveInitializer should not be called',
            ),
      );
      addTearDown(bloc.close);
      expect(bloc.state, const AppUninitialized());
    });

    group('$AppInitializationRequested', () {
      blocTest<AppInitializationBloc, AppInitializationState>(
        'emits ['
        '$AppInitializing, '
        '$FailedAppInitialization (with no successful initialization steps) '
        '] '
        'when the current state is $AppUninitialized '
        'and the initialization fails',
        build: () => buildSubjectBloc(
          applicationDocumentsDirectoryGetter: expectAsync0(
            () async => throw Exception(
              'Failed to get application documents directory',
            ),
            id: 'applicationDocumentsDirectoryGetter',
          ),
          temporaryDirectoryGetter: expectAsync0(
            () async => throw Exception(
              'Failed to get temporary directory',
            ),
            id: 'temporaryDirectoryGetter',
          ),
          localDatabaseBuilder:
              ({
                required applicationDocumentsDirectoryPath,
                required temporaryDirectoryPath,
              }) => fail(
                'localDatabaseBuilder should not be called',
              ),
          hiveInitializer:
              ({
                required applicationDocumentsDirectoryPath,
              }) => fail(
                'hiveInitializer should not be called',
              ),
        ),
        seed: AppUninitialized.new,
        act: (bloc) => bloc.add(const AppInitializationRequested()),
        expect: () => [
          const AppInitializing(),
          const FailedAppInitialization(hiveDatabaseInitialized: false),
        ],
      );

      test(
        'emits ['
        '$AppInitializing, '
        '''$FailedAppInitialization (with only successful folders initialization) '''
        '] '
        '''when the current state is $FailedAppInitialization (with only successful folders initialization) '''
        'and the initialization fails',
        () async {
          final applicationDocumentsDirectory = Directory.systemTemp
              .createTempSync();
          final temporaryDirectory = Directory.systemTemp.createTempSync();
          await testBloc<AppInitializationBloc, AppInitializationState>(
            build: () => buildSubjectBloc(
              applicationDocumentsDirectoryGetter: () async => fail(
                'applicationDocumentsDirectoryGetter should not be called',
              ),
              temporaryDirectoryGetter: () async => fail(
                'temporaryDirectoryGetter should not be called',
              ),
              localDatabaseBuilder:
                  ({
                    required applicationDocumentsDirectoryPath,
                    required temporaryDirectoryPath,
                  }) => expectAsync0(
                    () async => throw Exception(
                      'Failed to build local database',
                    ),
                    id: 'localDatabaseBuilder',
                  )(),
              hiveInitializer:
                  ({
                    required applicationDocumentsDirectoryPath,
                  }) => expectAsync0(
                    () async => throw Exception(
                      'Failed to initialize Hive',
                    ),
                    id: 'hiveInitializer',
                  )(),
            ),
            seed: () => FailedAppInitialization(
              applicationDocumentsDirectory: applicationDocumentsDirectory,
              temporaryDirectory: temporaryDirectory,
              hiveDatabaseInitialized: false,
            ),
            act: (bloc) => bloc.add(const AppInitializationRequested()),
            expect: () => [
              const AppInitializing(),
              FailedAppInitialization(
                applicationDocumentsDirectory: applicationDocumentsDirectory,
                temporaryDirectory: temporaryDirectory,
                hiveDatabaseInitialized: false,
              ),
            ],
          );
        },
      );

      test(
        'emits ['
        '$AppInitializing, '
        '''$SuccessfulAppInitialization '''
        '] '
        '''when the current state is $FailedAppInitialization (with successful local database initialization) '''
        'and the initialization fails',
        () async {
          final applicationDocumentsDirectory = Directory.systemTemp
              .createTempSync();
          final temporaryDirectory = Directory.systemTemp.createTempSync();
          final localDatabase = _MockLocalDatabase();
          await testBloc<AppInitializationBloc, AppInitializationState>(
            build: () => buildSubjectBloc(
              applicationDocumentsDirectoryGetter: () async => fail(
                'applicationDocumentsDirectoryGetter should not be called',
              ),
              temporaryDirectoryGetter: () async => fail(
                'temporaryDirectoryGetter should not be called',
              ),
              localDatabaseBuilder:
                  ({
                    required applicationDocumentsDirectoryPath,
                    required temporaryDirectoryPath,
                  }) => fail(
                    'localDatabaseBuilder should not be called',
                  ),
              hiveInitializer:
                  ({
                    required applicationDocumentsDirectoryPath,
                  }) => expectAsync0(
                    () async => localDatabase,
                    id: 'hiveInitializer',
                  )(),
            ),
            seed: () => FailedAppInitialization(
              applicationDocumentsDirectory: applicationDocumentsDirectory,
              temporaryDirectory: temporaryDirectory,
              localDatabase: localDatabase,
              hiveDatabaseInitialized: false,
            ),
            act: (bloc) => bloc.add(const AppInitializationRequested()),
            expect: () => [
              const AppInitializing(),
              SuccessfulAppInitialization(
                applicationDocumentsDirectory: applicationDocumentsDirectory,
                temporaryDirectory: temporaryDirectory,
                localDatabase: localDatabase,
              ),
            ],
          );
        },
      );

      test(
        'emits ['
        '$AppInitializing, '
        '''$SuccessfulAppInitialization '''
        '] '
        '''when the current state is $FailedAppInitialization (with successful hive database initialization) '''
        'and the initialization fails',
        () async {
          final applicationDocumentsDirectory = Directory.systemTemp
              .createTempSync();
          final temporaryDirectory = Directory.systemTemp.createTempSync();
          final localDatabase = _MockLocalDatabase();
          await testBloc<AppInitializationBloc, AppInitializationState>(
            build: () => buildSubjectBloc(
              applicationDocumentsDirectoryGetter: () async => fail(
                'applicationDocumentsDirectoryGetter should not be called',
              ),
              temporaryDirectoryGetter: () async => fail(
                'temporaryDirectoryGetter should not be called',
              ),
              localDatabaseBuilder:
                  ({
                    required applicationDocumentsDirectoryPath,
                    required temporaryDirectoryPath,
                  }) => expectAsync0(
                    () async => localDatabase,
                    id: 'localDatabaseBuilder',
                  )(),
              hiveInitializer:
                  ({
                    required applicationDocumentsDirectoryPath,
                  }) => fail(
                    'hiveInitializer should not be called',
                  ),
            ),
            seed: () => FailedAppInitialization(
              applicationDocumentsDirectory: applicationDocumentsDirectory,
              temporaryDirectory: temporaryDirectory,
              localDatabase: localDatabase,
              hiveDatabaseInitialized: true,
            ),
            act: (bloc) => bloc.add(const AppInitializationRequested()),
            expect: () => [
              const AppInitializing(),
              SuccessfulAppInitialization(
                applicationDocumentsDirectory: applicationDocumentsDirectory,
                temporaryDirectory: temporaryDirectory,
                localDatabase: localDatabase,
              ),
            ],
          );
        },
      );

      test(
        'emits ['
        '$AppInitializing, '
        '''$SuccessfulAppInitialization '''
        '] '
        'when the initialization is successful',
        () async {
          final applicationDocumentsDirectory = Directory.systemTemp
              .createTempSync();
          final temporaryDirectory = Directory.systemTemp.createTempSync();
          final localDatabase = _MockLocalDatabase();
          await testBloc<AppInitializationBloc, AppInitializationState>(
            build: () => buildSubjectBloc(
              applicationDocumentsDirectoryGetter: expectAsync0(
                () async => applicationDocumentsDirectory,
                id: 'applicationDocumentsDirectoryGetter',
              ),
              temporaryDirectoryGetter: expectAsync0(
                () async => temporaryDirectory,
                id: 'temporaryDirectoryGetter',
              ),
              localDatabaseBuilder:
                  ({
                    required applicationDocumentsDirectoryPath,
                    required temporaryDirectoryPath,
                  }) => expectAsync0(
                    () async => localDatabase,
                    id: 'localDatabaseBuilder',
                  )(),
              hiveInitializer:
                  ({
                    required applicationDocumentsDirectoryPath,
                  }) => expectAsync0(
                    () async {},
                    id: 'hiveInitializer',
                  )(),
            ),
            act: (bloc) => bloc.add(const AppInitializationRequested()),
            expect: () => [
              const AppInitializing(),
              SuccessfulAppInitialization(
                applicationDocumentsDirectory: applicationDocumentsDirectory,
                temporaryDirectory: temporaryDirectory,
                localDatabase: localDatabase,
              ),
            ],
          );
        },
      );
    });
  });
}
