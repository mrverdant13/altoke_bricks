import 'dart:io';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:drift_local_database/drift_local_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_initialization_bloc.mapper.dart';
part 'app_initialization_event.dart';
part 'app_initialization_state.dart';

class AppInitializationBloc
    extends Bloc<AppInitializationEvent, AppInitializationState> {
  AppInitializationBloc({
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
  }) : getApplicationDocumentsDirectory = applicationDocumentsDirectoryGetter,
       getTemporaryDirectory = temporaryDirectoryGetter,
       buildLocalDatabase = localDatabaseBuilder,
       initializeHive = hiveInitializer,
       super(const AppUninitialized()) {
    on<AppInitializationRequested>(
      _onAppInitializationRequested,
      transformer: droppable(),
    );
  }

  @visibleForTesting
  final Future<Directory> Function() getApplicationDocumentsDirectory;

  @visibleForTesting
  final Future<Directory> Function() getTemporaryDirectory;

  @visibleForTesting
  final Future<LocalDatabase> Function({
    required String applicationDocumentsDirectoryPath,
    required String temporaryDirectoryPath,
  })
  buildLocalDatabase;

  @visibleForTesting
  final Future<void> Function({
    required String applicationDocumentsDirectoryPath,
  })
  initializeHive;

  Future<void> _onAppInitializationRequested(
    AppInitializationRequested event,
    Emitter<AppInitializationState> emit,
  ) async {
    if (state is SuccessfulAppInitialization) return;
    var (
      Directory? applicationDocumentsDirectory,
      Directory? temporaryDirectory,
      LocalDatabase? localDatabase,
      bool hiveDatabaseInitialized,
    ) = switch (state) {
      final FailedAppInitialization state => (
        state.applicationDocumentsDirectory,
        state.temporaryDirectory,
        state.localDatabase,
        state.hiveDatabaseInitialized,
      ),
      _ => (
        null,
        null,
        null,
        false,
      ),
    };
    emit(const AppInitializing());
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
      localDatabase ??= await buildLocalDatabase(
        applicationDocumentsDirectoryPath: applicationDocumentsDirectory.path,
        temporaryDirectoryPath: temporaryDirectory.path,
      );
      hiveDatabaseInitialized = await (() async {
        if (hiveDatabaseInitialized) return true;
        return initializeHive(
          applicationDocumentsDirectoryPath:
              applicationDocumentsDirectory!.path,
        ).then((value) => true);
      })();
      emit(
        SuccessfulAppInitialization(
          applicationDocumentsDirectory: applicationDocumentsDirectory,
          temporaryDirectory: temporaryDirectory,
          localDatabase: localDatabase,
        ),
      );
    } on Object {
      /*remove-start*/
      // TODO(mrverdant13): Include error for analytics.
      /*remove-end*/
      emit(
        FailedAppInitialization(
          applicationDocumentsDirectory: applicationDocumentsDirectory,
          temporaryDirectory: temporaryDirectory,
          localDatabase: localDatabase,
          hiveDatabaseInitialized: hiveDatabaseInitialized,
        ),
      );
    }
  }
}
