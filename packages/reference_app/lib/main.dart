import 'package:altoke_app/app/app.dart';
import 'package:altoke_app/routing/routing.dart';
import 'package:flutter/material.dart';

void main() {
  final router = AppRouter();
  runApp(
    MyApp(
      router: router,
    ),
  );
}
