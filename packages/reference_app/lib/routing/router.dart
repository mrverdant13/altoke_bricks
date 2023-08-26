import 'package:altoke_app/routing/routing.dart';
import 'package:auto_route/auto_route.dart';

@AutoRouterConfig(
  generateForDir: ['lib/routing/'],
)
class AppRouter extends $AppRouter {
  @override
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
