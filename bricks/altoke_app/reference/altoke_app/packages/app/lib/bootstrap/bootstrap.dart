import 'package:altoke_app/app/app.dart';
import 'package:altoke_app/routing/routing.dart';
import 'package:flutter/material.dart';
/*{{#use_bloc}}*/
import 'package:flutter_bloc/flutter_bloc.dart';
/*{{/use_bloc}}*/
/*{{#use_riverpod}}*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@Dependencies([
  routerConfig,
  asyncInitialization,
  /*x-remove-start*/
  SelectedRouterPackage,
  SelectedStateManagementPackage,
  /*remove-end*/
])
/*{{/use_riverpod}}*/
Future<void> bootstrap({List<Override> overrides = const []}) async {
  WidgetsFlutterBinding.ensureInitialized();
  /*{{#use_bloc}}*/
  Bloc.observer = const AppBlocObserver();
  /*{{/use_bloc}}*/
  runApp(
    /*{{#use_riverpod}}*/
    ProviderScope(
      overrides: overrides,
      observers: const [LoggerProviderObserver()],
      retry: (retryCount, error) => null, // Disable automatic retrying
      child: /*{{/use_riverpod}}*/ const MyApp() /*{{#use_riverpod}}x*/,
    ) /*{{/use_riverpod}}*/,
  );
}
