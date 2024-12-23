import 'dart:developer';

import 'package:{{projectName.snakeCase()}}/routing/routing.dart';{{#use_auto_route}}import 'package:auto_route/auto_route.dart';{{/use_auto_route}}import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';{{#use_go_router}}import 'package:go_router/go_router.dart';{{/use_go_router}}import 'package:riverpod_annotation/riverpod_annotation.dart';

export 'routes/routes.dart';

part 'router.g.dart';{{#use_auto_route}}@AutoRouterConfig(
  generateForDir: ['lib/routing/'],
)
class AppRouter extends RootStackRouter {
  AppRouter({
    @visibleForTesting this.testRoutes = const [],
  });

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  late final List<AutoRoute> routes = [
    if (testRoutes.isEmpty) ...[
      AdaptiveRoute<void>(
        initial: true,
        path: '/',
        page: HomeRoute.page,
      ),
      AdaptiveRoute<void>(
        path: '/counter',
        page: CounterRoute.page,
      ),
    ] else
      ...testRoutes,
  ];

  @visibleForTesting
  final List<AutoRoute> testRoutes;
}{{/use_auto_route}}{{#use_go_router}}@TypedGoRoute<HomeRouteData>(
  path: '/',
  name: 'HomeRoute',
  routes: [
    TypedGoRoute<CounterRouteData>(
      path: 'counter',
      name: 'CounterRoute',
    ),
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
}{{/use_go_router}}@Riverpod(
  dependencies: [],
)
RouterConfig<Object> routerConfig(Ref ref) {final routerConfig ={{#use_auto_route}}AppRouter().config(){{/use_auto_route}}{{#use_go_router}}GoRouter(
        routes: $appRoutes,
        debugLogDiagnostics: kDebugMode,
        initialLocation: const HomeRouteData().location,
      ){{/use_go_router}};
  final delegate = routerConfig.routerDelegate;

  // coverage:ignore-start
  void logCurrentUri() {
    if (!kDebugMode) return;
    final currentUri ={{#use_auto_route}}delegate.currentConfiguration!.uri{{/use_auto_route}}{{#use_go_router}}delegate.currentConfiguration.uri{{/use_go_router}};
    log(
      'path: <$currentUri>',
      name: 'Navigation',
    );
  }
  // coverage:ignore-end

  delegate.addListener(logCurrentUri);
  ref.onDispose(() => delegate.removeListener(logCurrentUri));

  return routerConfig;
}

