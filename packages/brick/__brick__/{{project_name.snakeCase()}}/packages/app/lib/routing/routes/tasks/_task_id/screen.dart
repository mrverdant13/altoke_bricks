import 'package:{{project_name.snakeCase()}}/tasks/tasks.dart';{{#use_auto_route_router}}import 'package:auto_route/auto_route.dart';{{/use_auto_route_router}}import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';{{#use_auto_route_router}}@RoutePage(
  name: 'TaskDetailsRoute',
){{/use_auto_route_router}}class TaskDetailsScreen extends ConsumerWidget {
  const TaskDetailsScreen({
{{#use_auto_route_router}}@pathParam{{/use_auto_route_router}} required this.taskId,
    super.key,
  });

  final int taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TaskUpdateStateHandlerWrapper(
      child: ProviderScope(
        overrides: [
          scopedTaskIdPod.overrideWithValue(taskId),
        ],
        child: ReactiveFormBuilder(
          form: () => TaskFormGroup()..markAsDisabled(),
          builder: (context, formGroup, child) => child!,
          child: const TaskDetailsFormInitializerWrapper(
            child: TaskDetailsScreenLayout(),
          ),
        ),
      ),
    );
  }
}

@visibleForTesting
class TaskDetailsScreenLayout extends ConsumerWidget {
  const TaskDetailsScreenLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTask = ref.watch(asyncTaskPod);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverTaskDetailsAppBar(),
          asyncTask.when(
            data: (task) => task == null
                ? const SliverFillRemainingWithTaskNotFoundError()
                : const SliverTaskForm(),
            error: (_, __) => const SliverFillRemainingWithErrorOnTaskLoad(),
            loading: () => const SliverTaskForm(),
          ),
        ],
      ),
      floatingActionButton:
          ReactiveForm.of(context)!.disabled ? null : const UpdateTaskFab(),
    );
  }
}

@visibleForTesting
class SliverTaskForm extends ConsumerWidget {
  const SliverTaskForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SliverPadding(
      padding: EdgeInsets.all(15),
      sliver: SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.only(bottom: 100),
          child: TaskForm(),
        ),
      ),
    );
  }
}
