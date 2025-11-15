import 'dart:async';

import 'package:altoke_app/tasks/tasks.dart';
import 'package:altoke_common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_database/local_database.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

// coverage:ignore-start
@Dependencies([
  localTasksDao,
])
class TaskListTile extends ConsumerWidget {
  const TaskListTile({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..watch(deleteTaskByIdMutation)
      ..watch(updateTaskMutation);
    return TaskDismissible(task: task);
  }
}

@Dependencies([
  localTasksDao,
])
@visibleForTesting
class TaskDismissible extends ConsumerStatefulWidget {
  const TaskDismissible({
    required this.task,
    super.key,
  });

  final Task task;

  @override
  ConsumerState<TaskDismissible> createState() => _TaskDismissibleState();
}

class _TaskDismissibleState extends ConsumerState<TaskDismissible> {
  bool _isDismissed = false;

  @override
  Widget build(BuildContext context) {
    final Task(:id) = widget.task;
    if (_isDismissed) return const SizedBox.shrink();
    return Dismissible(
      key: ValueKey(
        '''<tasks::task-list-tile::task-dismissible::task-id:$id>''',
      ),
      onDismissed: (direction) {
        unawaited(deleteTaskById(ref, id));
        setState(() => _isDismissed = true);
      },
      direction: DismissDirection.endToStart,
      background: ColoredBox(
        color: Theme.of(context).colorScheme.errorContainer,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(
              Icons.delete_sweep,
              color: Theme.of(context).colorScheme.onErrorContainer,
            ),
          ),
        ),
      ),
      child: TaskCheckboxListTile(task: widget.task),
    );
  }
}

@Dependencies([
  localTasksDao,
])
@visibleForTesting
class TaskCheckboxListTile extends ConsumerWidget {
  const TaskCheckboxListTile({
    required this.task,
    super.key,
  });

  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Task(:id, :title, :priority, :completed, :description) = task;
    return CheckboxListTile.adaptive(
      activeColor: Colors.grey,
      secondary: Icon(
        Icons.flag_circle,
        color: switch (priority) {
          TaskPriority.high => Colors.red,
          TaskPriority.medium => Colors.orange,
          TaskPriority.low => Colors.green,
        }.withValues(alpha: completed ? 0.5 : 1),
      ),
      title: Text(
        title,
        style: completed
            ? const TextStyle(decoration: TextDecoration.lineThrough)
            : null,
      ),
      subtitle: description == null
          ? null
          : Text(
              description,
              style: completed
                  ? const TextStyle(decoration: TextDecoration.lineThrough)
                  : null,
            ),
      value: completed,
      onChanged: (value) async {
        if (value == null) return;
        final task = PartialTask(completed: Optional.some(value));
        await updateTask(ref, taskId: id, task: task);
      },
    );
  }
}

// coverage:ignore-end
