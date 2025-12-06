part of 'app_initialization_bloc.dart';

sealed class AppInitializationEvent {
  const AppInitializationEvent();
}

@MappableClass()
final class AppInitializationRequested extends AppInitializationEvent
    with AppInitializationRequestedMappable {
  const AppInitializationRequested();
}
