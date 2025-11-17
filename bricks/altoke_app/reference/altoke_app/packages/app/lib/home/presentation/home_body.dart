/*remove-start*/
import 'package:altoke_app/app/app.dart';
/*remove-end-x*/
import 'package:altoke_app/counter/counter.dart';
/*remove-start*/
import 'package:altoke_app/external/external.dart';
import 'package:altoke_app/routing/routing.dart';
import 'package:altoke_app/tasks/tasks.dart';
/*remove-end*/
/*w 1v w*/
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
