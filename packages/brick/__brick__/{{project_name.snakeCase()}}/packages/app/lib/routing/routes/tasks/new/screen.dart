import 'package:{{project_name.snakeCase()}}/tasks/tasks.dart';{{#use_auto_route_router}}import 'package:auto_route/auto_route.dart';{{/use_auto_route_router}}import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';{{#use_auto_route_router}}@RoutePage(
  name: 'NewTaskRoute',
){{/use_auto_route_router}}class NewTaskScreen extends ConsumerWidget {
  const NewTaskScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TaskCreationStateHandlerWrapper(
      child: ReactiveFormBuilder(
        form: TaskFormGroup.new,
        builder: (context, formGroup, child) => child!,
        child: const NewTaskScreenLayout(),
      ),
    );
  }
}

class NewTaskScreenLayout extends ConsumerWidget {
  const NewTaskScreenLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverNewTaskAppBar(),
          SliverPadding(
            padding: EdgeInsets.all(15),
            sliver: SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(bottom: 100),
                child: TaskForm(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: AddTaskFab(),
    );
  }
}
