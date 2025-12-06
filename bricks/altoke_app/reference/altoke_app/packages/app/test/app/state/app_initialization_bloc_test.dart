/*remove-start*/
import 'dart:io';

/*remove-end*/

import 'package:altoke_app/app/app.dart';
import 'package:bloc_test/bloc_test.dart';
/*remove-start*/
import 'package:drift_local_database/drift_local_database.dart';
/*remove-end*/
import 'package:flutter_test/flutter_test.dart';
/*remove-start*/
import 'package:mocktail/mocktail.dart';
/*remove-end*/

/*remove-start*/
class _MockLocalDatabase extends Mock implements LocalDatabase {}
/*remove-end*/

void main() {
  group('$AppInitializationBloc', () {
    /*remove-start*/
    AppInitializationBloc buildSubjectBloc({
      required Future<Directory> Function() applicationDocumentsDirectoryGetter,
      required Future<Directory> Function() temporaryDirectoryGetter,
      required Future<LocalDatabase> Function({
        required String? applicationDocumentsDirectoryPath,
        required String? temporaryDirectoryPath,
      })
      localDatabaseBuilder,
      required Future<void> Function({
        required String? applicationDocumentsDirectoryPath,
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
    /*remove-end*/

    test('initial state is $AppUninitialized', () {
      final bloc = /*replace-start*/ buildSubjectBloc(
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
      /*with i0*/
      // AppInitializationBloc();
      /*replace-end*/
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
        build: /*replace-start*/ () => buildSubjectBloc(
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
        /*with*/
        // AppInitializationBloc.new,
        /*replace-end*/
        seed: AppUninitialized.new,
        act: (bloc) => bloc.add(const AppInitializationRequested()),
        expect: () => [
          const AppInitializing(),
          const FailedAppInitialization(
            /*remove-start*/
            hiveDatabaseInitialized: false,
            /*remove-end*/
          ),
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
          /*remove-start*/
          final applicationDocumentsDirectory = Directory.systemTemp
              .createTempSync();
          final temporaryDirectory = Directory.systemTemp.createTempSync();
          /*remove-end*/
          await testBloc<AppInitializationBloc, AppInitializationState>(
            build: /*replace-start*/ () => buildSubjectBloc(
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
            /*with*/
            // AppInitializationBloc.new,
            /*replace-end*/
            seed: () =>
                /*insert-start*/
                // const
                /*insert-end*/
                FailedAppInitialization(
                  /*remove-start*/
                  applicationDocumentsDirectory: applicationDocumentsDirectory,
                  temporaryDirectory: temporaryDirectory,
                  hiveDatabaseInitialized: false,
                  /*remove-end*/
                ),
            act: (bloc) => bloc.add(const AppInitializationRequested()),
            expect: () => [
              const AppInitializing(),
              /*insert-start*/
              // const
              /*insert-end*/
              FailedAppInitialization(
                /*remove-start*/
                applicationDocumentsDirectory: applicationDocumentsDirectory,
                temporaryDirectory: temporaryDirectory,
                hiveDatabaseInitialized: false,
                /*remove-end*/
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
          /*remove-start*/
          final applicationDocumentsDirectory = Directory.systemTemp
              .createTempSync();
          final temporaryDirectory = Directory.systemTemp.createTempSync();
          final localDatabase = _MockLocalDatabase();
          /*remove-end*/
          await testBloc<AppInitializationBloc, AppInitializationState>(
            build: /*replace-start*/ () => buildSubjectBloc(
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
            /*with*/
            //  AppInitializationBloc.new,
            /*replace-end*/
            seed: () =>
                /*insert-start*/
                // const
                /*insert-end*/
                FailedAppInitialization(
                  /*remove-start*/
                  applicationDocumentsDirectory: applicationDocumentsDirectory,
                  temporaryDirectory: temporaryDirectory,
                  localDatabase: localDatabase,
                  hiveDatabaseInitialized: false,
                  /*remove-end*/
                ),
            act: (bloc) => bloc.add(const AppInitializationRequested()),
            expect: () => [
              const AppInitializing(),
              /*insert-start*/
              // const
              /*insert-end*/
              SuccessfulAppInitialization(
                /*remove-start*/
                applicationDocumentsDirectory: applicationDocumentsDirectory,
                temporaryDirectory: temporaryDirectory,
                localDatabase: localDatabase,
                /*remove-end*/
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
          /*remove-start*/
          final applicationDocumentsDirectory = Directory.systemTemp
              .createTempSync();
          final temporaryDirectory = Directory.systemTemp.createTempSync();
          final localDatabase = _MockLocalDatabase();
          /*remove-end*/
          await testBloc<AppInitializationBloc, AppInitializationState>(
            build: /*replace-start*/ () => buildSubjectBloc(
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
            /*with*/
            //  AppInitializationBloc.new,
            /*replace-end*/
            seed: () =>
                /*insert-start*/
                // const
                /*insert-end*/
                FailedAppInitialization(
                  /*remove-start*/
                  applicationDocumentsDirectory: applicationDocumentsDirectory,
                  temporaryDirectory: temporaryDirectory,
                  localDatabase: localDatabase,
                  hiveDatabaseInitialized: true,
                  /*remove-end*/
                ),
            act: (bloc) => bloc.add(const AppInitializationRequested()),
            expect: () => [
              const AppInitializing(),
              /*insert-start*/
              // const
              /*insert-end*/
              SuccessfulAppInitialization(
                /*remove-start*/
                applicationDocumentsDirectory: applicationDocumentsDirectory,
                temporaryDirectory: temporaryDirectory,
                localDatabase: localDatabase,
                /*remove-end*/
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
          /*remove-start*/
          final applicationDocumentsDirectory = Directory.systemTemp
              .createTempSync();
          final temporaryDirectory = Directory.systemTemp.createTempSync();
          final localDatabase = _MockLocalDatabase();
          /*remove-end*/
          await testBloc<AppInitializationBloc, AppInitializationState>(
            build: /*replace-start*/ () => buildSubjectBloc(
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
            /*with*/
            //  AppInitializationBloc.new,
            /*replace-end*/
            act: (bloc) => bloc.add(const AppInitializationRequested()),
            expect: () => [
              const AppInitializing(),
              /*insert-start*/
              // const
              /*insert-end*/
              SuccessfulAppInitialization(
                /*remove-start*/
                applicationDocumentsDirectory: applicationDocumentsDirectory,
                temporaryDirectory: temporaryDirectory,
                localDatabase: localDatabase,
                /*remove-end*/
              ),
            ],
          );
        },
      );
    });
  });
}
