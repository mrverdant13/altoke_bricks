import 'package:altoke_app/app/app.dart';
import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SliverTasksAppBar extends ConsumerWidget {
  const SliverTasksAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SliverResponsiveAppBar(
      title: Text(
        // TODO(mrverdant13): Localize.
        'Tasks',
        key: Key('<tasks::sliver-tasks-app-bar::title>'),
      ),
      actions: [
        MarkAllTasksAsCompletedButton(),
        DeleteCompletedTasksButton(),
      ],
    );
  }
}

class MarkAllTasksAsCompletedButton extends ConsumerWidget {
  const MarkAllTasksAsCompletedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<TasksMutationState>(
      tasksMutatorPod,
      (previousState, newState) {
        if (previousState is! TasksMarkingAllAsCompleted) return;
        final message = switch (newState) {
          // TODO(mrverdant13): Localize.
          TasksMutationIdle() => 'All tasks marked as completed',
          // TODO(mrverdant13): Localize.
          TasksMutationFailure() => 'Failed to mark all tasks as completed',
          _ => null,
        };
        if (message == null) return;
        final snackBar = SnackBar(
          content: Text(message),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      },
    );
    return IconButton(
      // TODO(mrverdant13): Localize.
      tooltip: 'Mark all tasks as completed',
      icon: const Icon(Icons.done_all),
      onPressed: () {
        ref.read(tasksMutatorPod.notifier).markAllAsCompleted();
      },
    );
  }
}

class DeleteCompletedTasksButton extends ConsumerWidget {
  const DeleteCompletedTasksButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<TasksMutationState>(
      tasksMutatorPod,
      (previousState, newState) {
        if (previousState is! TasksDeletingAllCompleted) return;
        final message = switch (newState) {
          // TODO(mrverdant13): Localize.
          TasksMutationIdle() => 'All completed tasks deleted',
          // TODO(mrverdant13): Localize.
          TasksMutationFailure() => 'Failed to delete all completed tasks',
          _ => null,
        };
        if (message == null) return;
        final snackBar = SnackBar(
          content: Text(message),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      },
    );
    return IconButton(
      // TODO(mrverdant13): Localize.
      tooltip: 'Delete completed tasks',
      icon: const Icon(Icons.remove_done),
      onPressed: () {
        ref.read(tasksMutatorPod.notifier).deleteAllCompletedTasks();
      },
    );
  }
}
