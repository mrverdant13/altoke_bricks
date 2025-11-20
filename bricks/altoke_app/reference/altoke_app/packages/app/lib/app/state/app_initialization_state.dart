part of 'app_initialization_bloc.dart';

sealed class AppInitializationState {
  const AppInitializationState();
}

@MappableClass()
final class AppUninitialized extends AppInitializationState
    with AppUninitializedMappable {
  const AppUninitialized();
}

@MappableClass()
final class AppInitializing extends AppInitializationState
    with AppInitializingMappable {
  const AppInitializing();
}

@MappableClass()
final class SuccessfulAppInitialization extends AppInitializationState
    with SuccessfulAppInitializationMappable {
  const SuccessfulAppInitialization
  /*replace-start*/
  ({
    required this.applicationDocumentsDirectory,
    required this.temporaryDirectory,
    required this.localDatabase,
  })
  /*with*/
  // ()
  /*replace-end*/
  ;

  /*remove-start*/
  final Directory applicationDocumentsDirectory;
  final Directory temporaryDirectory;
  final LocalDatabase localDatabase;
  /*remove-end*/
}

@MappableClass()
final class FailedAppInitialization extends AppInitializationState
    with FailedAppInitializationMappable {
  const FailedAppInitialization
  /*replace-start*/
  ({
    required this.hiveDatabaseInitialized,
    this.applicationDocumentsDirectory,
    this.temporaryDirectory,
    this.localDatabase,
  })
  /*with*/
  // ()
  /*replace-end*/
  ;

  /*remove-start*/
  final bool hiveDatabaseInitialized;
  final Directory? applicationDocumentsDirectory;
  final Directory? temporaryDirectory;
  final LocalDatabase? localDatabase;
  /*remove-end*/
}
