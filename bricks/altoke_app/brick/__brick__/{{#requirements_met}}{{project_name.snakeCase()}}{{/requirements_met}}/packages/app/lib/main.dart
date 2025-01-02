import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      observers: [
        LoggerProviderObserver(),
      ],
      child: MyApp(),
    ),
  );
}
