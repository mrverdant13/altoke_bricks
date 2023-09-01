import 'package:altoke_app/routing/routing.dart';
/*{{#use_auto_route_router}}*/
import 'package:auto_route/auto_route.dart';
/*{{/use_auto_route_router}}*/
import 'package:flutter/widgets.dart';
/*{{#use_go_router_router}}*/
import 'package:go_router/go_router.dart';

part 'router.g.dart';
/*{{/use_go_router_router}}*/

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
/*{{/use_go_router_router}}*/

/*drop*/
enum RouterPackage {
  autoRoute('auto_route'),
  goRouter('go_router'),
  ;

  const RouterPackage(this.identifier);

  final String identifier;

  static late final fromEnv = RouterPackage.values.firstWhere(
    (routerPackage) => routerPackage.identifier == routerIdentifier,
  );

  static RouterPackage of(BuildContext context) {
    return InheritedRouterPackage.of(context).package;
  }
}

@visibleForTesting
const routerIdentifier = String.fromEnvironment('REF_ALTOKE_ROUTER');

class InheritedRouterPackage extends InheritedWidget {
  const InheritedRouterPackage({
    super.key,
    required this.package,
    required super.child,
  });

  final RouterPackage package;

  static InheritedRouterPackage? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedRouterPackage>();
  }

  static InheritedRouterPackage of(BuildContext context) {
    final InheritedRouterPackage? result = maybeOf(context);
    assert(result != null, 'No InheritedRouterPackage found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedRouterPackage oldWidget) {
    return package != oldWidget.package;
  }
}
