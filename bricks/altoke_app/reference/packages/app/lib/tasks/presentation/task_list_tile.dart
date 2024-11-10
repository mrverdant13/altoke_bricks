import 'package:altoke_app/tasks/tasks.dart';
import 'package:altoke_common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_database/local_database.dart';

class TaskListTile extends ConsumerWidget {
  const TaskListTile({
    required this.task,
    super.key,
  });

  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..watch(deleteTaskByIdMutationPod.notifier)
      ..watch(updateTaskMutationPod.notifier);
    final Task(:id, :title, :priority, :completed, :description) = task;
    return Dismissible(
      key: ValueKey('''<tasks::task-lits-tile::task-$id>'''),
      onDismissed: (direction) {
        ref.read(deleteTaskByIdMutationPod.notifier).deleteTaskById(id);
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
      child: CheckboxListTile.adaptive(
        activeColor: Colors.grey,
        secondary: Icon(
          Icons.flag_circle,
          color: switch (priority) {
            TaskPriority.high => Colors.red,
            TaskPriority.medium => Colors.orange,
            TaskPriority.low => Colors.green,
          }
              .withOpacity(completed ? 0.5 : 1),
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
        onChanged: (value) {
          if (value == null) return;
          final task = PartialTask(
            completed: Optional.some(value),
          );
          ref
              .read(updateTaskMutationPod.notifier)
              .updateTask(taskId: id, task: task);
        },
      ),
    );
  }
}
