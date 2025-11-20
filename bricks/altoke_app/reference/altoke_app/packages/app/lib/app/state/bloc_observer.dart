import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*w 2v w*/
/*remove-start*/
// TODO(mrverdant13): Add tests.
/*remove-end*/
// coverage:ignore-start

final class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  void log(
    String message, {
    required String name,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!kDebugMode) return;
    dev.log(message, name: name, error: error, stackTrace: stackTrace);
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    log(
      'onEvent($event)',
      name: bloc.runtimeType.toString(),
    );
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log(
      'onChange($change)',
      name: bloc.runtimeType.toString(),
    );
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log(
      'onError',
      name: bloc.runtimeType.toString(),
      error: error,
      stackTrace: stackTrace,
    );
  }
}

// coverage:ignore-end
