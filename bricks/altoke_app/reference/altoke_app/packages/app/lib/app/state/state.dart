/*remove-start*/
import 'package:riverpod_annotation/riverpod_annotation.dart';

/*remove-end-x*/

export 'app_initialization_bloc.dart';
export 'async_initialization_pod.dart';
/*{{#use_bloc}}*/
export 'bloc_observer.dart';
/*{{/use_bloc}}*/
/*{{#use_riverpod}}*/
export 'provider_observer.dart';

/*{{/use_riverpod}}*/

/*drop*/
// coverage:ignore-start
part 'state.g.dart';

enum StateManagementPackage {
  bloc('bloc'),
  riverpod('riverpod');

  const StateManagementPackage(this.identifier);

  final String identifier;
}

@Riverpod(dependencies: [], keepAlive: true)
class SelectedStateManagementPackage extends _$SelectedStateManagementPackage {
  @override
  StateManagementPackage build() {
    return StateManagementPackage.values.first;
  }

  // No getter is needed as the state should be accessed directly.
  // ignore: avoid_setters_without_getters
  set value(StateManagementPackage value) => state = value;
}

// coverage:ignore-end
