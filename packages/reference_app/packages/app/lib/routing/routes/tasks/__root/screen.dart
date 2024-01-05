import 'package:altoke_app/tasks/tasks.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage(
  name: 'TasksRoute',
)
class TasksScreen extends ConsumerWidget {
  const TasksScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
          ),
          SliverTasksList(),
        ],
      ),
      floatingActionButton: NewTaskFab(),
    );
  }
}
