import 'dart:math' as math;

import 'package:altoke_app/tasks/tasks.dart';
/*{{#use_auto_route}}*/
import 'package:auto_route/auto_route.dart';
/*{{/use_auto_route}}*/
import 'package:flutter/material.dart';

/*{{#use_auto_route}}*/
@RoutePage(
  name: 'TasksRoute',
)
/*{{/use_auto_route}}*/
class TasksScreen extends StatelessWidget {
  const TasksScreen({
    super.key,
  });

  @visibleForTesting
  static const maxContentWidth = 800.0;

  @override
  Widget build(BuildContext context) {
    final tasksAppBar = TasksAppBar();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: tasksAppBar.preferredSize,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: maxContentWidth),
            child: tasksAppBar,
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: maxContentWidth),
          child: const TasksList(),
        ),
      ),
      floatingActionButton: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final padding = math.max<double>(0, (width - maxContentWidth) / 2);
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: const ShowTaskCreationDialogFab(),
          );
        },
      ),
    );
  }
}
