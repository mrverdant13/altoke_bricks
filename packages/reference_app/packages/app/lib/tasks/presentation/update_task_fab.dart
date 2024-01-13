import 'package:altoke_app/l10n/l10n.dart';
import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tasks/tasks.dart';

class UpdateTaskFab extends ConsumerWidget {
  const UpdateTaskFab({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final taskId = ref.watch(scopedTaskIdPod);
    final enabled = ReactiveForm.of(context)!.enabled;
    return FloatingActionButton.extended(
      tooltip: l10n.tasksUpdateTaskButtonTooltip,
      onPressed: enabled
          ? () {
              final formGroup = ReactiveForm.of(context)! as TaskFormGroup;
              if (formGroup.valid) {
                final newTask = PartialTask(
                  title: () => formGroup.titleControl.value!.trim(),
                  description: () {
                    final newDescription =
                        (formGroup.descriptionControl.value ?? '').trim();
                    return newDescription.isEmpty ? null : newDescription;
                  },
                );
                ref
                    .read(tasksMutatorPod.notifier)
                    .updateTask(taskId: taskId, partialTask: newTask);
              } else {
                formGroup.markAllAsTouched();
              }
            }
          : null,
      icon: const Icon(Icons.save),
      label: Text(
        l10n.tasksUpdateTaskButtonLabel,
      ),
    );
  }
}
