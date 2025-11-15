import 'dart:io';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:drift_local_database/drift_local_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_initialization_bloc.mapper.dart';
part 'app_initialization_event.dart';
part 'app_initialization_state.dart';

class AppInitializationBloc
    extends Bloc<AppInitializationEvent, AppInitializationState> {
  AppInitializationBloc() : super(AppUninitialized()) {
    on<AppInitializationRequested>(
      _onAppInitializationRequested,
      transformer: droppable(),
    );
  }

  Future<void> _onAppInitializationRequested(
    AppInitializationRequested event,
    Emitter<AppInitializationState> emit,
  ) async {
    if (state is SuccessfulAppInitialization) return;
    var (
      Directory? applicationDocumentsDirectory,
      Directory? temporaryDirectory,
      LocalDatabase? localDatabase,
    ) = switch (state) {
      final FailedAppInitialization state => (
        state.applicationDocumentsDirectory,
        state.temporaryDirectory,
        state.localDatabase,
      ),
      _ => (
        null,
        null,
        null,
      ),
    };
    emit(AppInitializing());
    try {
      (
        applicationDocumentsDirectory,
        temporaryDirectory,
      ) = await (
        Future(
          () async =>
              applicationDocumentsDirectory ??
              await getApplicationDocumentsDirectory(),
        ),
        Future(
          () async => temporaryDirectory ?? await getTemporaryDirectory(),
        ),
      ).wait;
      if (localDatabase == null) {
        const dbName = 'app_db';
        final databaseDirectoryPath = p.joinAll([
          applicationDocumentsDirectory.path,
          'drift_database',
        ]);
        final temporaryDirectoryPath = p.joinAll([
          temporaryDirectory.path,
          'drift_database',
        ]);
        localDatabase = LocalDatabase(
          schemaVersion: 1,
          queryExecutor: driftDatabase(
            name: dbName,
            native: DriftNativeOptions(
              databaseDirectory: () async => databaseDirectoryPath,
              tempDirectoryPath: () async => temporaryDirectoryPath,
            ),
          ),
        );
      }
      if (!kIsWeb) {
        const dbName = 'app_db';
        final databasePath = p.joinAll([
          applicationDocumentsDirectory.path,
          'hive_database',
          dbName,
        ]);
        final databaseDir = Directory(databasePath);
        if (!databaseDir.existsSync()) {
          await databaseDir.create(recursive: true);
        }
        Hive.init(databasePath);
      }
      emit(
        SuccessfulAppInitialization(
          applicationDocumentsDirectory: applicationDocumentsDirectory,
          temporaryDirectory: temporaryDirectory,
          localDatabase: localDatabase,
        ),
      );
    } on Exception {
      // TODO(mrverdant13): Include error for analytics.
      emit(
        FailedAppInitialization(
          applicationDocumentsDirectory: applicationDocumentsDirectory,
          temporaryDirectory: temporaryDirectory,
          localDatabase: localDatabase,
        ),
      );
    }
  }
}
