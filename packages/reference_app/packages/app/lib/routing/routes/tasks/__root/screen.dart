import 'package:altoke_app/tasks/tasks.dart';
/*{{#use_auto_route_router}}*/
import 'package:auto_route/auto_route.dart';
/*{{/use_auto_route_router}}*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*{{#use_auto_route_router}}*/
@RoutePage(
  name: 'TasksRoute',
)
/*{{/use_auto_route_router}}*/
class TasksScreen extends ConsumerWidget {
  const TasksScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const TasksScreenLayout();
  }
}

@visibleForTesting
class TasksScreenLayout extends ConsumerWidget {
  const TasksScreenLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverTasksAppBar(),
          SliverTasksFilterControls(),
          SliverTasksList(),
        ],
      ),
      floatingActionButton: NewTaskFab(),
    );
  }
}
