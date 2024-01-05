import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/material.dart';
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ReactiveTextField<String>(
                formControlName: TaskFormGroup.titleControlName,
                decoration: const InputDecoration(
                  // TODO(mrverdant13): Localize.
                  labelText: 'Title',
                ),
              ),
              const SizedBox.square(dimension: 20),
              ReactiveTextField<String>(
                formControlName: TaskFormGroup.descriptionControlName,
                decoration: const InputDecoration(
                  // TODO(mrverdant13): Localize.
                  labelText: 'Description',
                ),
                maxLines: null,
              ),
            ],
          ),
        );
      },
    );
  }
}
