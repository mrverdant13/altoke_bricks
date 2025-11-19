/*remove-start*/
import 'package:altoke_app/app/app.dart';
/*remove-end*/
import 'package:altoke_app/counter/counter.dart';
/*remove-start*/
import 'package:altoke_app/external/external.dart';
/*remove-end-x*/
import 'package:altoke_app/routing/routing.dart';
/*remove-start*/
import 'package:altoke_app/tasks/tasks.dart';
/*remove-end-x*/
/*x{{#use_auto_route}}*/
import 'package:auto_route/auto_route.dart';
/*x{{/use_auto_route}}*/
import 'package:flutter/widgets.dart';
/*x{{#use_go_router}}*/
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
/*x{{/use_go_router}}*/
import 'package:riverpod_annotation/riverpod_annotation.dart';

export 'routes/routes.dart';

/*x{{#use_go_router}}x*/

part 'router.g.dart';
/*x{{/use_go_router}}*/

/*{{#use_auto_route}}x*/
@AutoRouterConfig(generateForDir: ['lib/routing/'])
class AppRouter extends RootStackRouter {
  AppRouter();

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  late final List<AutoRoute> routes = [
    AdaptiveRoute<void>(
      initial: true,
      path: '/',
      page: HomeRoute.page,
    ),
    AdaptiveRoute<void>(
      path: '/counter',
      page: CounterRoute.page,
    ),
    /*x-remove-start*/
    AdaptiveRoute<void>(
      path: '/tasks',
      page: TasksRoute.page,
    ),
    /*remove-end*/
  ];
}
/*x{{/use_auto_route}}*/

/*x{{#use_go_router}}x*/
@Dependencies([
  Counter,
  /*remove-start*/
  SelectedLocalDatabasePackage,
  SelectedRouterPackage,
  SelectedStateManagementPackage,
  asyncTasks,
  localTasksDao,
  /*remove-end-x*/
])
@TypedGoRoute<HomeRouteData>(
  path: '/',
  name: HomeRouteData.name,
  routes: [
    TypedGoRoute<CounterRouteData>(
      path: 'counter',
      name: CounterRouteData.name,
    ),
    /*x-remove-start*/
    TypedGoRoute<TasksRouteData>(
      path: 'tasks',
      name: TasksRouteData.name,
    ),
    /*remove-end*/
  ],
)
class HomeRouteData extends GoRouteData with $HomeRouteData {
  const HomeRouteData();

  static const name = 'HomeRoute';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

@Dependencies([
  Counter,
  /*remove-start*/
  SelectedStateManagementPackage,
  /*remove-end*/
])
class CounterRouteData extends GoRouteData with $CounterRouteData {
  const CounterRouteData();

  static const name = 'CounterRoute';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CounterScreen();
  }
}

/*x-remove-start*/
// coverage:ignore-start
@Dependencies([
  SelectedLocalDatabasePackage,
  asyncTasks,
  localTasksDao,
])
class TasksRouteData extends GoRouteData with $TasksRouteData {
  const TasksRouteData();

  static const name = 'TasksRoute';

  @visibleForTesting
  static GoRouterWidgetBuilder? testBuilder;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return testBuilder?.call(context, state) ?? const TasksScreen();
  }
}
// coverage:ignore-end
/*remove-end*/
/*x{{/use_go_router}}*/

/*drop*/
// coverage:ignore-start

enum RouterPackage {
  autoRoute('auto_route'),
  goRouter('go_router');

  const RouterPackage(this.identifier);

  final String identifier;
}

@Riverpod(dependencies: [], keepAlive: true)
class SelectedRouterPackage extends _$SelectedRouterPackage {
  @override
  RouterPackage build() {
    return RouterPackage.values.first;
  }

  // No getter is needed as the state should be accessed directly.
  // ignore: avoid_setters_without_getters
  set value(RouterPackage value) => state = value;
}

// coverage:ignore-end
