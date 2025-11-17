/*remove-start*/
import 'package:altoke_app/app/app.dart';
/*remove-end-x*/
import 'package:altoke_app/counter/counter.dart';
/*remove-start*/
import 'package:altoke_app/external/external.dart';
/*remove-end-x*/
import 'package:altoke_app/home/home.dart';
/*remove-start*/
import 'package:altoke_app/routing/routing.dart';
import 'package:altoke_app/tasks/tasks.dart';
/*remove-end-x*/
/*x{{#use_auto_route}}*/
import 'package:auto_route/auto_route.dart';
/*x{{/use_auto_route}}*/
import 'package:flutter/material.dart';
/*{{#use_riverpod}}*/
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([
  Counter,
  /*remove-start*/
  SelectedLocalDatabasePackage,
  SelectedRouterPackage,
  SelectedStateManagementPackage,
  asyncTasks,
  localTasksDao,
  /*remove-end-x*/
])
/*{{/use_riverpod}}*/
/*{{#use_auto_route}}x*/
@RoutePage(name: 'HomeRoute')
/*{{/use_auto_route}}x*/
class HomeScreen extends StatelessWidget {
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
