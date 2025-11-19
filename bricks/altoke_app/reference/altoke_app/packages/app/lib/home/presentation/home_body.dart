/*remove-start*/
import 'package:altoke_app/app/app.dart';
/*remove-end*/
import 'package:altoke_app/counter/counter.dart';
/*remove-start*/
import 'package:altoke_app/external/external.dart';
import 'package:altoke_app/routing/routing.dart';
import 'package:altoke_app/tasks/tasks.dart';
/*remove-end*/
/*w 1v w*/
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([
  Counter,
  /*remove-start*/
  asyncTasks,
  localTasksDao,
  SelectedLocalDatabasePackage,
  SelectedRouterPackage,
  SelectedStateManagementPackage,
  /*remove-end-x*/
])
class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        CounterExampleListTile(),
        /*remove-start*/
        TasksExampleListTile(),
        /*remove-end*/
        /*w 1v 6> w*/
      ],
    );
  }
}
