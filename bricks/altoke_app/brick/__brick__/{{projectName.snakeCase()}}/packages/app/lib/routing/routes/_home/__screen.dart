import 'package:{{projectName.snakeCase()}}/home/home.dart';{{#use_auto_route}}import 'package:auto_route/auto_route.dart';{{/use_auto_route}}import 'package:flutter/material.dart';{{#use_auto_route}}@RoutePage(
  name: 'HomeRoute',
){{/use_auto_route}}class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

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
