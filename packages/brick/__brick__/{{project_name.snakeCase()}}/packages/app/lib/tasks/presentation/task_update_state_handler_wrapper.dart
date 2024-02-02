import 'package:{{project_name.snakeCase()}}/l10n/l10n.dart';
import 'package:{{project_name.snakeCase()}}/routing/routing.dart';
import 'package:{{project_name.snakeCase()}}/tasks/tasks.dart';{{#use_auto_route_router}}import 'package:auto_route/auto_route.dart';{{/use_auto_route_router}}import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_storage/tasks_storage.dart';

class TaskUpdateStateHandlerWrapper extends ConsumerWidget {
  const TaskUpdateStateHandlerWrapper({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      tasksMutatorPod,
      (previousState, newState) {
        if (previousState is! TasksUpdatingTask) return;
        switch (newState) {
          case TasksMutationIdle():
{{#use_auto_route_router}}context.navigateTo(const TasksRoute());{{/use_auto_route_router}}{{#use_go_router_router}}const TasksRouteData().go(context);{{/use_go_router_router}}
case TasksMutationFailure(:final error):
            error as UpdateTaskFailure;
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: SnackbarErrorContent(
                    error: error,
                  ),
                ),
              );
          case _:
          //
        }
      },
    );
    return child;
  }
}

@visibleForTesting
class SnackbarErrorContent extends ConsumerWidget {
  const SnackbarErrorContent({
    required this.error,
    super.key,
  });

  final UpdateTaskFailure error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return Text(
      key: const Key(
        '''<tasks:task-update-state-handler-wrapper:snackbar-content>''',
      ),
      switch (error) {
        UpdateTaskFailureEmptyTitle() =>
          l10n.tasksUpdateTaskFailureEmptyTitleSnackbarMessage,
      },
    );
  }
}
