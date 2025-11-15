import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/counter/counter.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/routing/routing.dart';{{#use_auto_route}}
import 'package:auto_route/auto_route.dart';{{/use_auto_route}}
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';{{#use_go_router}}
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/experimental/scope.dart';{{/use_go_router}}
import 'package:riverpod_annotation/riverpod_annotation.dart';

export 'routes/routes.dart';

part 'router.g.dart';

{{#use_auto_route}}@AutoRouterConfig(generateForDir: ['lib/routing/'])
class AppRouter extends RootStackRouter {
  AppRouter({@visibleForTesting this.testRoutes = const []});

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  late final List<AutoRoute> routes = [
    if (testRoutes.isEmpty) ...[
      AdaptiveRoute<void>(initial: true, path: '/', page: HomeRoute.page),
      AdaptiveRoute<void>(path: '/counter', page: CounterRoute.page),
    ] else
      ...testRoutes,
  ];

  @visibleForTesting
  final List<AutoRoute> testRoutes;
}

@Riverpod(dependencies: [])
RouterConfig<UrlState> routerConfig(Ref ref) {
  final appRouter = AppRouter();
  ref.onDispose(appRouter.dispose);
  return appRouter.config();
}{{/use_auto_route}}{{#use_go_router}}@Dependencies([
  Counter,
  ])
@TypedGoRoute<HomeRouteData>(
  path: '/',
  name: 'HomeRoute',
  routes: [
    TypedGoRoute<CounterRouteData>(path: 'counter', name: 'CounterRoute'),
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
])
class CounterRouteData extends GoRouteData with $CounterRouteData {
  const CounterRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CounterScreen();
  }
}

@Riverpod(
  dependencies: [
    Counter,
    ],
)
RouterConfig<RouteMatchList> routerConfig(Ref ref) {
  final goRouter = GoRouter(
    routes: $appRoutes,
    debugLogDiagnostics: kDebugMode,
    initialLocation: const HomeRouteData().location,
  );
  ref.onDispose(goRouter.dispose);
  return goRouter;
}{{/use_go_router}}

