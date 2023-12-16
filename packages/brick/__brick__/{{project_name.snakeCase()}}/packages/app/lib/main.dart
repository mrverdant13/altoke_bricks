import 'package:{{project_name.snakeCase()}}/app/app.dart';
import 'package:{{project_name.snakeCase()}}/routing/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';{{#use_go_router_router}}import 'package:go_router/go_router.dart';{{/use_go_router_router}}void main() {
  WidgetsFlutterBinding.ensureInitialized();final routerConfig ={{#use_auto_route_router}}AppRouter().config(){{/use_auto_route_router}}{{#use_go_router_router}}GoRouter(routes: $appRoutes){{/use_go_router_router}};
  runApp(
    ProviderScope(child: MyApp(
        routerConfig: routerConfig as RouterConfig<Object>,
      ),
    ),
  );
}
