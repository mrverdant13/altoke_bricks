import 'package:{{project_name.snakeCase()}}/app/app.dart';
import 'package:{{project_name.snakeCase()}}/l10n/l10n.dart';
import 'package:{{project_name.snakeCase()}}/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SliverTaskDetailsAppBar extends ConsumerWidget {
  const SliverTaskDetailsAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return SliverResponsiveAppBar(
      title: Text(
        key: const Key('<tasks:sliver-task-details-app-bar:title>'),
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
    );
  }
}
