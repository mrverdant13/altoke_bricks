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
  const SuccessfulAppInitialization({
    required this.applicationDocumentsDirectory,
    required this.temporaryDirectory,
    required this.localDatabase,
  });

  final Directory applicationDocumentsDirectory;
  final Directory temporaryDirectory;
  final LocalDatabase localDatabase;
}

@MappableClass()
final class FailedAppInitialization extends AppInitializationState
    with FailedAppInitializationMappable {
  const FailedAppInitialization({
    required this.hiveDatabaseInitialized,
    this.applicationDocumentsDirectory,
    this.temporaryDirectory,
    this.localDatabase,
  });

  final bool hiveDatabaseInitialized;
  final Directory? applicationDocumentsDirectory;
  final Directory? temporaryDirectory;
  final LocalDatabase? localDatabase;
}
