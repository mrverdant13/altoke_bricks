// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:altoke_app/routing/routes/counter/screen.dart' as _i1;
import 'package:altoke_app/routing/routes/home/screen.dart' as _i2;
import 'package:altoke_app/routing/routes/tasks/__root/screen.dart' as _i4;
import 'package:altoke_app/routing/routes/tasks/new/screen.dart' as _i3;
import 'package:auto_route/auto_route.dart' as _i5;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    CounterRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.CounterScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeScreen(),
      );
    },
    NewTaskRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.NewTaskScreen(),
      );
    },
    TasksRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.TasksScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.CounterScreen]
class CounterRoute extends _i5.PageRouteInfo<void> {
  const CounterRoute({List<_i5.PageRouteInfo>? children})
      : super(
          CounterRoute.name,
          initialChildren: children,
        );

  static const String name = 'CounterRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.NewTaskScreen]
class NewTaskRoute extends _i5.PageRouteInfo<void> {
  const NewTaskRoute({List<_i5.PageRouteInfo>? children})
      : super(
          NewTaskRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewTaskRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.TasksScreen]
class TasksRoute extends _i5.PageRouteInfo<void> {
  const TasksRoute({List<_i5.PageRouteInfo>? children})
      : super(
          TasksRoute.name,
          initialChildren: children,
        );

  static const String name = 'TasksRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
