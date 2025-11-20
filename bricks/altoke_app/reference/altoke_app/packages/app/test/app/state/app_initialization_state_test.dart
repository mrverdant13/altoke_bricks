// Allow non-const constructors for testing
// ignore_for_file: prefer_const_constructors

/*remove-start*/
import 'dart:io';

/*remove-end*/

import 'package:altoke_app/app/app.dart';
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
  group('$AppInitializationState', () {
    group('$AppUninitialized', () {
      test('| can be compared', () {
        final subject = AppUninitialized();
        final same = AppUninitialized();
        expect(subject, same);
      });
    });

    group('$AppInitializing', () {
      test('| can be compared', () {
        final subject = AppInitializing();
        final same = AppInitializing();
        expect(subject, same);
      });
    });

    group('$SuccessfulAppInitialization', () {
      test('| can be compared', () {
        /*remove-start*/
        final applicationDocumentsDirectory = Directory.systemTemp
            .createTempSync();
        final temporaryDirectory = Directory.systemTemp.createTempSync();
        final localDatabase = _MockLocalDatabase();
        final otherLocalDatabase = _MockLocalDatabase();
        /*remove-end*/
        final subject = SuccessfulAppInitialization(
          /*remove-start*/
          applicationDocumentsDirectory: applicationDocumentsDirectory,
          temporaryDirectory: temporaryDirectory,
          localDatabase: localDatabase,
          /*remove-end*/
        );
        final same = SuccessfulAppInitialization(
          /*remove-start*/
          applicationDocumentsDirectory: applicationDocumentsDirectory,
          temporaryDirectory: temporaryDirectory,
          localDatabase: localDatabase,
          /*remove-end*/
        );
        /*remove-start*/
        final other = SuccessfulAppInitialization(
          applicationDocumentsDirectory: applicationDocumentsDirectory,
          temporaryDirectory: temporaryDirectory,
          localDatabase: otherLocalDatabase,
        );
        /*remove-end*/
        expect(subject, same);
        /*remove-start*/
        expect(subject, isNot(other));
        /*remove-end*/
      });
    });

    group('$FailedAppInitialization', () {
      test('| can be compared', () {
        /*remove-start*/
        final applicationDocumentsDirectory = Directory.systemTemp
            .createTempSync();
        final temporaryDirectory = Directory.systemTemp.createTempSync();
        final localDatabase = _MockLocalDatabase();
        final otherLocalDatabase = _MockLocalDatabase();
        /*remove-end*/
        final subject = FailedAppInitialization(
          /*remove-start*/
          hiveDatabaseInitialized: true,
          applicationDocumentsDirectory: applicationDocumentsDirectory,
          temporaryDirectory: temporaryDirectory,
          localDatabase: localDatabase,
          /*remove-end*/
        );
        final same = FailedAppInitialization(
          /*remove-start*/
          hiveDatabaseInitialized: true,
          applicationDocumentsDirectory: applicationDocumentsDirectory,
          temporaryDirectory: temporaryDirectory,
          localDatabase: localDatabase,
          /*remove-end*/
        );
        /*remove-start*/
        final other = FailedAppInitialization(
          hiveDatabaseInitialized: true,
          applicationDocumentsDirectory: applicationDocumentsDirectory,
          temporaryDirectory: temporaryDirectory,
          localDatabase: otherLocalDatabase,
        );
        /*remove-end*/
        expect(subject, same);
        /*remove-start*/
        expect(subject, isNot(other));
        /*remove-end*/
      });
    });
  });
}
