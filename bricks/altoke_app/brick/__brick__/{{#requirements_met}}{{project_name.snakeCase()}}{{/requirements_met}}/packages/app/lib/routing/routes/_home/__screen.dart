
{{#use_riverpod}}
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/counter/counter.dart';
{{/use_riverpod}}
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/home/home.dart';{{#use_auto_route}}
import 'package:auto_route/auto_route.dart';{{/use_auto_route}}
import 'package:flutter/material.dart';
{{#use_riverpod}}
import 'package:riverpod_annotation/experimental/scope.dart';
{{/use_riverpod}}

{{#use_riverpod}}@Dependencies([
  Counter,
  ]){{/use_riverpod}}
{{#use_auto_route}}@RoutePage(name: 'HomeRoute')
{{/use_auto_route}}class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @visibleForTesting
  static const maxContentWidth = 1200.0;

  @override
  Widget build(BuildContext context) {
    final homeAppBar = HomeAppBar();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: homeAppBar.preferredSize,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: maxContentWidth),
            child: homeAppBar,
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: maxContentWidth),
          child: const HomeBody(),
        ),
      ),
    );
  }
}
