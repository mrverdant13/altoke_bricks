import 'package:{{project_name.snakeCase()}}/l10n/l10n.dart';
import 'package:{{project_name.snakeCase()}}/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

class TaskForm extends StatelessWidget {
  const TaskForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return Theme(
          data: theme.copyWith(
            inputDecorationTheme: theme.inputDecorationTheme.copyWith(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              filled: true,
              border: const OutlineInputBorder(),
              isDense: width < 400,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
            ),
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ReactiveTaskTitleField(),
              SizedBox.square(dimension: 20),
              ReactiveTaskDescriptionField(),
            ],
          ),
        );
      },
    );
  }
}

class ReactiveTaskTitleField extends ConsumerWidget {
  const ReactiveTaskTitleField({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return ReactiveTextField<String>(
      formControlName: TaskFormGroup.titleControlName,
      decoration: InputDecoration(
        label: Text(
          key: const Key('<tasks::reactive-task-title-field::label>'),
          l10n.tasksTaskTitleTextFieldLabel,
        ),
      ),
      validationMessages: {
        ValidationMessage.required: (_) =>
            l10n.tasksRequiredTaskTitleTextFieldErrorMessage,
      },
    );
  }
}

class ReactiveTaskDescriptionField extends ConsumerWidget {
  const ReactiveTaskDescriptionField({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return ReactiveTextField<String>(
      formControlName: TaskFormGroup.descriptionControlName,
      decoration: InputDecoration(
        label: Text(
          key: const Key('<tasks::reactive-task-description-field::label>'),
          l10n.tasksTaskDescriptionTextFieldLabel,
        ),
      ),
      maxLines: null,
    );
  }
}
