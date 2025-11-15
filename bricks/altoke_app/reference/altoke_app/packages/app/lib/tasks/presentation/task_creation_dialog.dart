import 'package:altoke_app/l10n/l10n.dart';
import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_database/local_database.dart';

// coverage:ignore-start
class TaskCreationDialog extends StatelessWidget {
  const TaskCreationDialog({super.key});

  static const maxWidth = 600.0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: maxWidth),
        child: Dialog(
          insetPadding: switch (screenWidth) {
            >= maxWidth => null,
            _ => EdgeInsets.zero,
          },
          shape: switch (screenWidth) {
            >= maxWidth => null,
            _ => const Border(),
          },
          child: const TaskCreationDialogContent(),
        ),
      ),
    );
  }
}

@visibleForTesting
class TaskCreationDialogContent extends ConsumerWidget {
  const TaskCreationDialogContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(createTaskMutation, (previous, current) {
      if (!current.isSuccess) return;
      final l10n = context.l10n;
      final message = l10n.createTaskSuccessMessage;
      final snackBar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context);
    });
    return const NewTaskForm();
  }
}

class NewTaskForm extends ConsumerStatefulWidget {
  const NewTaskForm({super.key});

  @override
  ConsumerState<NewTaskForm> createState() => _NewTaskFormState();
}

class _NewTaskFormState extends ConsumerState<NewTaskForm> {
  late String title;
  late String? description;
  late TaskPriority priority;

  String? titleError;
  String? descriptionError;
  String? genericError;

  @override
  void initState() {
    super.initState();
    title = '';
    description = null;
    priority = TaskPriority.low;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    ref.listen(createTaskMutation, (
      previous,
      current,
    ) {
      if (current is! MutationError<Task>) return;
      final error = current.error;
      if (error is! CreateTaskFailure) {
        setState(() {
          genericError = l10n.createTaskGenericMessage;
        });
        return;
      }
      switch (error) {
        case CreateTaskFailureInvalidData(
          :final titleValidationErrors,
          :final complexValidationErrors,
        ):
          setState(() {
            titleError = titleValidationErrors.getFirstError(l10n);
          });
          switch (complexValidationErrors.firstOrNull) {
            case null:
              break;
            case TaskComplexValidationError.highPriorityWithNoDescription:
              setState(() {
                descriptionError =
                    l10n.createTaskDescriptionRequiredForHighPriorityTaskError;
              });
          }
      }
    });
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(24),
      children: [
        TextFormField(
          autofocus: true,
          decoration: InputDecoration(
            labelText: l10n.newTaskFormTitleLabel,
            errorText: titleError,
          ),
          onChanged: (title) {
            setState(() {
              this.title = title;
              titleError = null;
            });
          },
        ),
        const SizedBox.square(dimension: 16),
        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.newTaskFormDescriptionLabel,
            errorText: descriptionError,
          ),
          onChanged: (description) {
            setState(() {
              this.description = description;
            });
          },
        ),
        const SizedBox.square(dimension: 16),
        DropdownButtonFormField(
          initialValue: priority,
          decoration: InputDecoration(labelText: l10n.newTaskFormPriorityLabel),
          items: [
            for (final priority in TaskPriority.values)
              DropdownMenuItem(
                value: priority,
                child: Text(priority.label(l10n)),
              ),
          ],
          onChanged: (priority) {
            if (priority == null) return;
            setState(() {
              this.priority = priority;
              descriptionError = null;
            });
          },
        ),
        if (genericError != null) ...[
          const SizedBox.square(dimension: 24),
          Text(
            genericError!,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ],
        const SizedBox.square(dimension: 24),
        ElevatedButton(
          onPressed: () async {
            final newTask = NewTask(
              title: title,
              priority: priority,
              description: description,
            );
            await createTask(ref, newTask);
          },
          child: Text(l10n.newTaskFormSubmitButtonLabel),
        ),
      ],
    );
  }
}

extension on TaskTitleValidationError {
  String getError(AppLocalizations l10n) {
    return switch (this) {
      TaskTitleValidationError.empty => l10n.createTaskTitleEmptyError,
    };
  }
}

extension on Iterable<TaskTitleValidationError> {
  String? getFirstError(AppLocalizations l10n) {
    return firstOrNull?.getError(l10n);
  }
}

extension on TaskPriority {
  String label(AppLocalizations l10n) {
    return switch (this) {
      TaskPriority.low => l10n.newTaskFormPriorityLowLabel,
      TaskPriority.medium => l10n.newTaskFormPriorityMediumLabel,
      TaskPriority.high => l10n.newTaskFormPriorityHighLabel,
    };
  }
}

// coverage:ignore-end
