/*remove-start*/
import 'package:riverpod_annotation/riverpod_annotation.dart';

/*remove-end*/

/*x{{#use_bloc}}*/
export 'app_initialization_bloc.dart';
/*x{{/use_bloc}}x*/
/*x{{#use_riverpod}}*/
export 'async_initialization_pod.dart';
/*x{{/use_riverpod}}*/
/*{{#use_bloc}}x*/
export 'bloc_observer.dart';
/*x{{/use_bloc}}x*/
/*x{{#use_riverpod}}x*/
export 'provider_observer.dart';

/*x{{/use_riverpod}}*/

/*drop*/
part 'state.g.dart';

// coverage:ignore-start

enum StateManagementPackage {
  bloc('bloc'),
  riverpod('riverpod')
  ;

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
