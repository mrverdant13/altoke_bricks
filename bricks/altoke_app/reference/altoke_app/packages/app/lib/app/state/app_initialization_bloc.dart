/*remove-start*/
import 'dart:io';

/*remove-end-x*/

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dart_mappable/dart_mappable.dart';
/*remove-start*/
import 'package:drift_local_database/drift_local_database.dart';
import 'package:flutter/foundation.dart';
/*remove-end*/
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_initialization_bloc.mapper.dart';
part 'app_initialization_event.dart';
part 'app_initialization_state.dart';

class AppInitializationBloc
    extends Bloc<AppInitializationEvent, AppInitializationState> {
  AppInitializationBloc
  /*replace-start*/
  ({
    required AsyncCallback initializationCallback,
    required AsyncValueGetter<Directory> applicationDocumentsDirectoryGetter,
    required AsyncValueGetter<Directory> temporaryDirectoryGetter,
    required Future<LocalDatabase> Function({
      required String? applicationDocumentsDirectoryPath,
      required String? temporaryDirectoryPath,
    })
    localDatabaseBuilder,
    required Future<void> Function({
      required String? applicationDocumentsDirectoryPath,
    })
    hiveInitializer,
  })
    : initialize = initializationCallback,
      getApplicationDocumentsDirectory = applicationDocumentsDirectoryGetter,
      getTemporaryDirectory = temporaryDirectoryGetter,
      buildLocalDatabase = localDatabaseBuilder,
      initializeHive = hiveInitializer,
      /*with*/
      // () :
      /*replace-end*/
      super(const AppUninitialized()) {
    on<AppInitializationRequested>(
      _onAppInitializationRequested,
      transformer: droppable(),
    );
  }

  @visibleForTesting
  final AsyncCallback? initialize;

  /*remove-start*/
  @visibleForTesting
  final AsyncValueGetter<Directory> getApplicationDocumentsDirectory;

  @visibleForTesting
  final AsyncValueGetter<Directory> getTemporaryDirectory;

  @visibleForTesting
  final Future<LocalDatabase> Function({
    required String? applicationDocumentsDirectoryPath,
    required String? temporaryDirectoryPath,
  })
  buildLocalDatabase;

  @visibleForTesting
  final Future<void> Function({
    required String? applicationDocumentsDirectoryPath,
  })
  initializeHive;
  /*remove-end*/

  Future<void> _onAppInitializationRequested(
    AppInitializationRequested event,
    Emitter<AppInitializationState> emit,
  ) async {
    if (state is SuccessfulAppInitialization) return;
    /*remove-start*/
    // coverage:ignore-start
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
    // coverage:ignore-end
    /*remove-end-x*/
    emit(const AppInitializing());
    try {
      // Run async initialization.
      await initialize?.call();
      /*remove-start*/
      // coverage:ignore-start
      if (!kIsWeb) {
        (
          applicationDocumentsDirectory,
          temporaryDirectory,
        ) = await (
          applicationDocumentsDirectory != null
              ? Future.value(applicationDocumentsDirectory)
              : Future(getApplicationDocumentsDirectory),
          temporaryDirectory != null
              ? Future.value(temporaryDirectory)
              : Future(getTemporaryDirectory),
        ).wait;
      }
      localDatabase ??= await buildLocalDatabase(
        applicationDocumentsDirectoryPath: applicationDocumentsDirectory?.path,
        temporaryDirectoryPath: temporaryDirectory?.path,
      );
      hiveDatabaseInitialized = await (() async {
        if (hiveDatabaseInitialized) return true;
        return initializeHive(
          applicationDocumentsDirectoryPath:
              applicationDocumentsDirectory?.path,
        ).then((value) => true);
      })();
      // coverage:ignore-end
      /*remove-end*/
      emit(
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
      );
    } on Object {
      /*remove-start*/
      // TODO(mrverdant13): Include error for analytics.
      /*remove-end*/
      emit(
        /*insert-start*/
        // const
        /*insert-end*/
        FailedAppInitialization(
          /*remove-start*/
          applicationDocumentsDirectory: applicationDocumentsDirectory,
          temporaryDirectory: temporaryDirectory,
          localDatabase: localDatabase,
          hiveDatabaseInitialized: hiveDatabaseInitialized,
          /*remove-end*/
        ),
      );
    }
  }
}
