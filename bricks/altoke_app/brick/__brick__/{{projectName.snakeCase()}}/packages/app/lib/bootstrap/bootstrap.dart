import 'package:{{projectName.snakeCase()}}/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> bootstrap({
  List<Override> overrides = const [],
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      overrides: overrides,
      observers: const [
        LoggerProviderObserver(),
      ],
      child: const MyApp(),
    ),
  );
}
