import 'dart:developer';

import 'package:{{projectName.snakeCase()}}/routing/routing.dart';{{#use_auto_route}}import 'package:auto_route/auto_route.dart';{{/use_auto_route}}import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';{{#use_go_router}}import 'package:go_router/go_router.dart';{{/use_go_router}}import 'package:riverpod_annotation/riverpod_annotation.dart';

export 'routes/routes.dart';{{#use_go_router}}part 'router.g.dart';{{/use_go_router}}{{#use_auto_route}}@AutoRouterConfig(
  generateForDir: ['lib/routing/'],
)
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  final List<AutoRoute> routes = [
    AdaptiveRoute(
      initial: true,
      path: '/counter',
      title: (context, data) => 'Counter',
      page: CounterRoute.page,
    ),
  ];
}{{/use_auto_route}}{{#use_go_router}}@TypedGoRoute<CounterRouteData>(
  path: '/counter',
  name: 'CounterRoute',
)
class CounterRouteData extends GoRouteData {
  const CounterRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CounterScreen();
  }
}{{/use_go_router}}@Riverpod(
  dependencies: [],
)
RouterConfig<Object> routerConfig(RouterConfigRef ref) {final routerConfig ={{#use_auto_route}}AppRouter().config(){{/use_auto_route}}{{#use_go_router}}GoRouter(
        routes: $appRoutes,
        debugLogDiagnostics: kDebugMode,
        initialLocation: const CounterRouteData().location,
      ){{/use_go_router}};
  final delegate = routerConfig.routerDelegate;

  void logCurrentUri() {
    if (!kDebugMode) return;
    final currentUri ={{#use_auto_route}}delegate.currentConfiguration!.uri{{/use_auto_route}}{{#use_go_router}}delegate.currentConfiguration.uri{{/use_go_router}}};
    log(
      'path: <$currentUri>',
      name: 'Navigation',
    );
  }

  delegate.addListener(logCurrentUri);
  ref.onDispose(() => delegate.removeListener(logCurrentUri));

  return routerConfig;
}

