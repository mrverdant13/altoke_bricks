import 'dart:developer';

import 'package:altoke_app/routing/routing.dart';
/*{{#use_auto_route}}*/
import 'package:auto_route/auto_route.dart';
/*{{/use_auto_route}}*/
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
/*{{#use_go_router}}*/
import 'package:go_router/go_router.dart';
/*{{/use_go_router}}*/
import 'package:riverpod_annotation/riverpod_annotation.dart';

export 'routes/routes.dart';

part 'router.g.dart';

/*{{#use_auto_route}}*/
@AutoRouterConfig(
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
}
/*{{/use_auto_route}}*/

/*{{#use_go_router}}*/
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
/*{{/use_go_router}}*/

@Riverpod(
  dependencies: [
    /*remove-start*/
    routerPackage,
    /*remove-end*/
  ],
)
RouterConfig<Object> routerConfig(RouterConfigRef ref) {
  /*remove-start*/
  final routerPackage = ref.watch(routerPackagePod);
  /*remove-end*/
  final routerConfig = /*remove-start*/ switch (routerPackage) {
    RouterPackage.autoRoute =>
      /*remove-end*/
      /*{{#use_auto_route}}*/
      AppRouter().config()
    /*{{/use_auto_route}}*/
    /*remove-start*/,
    RouterPackage.goRouter => /*remove-end*/
      /*{{#use_go_router}}*/
      GoRouter(
        routes: $appRoutes,
        debugLogDiagnostics: kDebugMode,
        initialLocation: const CounterRouteData().location,
      )
    /*{{/use_go_router}}*/
    /*remove-start*/,
  } as RouterConfig<Object> /*remove-end*/;
  final delegate = routerConfig.routerDelegate;

  void logCurrentUri() {
    if (!kDebugMode) return;
    final currentUri = /*remove-start*/
        switch (delegate) {
      RouterDelegate<UrlState>() =>
        /*remove-end*/
        /*{{#use_auto_route}}*/
        delegate.currentConfiguration!.uri
      /*{{/use_auto_route}}*/
      /*remove-start*/,
      GoRouterDelegate() => /*remove-end*/
        /*{{#use_go_router}}*/
        delegate.currentConfiguration.uri
      /*{{/use_go_router}}*/
      /*remove-start*/,
      // coverage:ignore-start
      _ => throw UnimplementedError(),
      // coverage:ignore-end
    }
        /*remove-end*/
        ;
    log(
      'path: <$currentUri>',
      name: 'Navigation',
    );
  }

  delegate.addListener(logCurrentUri);
  ref.onDispose(() => delegate.removeListener(logCurrentUri));

  return routerConfig;
}

/*drop*/
// coverage:ignore-start
enum RouterPackage {
  autoRoute('auto_route'),
  goRouter('go_router'),
  ;

  const RouterPackage(this.identifier);

  final String identifier;

  static final fromEnv = RouterPackage.values.firstWhere(
    (routerPackage) => routerPackage.identifier == routerIdentifier,
  );
}

@visibleForTesting
const routerIdentifier = String.fromEnvironment('ALTOKE_APP_ROUTER');

@Riverpod(
  dependencies: [],
)
RouterPackage routerPackage(RouterPackageRef ref) => RouterPackage.fromEnv;
// coverage:ignore-end
