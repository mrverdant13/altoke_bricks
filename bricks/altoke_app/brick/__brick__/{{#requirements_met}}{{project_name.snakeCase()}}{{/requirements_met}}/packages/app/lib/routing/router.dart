
{{#use_riverpod}}
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/counter/counter.dart';
{{/use_riverpod}}
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/routing/routing.dart';{{#use_auto_route}}
import 'package:auto_route/auto_route.dart';{{/use_auto_route}}
{{#use_go_router}}
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';{{/use_go_router}}
{{#use_riverpod}}
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';{{/use_riverpod}}

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

{{#use_go_router}}{{#use_riverpod}}@Dependencies([
  Counter,
  ]){{/use_riverpod}}
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

{{#use_riverpod}}@Dependencies([
  Counter,
  
]){{/use_riverpod}}
class CounterRouteData extends GoRouteData with $CounterRouteData {
  const CounterRouteData();

  static const name = 'CounterRoute';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CounterScreen();
  }
}{{/use_go_router}}

