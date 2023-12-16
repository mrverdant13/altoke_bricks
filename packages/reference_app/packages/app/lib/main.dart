import 'package:altoke_app/app/app.dart';
import 'package:altoke_app/routing/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
/*{{#use_go_router_router}}*/
import 'package:go_router/go_router.dart';
/*{{/use_go_router_router}}*/

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  /*remove-start*/
  final routerPackage = RouterPackage.fromEnv;
  /*remove-end*/
  final routerConfig = /*remove-start*/ switch (routerPackage) {
    RouterPackage.autoRoute =>
      /*remove-end*/
      /*{{#use_auto_route_router}}*/
      AppRouter().config()
    /*{{/use_auto_route_router}}*/
    /*remove-start*/,
    RouterPackage.goRouter => /*remove-end*/
      /*{{#use_go_router_router}}*/
      GoRouter(routes: $appRoutes)
    /*{{/use_go_router_router}}*/
    /*remove-start*/,
  } /*remove-end*/;
  runApp(
    ProviderScope(
      /*remove-start*/
      overrides: [
        routerPod.overrideWithValue(routerPackage),
      ],
      /*remove-end*/
      child: MyApp(
        routerConfig: routerConfig as RouterConfig<Object>,
      ),
    ),
  );
}
