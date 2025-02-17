import 'dart:developer';

import 'package:altoke_app/routing/routing.dart';
/*{{#use_auto_route}}*/
import 'package:auto_route/auto_route.dart';
/*{{/use_auto_route}}*/
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
/*{{#use_go_router}}*/
import 'package:go_router/go_router.dart';
/*{{/use_go_router}}*/
import 'package:riverpod_annotation/riverpod_annotation.dart';

export 'routes/routes.dart';

part 'router.g.dart';

/*{{#use_auto_route}}*/
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
      /*remove-start*/
      AdaptiveRoute<void>(path: '/tasks', page: TasksRoute.page),
      /*remove-end*/
      /*w 1v 4> w*/
    ] else
      ...testRoutes,
  ];

  @visibleForTesting
  final List<AutoRoute> testRoutes;
}
/*{{/use_auto_route}}*/

/*{{#use_go_router}}*/
@TypedGoRoute<HomeRouteData>(
  path: '/',
  name: 'HomeRoute',
  routes: [
    TypedGoRoute<CounterRouteData>(path: 'counter', name: 'CounterRoute'),
    /*remove-start*/
    TypedGoRoute<TasksRouteData>(path: 'tasks', name: 'TasksRoute'),
    /*remove-end*/
    /*w 1v 2> w*/
  ],
)
class HomeRouteData extends GoRouteData {
  const HomeRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

class CounterRouteData extends GoRouteData {
  const CounterRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CounterScreen();
  }
}

/*remove-start*/
// coverage:ignore-start
class TasksRouteData extends GoRouteData {
  const TasksRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TasksScreen();
  }
}
// coverage:ignore-end
/*remove-end*/
/*{{/use_go_router}}*/

@Riverpod(
  dependencies: [
    /*remove-start*/
    SelectedRouterPackage,
    /*remove-end*/
  ],
)
RouterConfig<Object> routerConfig(Ref ref) {
  /*remove-start*/
  final routerPackage = ref.watch(selectedRouterPackagePod);
  /*remove-end*/
  final routerConfig = /*remove-start*/
      switch (routerPackage) {
            RouterPackage.autoRoute =>
              /*remove-end*/
              /*{{#use_auto_route}}*/
              AppRouter().config() /*{{/use_auto_route}}*/ /*remove-start*/,
            RouterPackage.goRouter => /*remove-end*/
            /*{{#use_go_router}}*/
            GoRouter(
              routes: $appRoutes,
              debugLogDiagnostics: kDebugMode,
              initialLocation: const HomeRouteData().location,
            ) /*{{/use_go_router}}*/ /*remove-start*/,
          }
          as RouterConfig<Object> /*remove-end*/;
  final delegate = routerConfig.routerDelegate;

  // coverage:ignore-start
  void logCurrentUri() {
    if (!kDebugMode) return;
    final currentUri = /*remove-start*/ switch (delegate) {
      RouterDelegate<UrlState>() =>
        /*remove-end*/
        /*{{#use_auto_route}}*/
        delegate
            .currentConfiguration!
            .uri /*{{/use_auto_route}}*/ /*remove-start*/,
      GoRouterDelegate() => /*remove-end*/
        /*{{#use_go_router}}*/
        delegate
            .currentConfiguration
            .uri /*{{/use_go_router}}*/ /*remove-start*/,
      _ => throw UnimplementedError(),
    }
    /*remove-end*/
    ;
    log('path: <$currentUri>', name: 'Navigation');
  }
  // coverage:ignore-end

  delegate.addListener(logCurrentUri);
  ref.onDispose(() => delegate.removeListener(logCurrentUri));

  return routerConfig;
}

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
