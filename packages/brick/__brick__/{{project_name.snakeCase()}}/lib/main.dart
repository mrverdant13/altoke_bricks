import 'package:{{project_name.snakeCase()}}/app/app.dart';
import 'package:{{project_name.snakeCase()}}/routing/routing.dart';
import 'package:flutter/material.dart';

void main() {
  final router = AppRouter();
  runApp(
    MyApp(
      router: router,
    ),
  );
}
