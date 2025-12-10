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
    test('initial state is $AppUninitialized', () {
      final bloc = AppInitializationBloc(
        initializationCallback: () async => fail(
          'initializationCallback should not be called',
        ),
        /*remove-start*/
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
            }) async => fail(
              'localDatabaseBuilder should not be called',
            ),
        hiveInitializer:
            ({
              required applicationDocumentsDirectoryPath,
            }) async => fail(
              'hiveInitializer should not be called',
            ),
        /*remove-end*/
      );
      addTearDown(bloc.close);
      expect(bloc.state, const AppUninitialized());
    });

    group('$AppInitializationRequested', () {
      blocTest<AppInitializationBloc, AppInitializationState>(
        'emits ['
        '$AppInitializing, '
        '$FailedAppInitialization'
        '] '
        'when the current state is $AppUninitialized '
        'and the initialization fails',
        build: () => AppInitializationBloc(
          initializationCallback: () async =>
              throw Exception('Failed to initialize'),
          /*remove-start*/
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
          /*remove-end*/
        ),
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

      blocTest<AppInitializationBloc, AppInitializationState>(
        'emits ['
        '$AppInitializing, '
        '$SuccessfulAppInitialization'
        '] '
        'when the current state is $AppUninitialized '
        'and the initialization is successful',
        build: () => AppInitializationBloc(
          initializationCallback: () async {
            return expectAsync0(
              () async {},
              id: 'initializationCallback',
            )();
          },
          /*remove-start*/
          applicationDocumentsDirectoryGetter: () async {
            return expectAsync0(
              () async => Directory.systemTemp.createTempSync(),
              id: 'applicationDocumentsDirectoryGetter',
            )();
          },
          temporaryDirectoryGetter: () async {
            return expectAsync0(
              () async => Directory.systemTemp.createTempSync(),
              id: 'temporaryDirectoryGetter',
            )();
          },
          localDatabaseBuilder:
              ({
                required applicationDocumentsDirectoryPath,
                required temporaryDirectoryPath,
              }) => expectAsync0(
                () async => _MockLocalDatabase(),
                id: 'localDatabaseBuilder',
              )(),
          hiveInitializer:
              ({
                required applicationDocumentsDirectoryPath,
              }) => expectAsync0(
                () async {},
                id: 'hiveInitializer',
              )(),
          /*remove-end*/
        ),
        seed: AppUninitialized.new,
        act: (bloc) {
          bloc.add(const AppInitializationRequested());
          return pumpEventQueue();
        },
        expect: () => [
          const AppInitializing(),
          /*replace-start*/
          isA<SuccessfulAppInitialization>(),
          /*with*/
          // const SuccessfulAppInitialization(),
          /*replace-end*/
        ],
      );
    });
  });
}
