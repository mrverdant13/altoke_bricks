// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:altoke_app/routing/routes/counter/screen.dart' as _i1;
import 'package:altoke_app/routing/routes/home/screen.dart' as _i2;
import 'package:altoke_app/routing/routes/tasks/__root/screen.dart' as _i5;
import 'package:altoke_app/routing/routes/tasks/_task_id/screen.dart' as _i4;
import 'package:altoke_app/routing/routes/tasks/new/screen.dart' as _i3;
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    CounterRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.CounterScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeScreen(),
      );
    },
    NewTaskRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.NewTaskScreen(),
      );
    },
    TaskDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<TaskDetailsRouteArgs>(
          orElse: () =>
              TaskDetailsRouteArgs(taskId: pathParams.getInt('taskId')));
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.TaskDetailsScreen(
          taskId: args.taskId,
          key: args.key,
        ),
      );
    },
    TasksRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.TasksScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.CounterScreen]
class CounterRoute extends _i6.PageRouteInfo<void> {
  const CounterRoute({List<_i6.PageRouteInfo>? children})
      : super(
          CounterRoute.name,
          initialChildren: children,
        );

  static const String name = 'CounterRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.NewTaskScreen]
class NewTaskRoute extends _i6.PageRouteInfo<void> {
  const NewTaskRoute({List<_i6.PageRouteInfo>? children})
      : super(
          NewTaskRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewTaskRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.TaskDetailsScreen]
class TaskDetailsRoute extends _i6.PageRouteInfo<TaskDetailsRouteArgs> {
  TaskDetailsRoute({
    required int taskId,
    _i7.Key? key,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          TaskDetailsRoute.name,
          args: TaskDetailsRouteArgs(
            taskId: taskId,
            key: key,
          ),
          rawPathParams: {'taskId': taskId},
          initialChildren: children,
        );

  static const String name = 'TaskDetailsRoute';

  static const _i6.PageInfo<TaskDetailsRouteArgs> page =
      _i6.PageInfo<TaskDetailsRouteArgs>(name);
}

class TaskDetailsRouteArgs {
  const TaskDetailsRouteArgs({
    required this.taskId,
    this.key,
  });

  final int taskId;

  final _i7.Key? key;

  @override
  String toString() {
    return 'TaskDetailsRouteArgs{taskId: $taskId, key: $key}';
  }
}

/// generated route for
/// [_i5.TasksScreen]
class TasksRoute extends _i6.PageRouteInfo<void> {
  const TasksRoute({List<_i6.PageRouteInfo>? children})
      : super(
          TasksRoute.name,
          initialChildren: children,
        );

  static const String name = 'TasksRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}
