/*remove-start*/
import 'package:altoke_app/app/app.dart';
/*remove-end-x*/
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
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
/*x{{#use_go_router}}*/
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
/*x{{/use_go_router}}*/
import 'package:riverpod_annotation/riverpod_annotation.dart';

export 'routes/routes.dart';

part 'router.g.dart';

/*{{#use_auto_route}}x*/
@AutoRouterConfig(generateForDir: ['lib/routing/'])
class AppRouter extends RootStackRouter {
  AppRouter({@visibleForTesting this.testRoutes = const []});

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  late final List<AutoRoute> routes = [
    if (testRoutes.isEmpty) ...[
      AdaptiveRoute<void>(initial: true, path: '/', page: HomeRoute.page),
      AdaptiveRoute<void>(path: '/counter', page: CounterRoute.page),
      /*x-remove-start*/
      AdaptiveRoute<void>(path: '/tasks', page: TasksRoute.page),
      /*remove-end*/
    ] else
      ...testRoutes,
  ];

  @visibleForTesting
  final List<AutoRoute> testRoutes;
}

@Riverpod(dependencies: [])
/*replace-start*/
RouterConfig<UrlState> autoRouteConfig(Ref ref) {
  /*with*/
  // RouterConfig<UrlState> routerConfig(Ref ref) {
  /*replace-end*/
  final appRouter = AppRouter();
  ref.onDispose(appRouter.dispose);
  return appRouter.config();
}
/*x{{/use_auto_route}}x*/

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
  name: 'HomeRoute',
  routes: [
    TypedGoRoute<CounterRouteData>(path: 'counter', name: 'CounterRoute'),
    /*x-remove-start*/
    TypedGoRoute<TasksRouteData>(path: 'tasks', name: 'TasksRoute'),
    /*remove-end*/
  ],
)
class HomeRouteData extends GoRouteData with $HomeRouteData {
  const HomeRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

@Dependencies([
  Counter,
  /*x-remove-start*/
  SelectedStateManagementPackage,
  /*remove-end-x*/
])
class CounterRouteData extends GoRouteData with $CounterRouteData {
  const CounterRouteData();

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

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TasksScreen();
  }
}
// coverage:ignore-end
/*remove-end*/

@Riverpod(
  dependencies: [
    Counter,
    /*remove-start*/
    SelectedLocalDatabasePackage,
    SelectedRouterPackage,
    SelectedStateManagementPackage,
    asyncTasks,
    localTasksDao,
    /*remove-end-x*/
  ],
)
/*replace-start*/
RouterConfig<RouteMatchList> goRouterConfig(Ref ref) {
  /*with*/
  // RouterConfig<RouteMatchList> routerConfig(Ref ref) {
  /*replace-end*/
  final goRouter = GoRouter(
    routes: $appRoutes,
    debugLogDiagnostics: kDebugMode,
    initialLocation: const HomeRouteData().location,
  );
  ref.onDispose(goRouter.dispose);
  return goRouter;
}
/*x{{/use_go_router}}*/

/*drop*/
// coverage:ignore-start

@Riverpod(
  dependencies: [SelectedRouterPackage, autoRouteConfig, goRouterConfig],
)
RouterConfig<Object> routerConfig(Ref ref) {
  final routerPackage = ref.watch(selectedRouterPackagePod);
  final routerConfig = switch (routerPackage) {
    RouterPackage.autoRoute => ref.watch(autoRouteConfigPod),
    RouterPackage.goRouter => ref.watch(goRouterConfigPod),
  };
  return routerConfig;
}

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
