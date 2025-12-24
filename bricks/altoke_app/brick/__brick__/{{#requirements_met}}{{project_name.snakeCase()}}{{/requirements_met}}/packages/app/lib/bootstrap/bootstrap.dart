import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/app/app.dart';
{{#use_riverpod}}
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/counter/counter.dart';
{{/use_riverpod}}

import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/routing/routing.dart';

{{#use_go_router}}import 'package:flutter/foundation.dart';
{{/use_go_router}}import 'package:flutter/material.dart';{{#use_bloc}}
import 'package:flutter_bloc/{{#use_bloc}}flutter_bloc.dart{{/use_bloc}}';{{/use_bloc}}
{{#use_riverpod}}
import 'package:flutter_riverpod/flutter_riverpod.dart';
{{/use_riverpod}}
{{#use_go_router}}
import 'package:go_router/go_router.dart';{{/use_go_router}}
{{#use_bloc}}

{{/use_bloc}}
{{#use_riverpod}}
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';{{/use_riverpod}}

{{#use_riverpod}}@Dependencies([
  asyncInitialization,
  Counter,
]){{/use_riverpod}}

Future<void> bootstrap( {{#use_riverpod}} {
  List<Override> overrides = const [],
} {{/use_riverpod}} ) async {

  WidgetsFlutterBinding.ensureInitialized();
  {{#use_bloc}}
  Bloc.observer = const AppBlocObserver();
  {{/use_bloc}}
  {{#use_auto_route}}final appRouter = AppRouter();{{/use_auto_route}}{{#use_go_router}}final goRouter = GoRouter(
    routes: $appRoutes,
    debugLogDiagnostics: kDebugMode,
    initialLocation: const HomeRouteData().location,
  );{{/use_go_router}}
  runApp(
    {{#use_riverpod}} ProviderScope(
      overrides: overrides,
      observers: const [
        LoggerProviderObserver(),
      ],
      retry: (retryCount, error) => null, // Disable automatic retrying
      child:
          {{/use_riverpod}}
           {{#use_bloc}} BlocProvider(
                create: (context) => AppInitializationBloc(
                  // Defining a general purpose TODO
                  // ignore: flutter_style_todos
                  // TODO: Provide initialization callbacks or dependencies.
                  initializationCallback: () async {},
                  
                )..add(const AppInitializationRequested()),
                child: {{/use_bloc}} MyApp(
                  routerConfig:
                      
                          {{#use_auto_route}} appRouter
                              .config() {{/use_auto_route}} 
                          {{#use_go_router}} goRouter {{/use_go_router}} ,
                ) {{#use_bloc}},
              ) {{/use_bloc}}
               {{#use_riverpod}},
    ) {{/use_riverpod}},
  );
}
