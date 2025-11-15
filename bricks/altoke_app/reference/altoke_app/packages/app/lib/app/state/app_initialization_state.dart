part of 'app_initialization_bloc.dart';

sealed class AppInitializationState {
  const AppInitializationState();
}

@MappableClass()
final class AppUninitialized extends AppInitializationState
    with AppUninitializedMappable {}

@MappableClass()
final class AppInitializing extends AppInitializationState
    with AppInitializingMappable {}

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
    this.applicationDocumentsDirectory,
    this.temporaryDirectory,
    this.localDatabase,
  });

  final Directory? applicationDocumentsDirectory;
  final Directory? temporaryDirectory;
  final LocalDatabase? localDatabase;
}
