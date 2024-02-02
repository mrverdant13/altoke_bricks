import 'package:{{project_name.snakeCase()}}/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

class TaskDetailsFormInitializerWrapper extends ConsumerWidget {
  const TaskDetailsFormInitializerWrapper({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      asyncTaskPod,
      (_, asyncTask) {
        final formGroup = ReactiveForm.of(context)! as TaskFormGroup;
        asyncTask.maybeMap(
          data: (data) {
            final task = data.value;
            if (task == null) {
              formGroup
                ..reset()
                ..markAsDisabled();
              return;
            }
            formGroup
              ..titleControl.value = task.title
              ..descriptionControl.value = task.description
              ..markAsEnabled();
          },
          orElse: () {
            formGroup
              ..reset()
              ..markAsDisabled();
          },
        );
      },
    );
    return child;
  }
}
