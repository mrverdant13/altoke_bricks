// Allow non-const constructors for testing
// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:altoke_app/app/app.dart';
import 'package:drift_local_database/drift_local_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockLocalDatabase extends Mock implements LocalDatabase {}

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
        final applicationDocumentsDirectory = Directory.systemTemp
            .createTempSync();
        final temporaryDirectory = Directory.systemTemp.createTempSync();
        final localDatabase = _MockLocalDatabase();
        final otherLocalDatabase = _MockLocalDatabase();
        final subject = SuccessfulAppInitialization(
          applicationDocumentsDirectory: applicationDocumentsDirectory,
          temporaryDirectory: temporaryDirectory,
          localDatabase: localDatabase,
        );
        final same = SuccessfulAppInitialization(
          applicationDocumentsDirectory: applicationDocumentsDirectory,
          temporaryDirectory: temporaryDirectory,
          localDatabase: localDatabase,
        );
        final other = SuccessfulAppInitialization(
          applicationDocumentsDirectory: applicationDocumentsDirectory,
          temporaryDirectory: temporaryDirectory,
          localDatabase: otherLocalDatabase,
        );
        expect(subject, same);
        expect(subject, isNot(other));
      });
    });

    group('$FailedAppInitialization', () {
      test('| can be compared', () {
        final applicationDocumentsDirectory = Directory.systemTemp
            .createTempSync();
        final temporaryDirectory = Directory.systemTemp.createTempSync();
        final localDatabase = _MockLocalDatabase();
        final otherLocalDatabase = _MockLocalDatabase();
        final subject = FailedAppInitialization(
          hiveDatabaseInitialized: true,
          applicationDocumentsDirectory: applicationDocumentsDirectory,
          temporaryDirectory: temporaryDirectory,
          localDatabase: localDatabase,
        );
        final same = FailedAppInitialization(
          hiveDatabaseInitialized: true,
          applicationDocumentsDirectory: applicationDocumentsDirectory,
          temporaryDirectory: temporaryDirectory,
          localDatabase: localDatabase,
        );
        final other = FailedAppInitialization(
          hiveDatabaseInitialized: true,
          applicationDocumentsDirectory: applicationDocumentsDirectory,
          temporaryDirectory: temporaryDirectory,
          localDatabase: otherLocalDatabase,
        );
        expect(subject, same);
        expect(subject, isNot(other));
      });
    });
  });
}
