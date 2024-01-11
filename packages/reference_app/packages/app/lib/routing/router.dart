import 'package:altoke_app/routing/routing.dart';
/*{{#use_auto_route_router}}*/
import 'package:auto_route/auto_route.dart';
/*{{/use_auto_route_router}}*/
import 'package:flutter/widgets.dart';
/*remove-start*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
/*remove-end*/
/*{{#use_go_router_router}}*/
import 'package:go_router/go_router.dart';

/*{{/use_go_router_router}}*/

part 'router.g.dart';

/*{{#use_auto_route_router}}*/
@AutoRouterConfig(
  generateForDir: ['lib/routing/'],
)
class AppRouter extends $AppRouter {
  @override // coverage:ignore-line
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  final List<AutoRoute> routes = [
    AdaptiveRoute(
      path: '/',
      title: (context, data) => 'Examples',
      page: HomeRoute.page,
    ),
    AdaptiveRoute(
      path: '/counter',
      title: (context, data) => 'Counter',
      page: CounterRoute.page,
    ),
    AdaptiveRoute(
      path: '/tasks',
      title: (context, data) => 'Tasks',
      page: TasksRoute.page,
    ),
    AdaptiveRoute(
      path: '/tasks/new',
      title: (context, data) => 'New Task',
      page: NewTaskRoute.page,
    ),
    AdaptiveRoute(
      path: '/tasks/:taskId',
      title: (context, data) => 'Task Details',
      page: TaskDetailsRoute.page,
    ),
  ];
}
/*{{/use_auto_route_router}}*/

/*{{#use_go_router_router}}*/
@TypedGoRoute<HomeRouteData>(
  path: '/',
  name: 'HomeRoute',
)
class HomeRouteData extends GoRouteData {
  const HomeRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

@TypedGoRoute<CounterRouteData>(
  path: '/counter',
  name: 'CounterRoute',
)
class CounterRouteData extends GoRouteData {
  const CounterRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CounterScreen();
  }
}

@TypedGoRoute<TasksRouteData>(
  path: '/tasks',
  name: 'TasksRoute',
)
class TasksRouteData extends GoRouteData {
  const TasksRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TasksScreen();
  }
}

@TypedGoRoute<NewTaskRouteData>(
  path: '/tasks/new',
  name: 'NewTaskRoute',
)
class NewTaskRouteData extends GoRouteData {
  const NewTaskRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const NewTaskScreen();
  }
}

@TypedGoRoute<TaskDetailsRouteData>(
  path: '/tasks/:taskId',
  name: 'TaskDetailsRoute',
)
class TaskDetailsRouteData extends GoRouteData {
  const TaskDetailsRouteData({
    required this.taskId,
  });

  final int taskId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TaskDetailsScreen(taskId: taskId);
  }
}
/*{{/use_go_router_router}}*/

/*drop*/
// coverage:ignore-start
enum RouterPackage {
  autoRoute('auto_route'),
  goRouter('go_router'),
  ;

  const RouterPackage(this.identifier);

  final String identifier;

  static final fromEnv = RouterPackage.values.firstWhere(
    (routerPackage) => routerPackage.identifier == routerIdentifier,
  );
}

@visibleForTesting
const routerIdentifier = String.fromEnvironment('REF_ALTOKE_ROUTER');

final routerPod = Provider<RouterPackage>(
  (_) => throw UnimplementedError(
    'No router package has been provided. ',
  ),
  name: 'routerPod',
  dependencies: const [],
);

// coverage:ignore-end
