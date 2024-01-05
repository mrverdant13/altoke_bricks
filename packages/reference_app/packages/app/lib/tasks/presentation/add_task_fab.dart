import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tasks/tasks.dart';

class AddTaskFab extends ConsumerWidget {
  const AddTaskFab({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.extended(
      // TODO(mrverdant13): Localize.
      tooltip: 'Create Task',
      onPressed: () {
        final formGroup = ReactiveForm.of(context)! as TaskFormGroup;
        if (formGroup.valid) {
          final newTask = NewTask(
            title: formGroup.titleControl.value!,
            description: formGroup.descriptionControl.value,
          );
          ref.read(taskCreatorPod.notifier).create(newTask: newTask);
        } else {
          formGroup.markAllAsTouched();
        }
      },
      icon: const Icon(Icons.add),
      // TODO(mrverdant13): Localize.
      label: const Text('Add Task'),
    );
  }
}
