import 'package:altoke_app/app/app.dart';
import 'package:altoke_app/routing/routing.dart';
import 'package:flutter/material.dart';
/*{{#use_go_router_router}}*/
import 'package:go_router/go_router.dart';
/*{{/use_go_router_router}}*/

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final routerConfig = /*remove-start*/ switch (RouterPackage.fromEnv) {
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
    /*remove-start*/
    InheritedRouterPackage(
      package: RouterPackage.fromEnv,
      child: /*remove-end*/ MyApp(
        routerConfig: routerConfig as RouterConfig<Object>,
      ),
      /*remove-start*/
    ), /*remove-end*/
  );
}
