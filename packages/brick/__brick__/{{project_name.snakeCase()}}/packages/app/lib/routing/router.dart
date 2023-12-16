import 'package:{{project_name.snakeCase()}}/routing/routing.dart';{{#use_auto_route_router}}import 'package:auto_route/auto_route.dart';{{/use_auto_route_router}}import 'package:flutter/widgets.dart';{{#use_go_router_router}}import 'package:go_router/go_router.dart';

part 'router.g.dart';{{/use_go_router_router}}{{#use_auto_route_router}}@AutoRouterConfig(
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
  ];
}{{/use_auto_route_router}}{{#use_go_router_router}}@TypedGoRoute<HomeRouteData>(
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
}{{/use_go_router_router}}