import 'package:altoke_app/app/app.dart';
import 'package:altoke_app/routing/routing.dart';
import 'package:altoke_app/tasks/tasks.dart';
/*{{#use_auto_route_router}}*/
import 'package:auto_route/auto_route.dart';
/*{{/use_auto_route_router}}*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

/*{{#use_auto_route_router}}*/
@RoutePage(
  name: 'TaskDetailsRoute',
)
/*{{/use_auto_route_router}}*/
class TaskDetailsScreen extends ConsumerWidget {
  const TaskDetailsScreen({
    /*w 1v w*/
    /*{{#use_auto_route_router}}*/
    @pathParam
    /*{{/use_auto_route_router}}*/
    /*w 1> w*/
    required this.taskId,
    super.key,
  });

  final int taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      tasksMutatorPod,
      (previousState, newState) {
        if (previousState is! TasksUpdatingTask) return;
        switch (newState) {
          case TasksMutationIdle():
            /*w 1v w*/
            /*remove-start*/
            final routerPackage = ref.read(routerPod);
            switch (routerPackage) {
              case RouterPackage.autoRoute:
                /*remove-end*/
                /*{{#use_auto_route_router}}*/
                context.navigateTo(const TasksRoute());
              /*{{/use_auto_route_router}}*/
              /*remove-start*/
              case RouterPackage.goRouter: /*remove-end*/
                /*{{#use_go_router_router}}*/
                const TasksRouteData().go(context);
              /*{{/use_go_router_router}}*/
              /*remove-start*/
            } /*remove-end*/
          /*w 1v w*/
          case TasksMutationFailure():
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text(
                    // TODO(mrverdant13): Localize.
                    'Failed to update task',
                  ),
                ),
              );
          case _:
          //
        }
      },
    );
    return ProviderScope(
      overrides: [
        scopedTaskIdPod.overrideWithValue(taskId),
      ],
      child: ReactiveFormBuilder(
        form: () => TaskFormGroup()..markAsDisabled(),
        builder: (context, formGroup, child) => child!,
        child: ScreenContent(taskId: taskId),
      ),
    );
  }
}

class ScreenContent extends ConsumerWidget {
  const ScreenContent({
    required this.taskId,
    super.key,
  });

  final int taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      asyncTaskPod.select(
        (asyncTask) => asyncTask.valueOrNull,
      ),
      (_, task) {
        if (task == null) return;
        ReactiveForm.of(context)! as TaskFormGroup
          ..titleControl.value = task.title
          ..descriptionControl.value = task.description
          ..markAsEnabled();
      },
    );
    final asyncTask = ref.watch(asyncTaskPod);
    const sliverNotFoundMessage = SliverFillRemaining(
      hasScrollBody: false,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 75,
            ),
            SizedBox(height: 10),
            Text(
              // TODO(mrverdant13): Localize.
              'No task found',
            ),
          ],
        ),
      ),
    );
    const sliverForm = SliverPadding(
      padding: EdgeInsets.all(15),
      sliver: SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.only(bottom: 100),
          child: TaskForm(),
        ),
      ),
    );
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverResponsiveAppBar(
            title: Text(
              ref
                  .watch(
                    asyncTaskPod.select(
                      (asyncTask) => asyncTask.whenData(
                        (task) => task != null,
                      ),
                    ),
                  )
                  .when(
                    // TODO(mrverdant13): Localize.
                    data: (taskExists) =>
                        taskExists ? 'Task details' : 'Task not found',
                    // TODO(mrverdant13): Localize.
                    error: (error, stackTrace) => 'Failed to load task',
                    // TODO(mrverdant13): Localize.
                    loading: () => 'Loading task',
                  ),
            ),
          ),
          asyncTask.when(
            data: (task) => task == null ? sliverNotFoundMessage : sliverForm,
            error: (error, stackTrace) => const SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  // TODO(mrverdant13): Localize.
                  'Failed to load task',
                ),
              ),
            ),
            loading: () => sliverForm,
          ),
        ],
      ),
      floatingActionButton:
          ReactiveForm.of(context)!.disabled ? null : const UpdateTaskFab(),
    );
  }
}
