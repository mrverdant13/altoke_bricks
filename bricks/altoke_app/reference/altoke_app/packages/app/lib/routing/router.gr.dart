// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:altoke_app/routing/routes/_home/__screen.dart' as _i2;
import 'package:altoke_app/routing/routes/counter/__screen.dart' as _i1;
import 'package:altoke_app/routing/routes/tasks/__screen.dart' as _i3;
import 'package:auto_route/auto_route.dart' as _i4;

/// generated route for
/// [_i1.CounterScreen]
class CounterRoute extends _i4.PageRouteInfo<void> {
  const CounterRoute({List<_i4.PageRouteInfo>? children})
    : super(CounterRoute.name, initialChildren: children);

  static const String name = 'CounterRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.CounterScreen();
    },
  );
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeScreen();
    },
  );
}

/// generated route for
/// [_i3.TasksScreen]
class TasksRoute extends _i4.PageRouteInfo<void> {
  const TasksRoute({List<_i4.PageRouteInfo>? children})
    : super(TasksRoute.name, initialChildren: children);

  static const String name = 'TasksRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.TasksScreen();
    },
  );
}
