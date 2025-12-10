import 'package:altoke_app/app/app.dart';
/*{{#use_riverpod}}*/
import 'package:altoke_app/counter/counter.dart';
/*{{/use_riverpod}}*/
/*remove-start*/
import 'package:altoke_app/external/external.dart';
/*remove-end*/
import 'package:altoke_app/routing/routing.dart';
/*remove-start*/
import 'package:altoke_app/tasks/tasks.dart';
/*remove-end*/
/*{{#use_go_router}}x*/
import 'package:flutter/foundation.dart';
/*{{/use_go_router}}x*/
import 'package:flutter/material.dart';
/*x{{#use_bloc}}*/
import 'package:flutter_bloc/flutter_bloc.dart';
/*x{{/use_bloc}}*/
/*{{#use_riverpod}}*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
/*{{/use_riverpod}}*/
/*x{{#use_go_router}}*/
import 'package:go_router/go_router.dart';
/*x{{/use_go_router}}*/
/*x{{#use_bloc}}*/
/*remove-start*/
import 'package:path_provider/path_provider.dart';
/*remove-end*/
/*x{{/use_bloc}}*/
/*x{{#use_riverpod}}*/
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
/*x{{/use_riverpod}}*/

@Dependencies([
  asyncInitialization,
  Counter,
  /*x-remove-start*/
  asyncTasks,
  localTasksDao,
  SelectedLocalDatabasePackage,
  SelectedRouterPackage,
  SelectedStateManagementPackage,
  /*remove-end*/
])
/*remove-start*/
// dart format off
/*remove-end*/
Future<void> bootstrap( /*{{#use_riverpod}}*/ {
  List<Override> overrides = const [],
} /*{{/use_riverpod}}*/ ) async {
/*remove-start*/
// dart format on
  /*remove-end*/
  WidgetsFlutterBinding.ensureInitialized();
  /*{{#use_auto_route}}x*/
  final appRouter = AppRouter();
  /*x{{/use_auto_route}}x*/
  /*x{{#use_go_router}}x*/
  final goRouter = GoRouter(
    routes: $appRoutes,
    debugLogDiagnostics: kDebugMode,
    initialLocation: const HomeRouteData().location,
  );
  /*x{{/use_go_router}}*/
  runApp(
    /*{{#use_riverpod}}*/ ProviderScope(
      overrides: overrides,
      observers: const [
        LoggerProviderObserver(),
      ],
      retry: (retryCount, error) => null, // Disable automatic retrying
      child:
          /*{{/use_riverpod}}*/
          /*remove-start*/
          Consumer(
            builder: (context, ref, child) {
              final selectedRouterPackage = ref.watch(selectedRouterPackagePod);
              return /*remove-end*/ /*{{#use_bloc}}*/ BlocProvider(
                create: (context) => AppInitializationBloc(
                  // Defining a general purpose TODO
                  // ignore: flutter_style_todos
                  // TODO: Provide initialization callbacks or dependencies.
                  initializationCallback: () async {},
                  /*remove-start*/
                  applicationDocumentsDirectoryGetter:
                      getApplicationDocumentsDirectory,
                  temporaryDirectoryGetter: getTemporaryDirectory,
                  localDatabaseBuilder: buildLocalDatabase,
                  hiveInitializer: initializeHive,
                  /*remove-end*/
                )..add(const AppInitializationRequested()),
                child: /*{{/use_bloc}}*/ MyApp(
                  routerConfig:
                      /*remove-start*/
                      switch (selectedRouterPackage) {
                        RouterPackage.autoRoute => /*remove-end*/
                          /*{{#use_auto_route}}*/ appRouter
                              .config() /*{{/use_auto_route}}*/ /*remove-start*/,
                        RouterPackage.goRouter => /*remove-end*/
                          /*{{#use_go_router}}*/ goRouter /*{{/use_go_router}}*/ /*remove-start*/,
                      } /*remove-end*/,
                ) /*{{#use_bloc}}*/,
              ) /*{{/use_bloc}}*/
              /*remove-start*/;
            },
          ) /*remove-end*/ /*{{#use_riverpod}}*/,
    ) /*{{/use_riverpod}}*/,
  );
}
