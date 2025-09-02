import 'package:altoke_app/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

Future<void> bootstrap({List<Override> overrides = const []}) async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      overrides: overrides,
      observers: const [LoggerProviderObserver()],
      retry: (retryCount, error) => null, // Disable automatic retrying
      child: const MyApp(),
    ),
  );
}
