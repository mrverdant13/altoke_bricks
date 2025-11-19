import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/counter/counter.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/routing/routing.dart';{{#use_auto_route}}
import 'package:auto_route/auto_route.dart';{{/use_auto_route}}
import 'package:flutter/widgets.dart';{{#use_go_router}}
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/experimental/scope.dart';{{/use_go_router}}
import 'package:riverpod_annotation/riverpod_annotation.dart';

export 'routes/routes.dart';{{#use_go_router}}part 'router.g.dart';{{/use_go_router}}

{{#use_auto_route}}@AutoRouterConfig(generateForDir: ['lib/routing/'])
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
  ];
}{{/use_auto_route}}

{{#use_go_router}}@Dependencies([
  Counter,
  ])
@TypedGoRoute<HomeRouteData>(
  path: '/',
  name: HomeRouteData.name,
  routes: [
    TypedGoRoute<CounterRouteData>(
      path: 'counter',
      name: CounterRouteData.name,
    ),
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
])
class CounterRouteData extends GoRouteData with $CounterRouteData {
  const CounterRouteData();

  static const name = 'CounterRoute';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CounterScreen();
  }
}{{/use_go_router}}

