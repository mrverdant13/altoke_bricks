import 'package:altoke_app/app/app.dart';
import 'package:altoke_app/l10n/l10n.dart';
import 'package:altoke_app/routing/routing.dart';
import 'package:altoke_app/tasks/tasks.dart';
/*{{#use_auto_route_router}}*/
import 'package:auto_route/auto_route.dart';
/*{{/use_auto_route_router}}*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tasks_storage/tasks_storage.dart';

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
    final l10n = context.l10n;
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
          case TasksMutationFailure(:final error):
            error as UpdateTaskFailure;
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    switch (error) {
                      UpdateTaskFailureEmptyTitle() =>
                        l10n.tasksUpdateTaskFailureEmptyTitleSnackbarMessage,
                    },
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
    final l10n = context.l10n;
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
    final sliverNotFoundMessage = SliverFillRemaining(
      hasScrollBody: false,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 75,
            ),
            const SizedBox(height: 10),
            Text(
              l10n.tasksNoTaskFoundByIdMessage,
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
                    data: (taskExists) => taskExists
                        ? l10n.tasksExistingTaskDetailsAppBarTitle
                        : l10n.tasksNonExistingTaskDetailsAppBarTitle,
                    error: (_, __) => l10n.tasksErroredTaskDetailsAppBarTitle,
                    loading: () => l10n.tasksLoadingTaskDetailsAppBarTitle,
                  ),
            ),
          ),
          asyncTask.when(
            data: (task) => task == null ? sliverNotFoundMessage : sliverForm,
            error: (_, __) => SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  l10n.tasksUnexpectedErrorWhenLoadingTaskDetailsMessage,
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
