import 'package:altoke_app/app/app.dart';
import 'package:altoke_app/counter/counter.dart';
/*remove-start*/
import 'package:altoke_app/external/external.dart';
/*remove-end*/
import 'package:altoke_app/routing/routing.dart';
/*remove-start*/
import 'package:altoke_app/tasks/tasks.dart';
/*remove-end*/
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@Dependencies([
  asyncInitialization,
  Counter,
  /*x-remove-start*/
  asyncTasks,
  localTasksDao,
  SelectedLocalDatabasePackage,
  SelectedRouterPackage,
  /*remove-end*/
])
Future<void> bootstrap({List<Override> overrides = const []}) async {
  WidgetsFlutterBinding.ensureInitialized();
  final appRouter = AppRouter();
  final goRouter = GoRouter(
    routes: $appRoutes,
    debugLogDiagnostics: kDebugMode,
    initialLocation: const HomeRouteData().location,
  );
  runApp(
    ProviderScope(
      overrides: overrides,
      observers: const [LoggerProviderObserver()],
      retry: (retryCount, error) => null, // Disable automatic retrying
      child: /*remove-start*/ Consumer(
        builder: (context, ref, child) {
          final selectedRouterPackage = ref.watch(selectedRouterPackagePod);
          return /*remove-end*/ MyApp(
            routerConfig: /*remove-start*/ switch (selectedRouterPackage) {
              RouterPackage.autoRoute => /*remove-end*/
                /*{{#use_auto_route}}*/ appRouter
                    .config() /*{{/use_auto_route}}*/ /*remove-start*/,
              RouterPackage.goRouter => /*remove-end*/
                /*{{#use_go_router}}*/ goRouter /*{{/use_go_router}}*/ /*remove-start*/,
            } /*remove-end*/,
          ) /*remove-start*/;
        },
      ) /*remove-end*/,
    ),
  );
}
