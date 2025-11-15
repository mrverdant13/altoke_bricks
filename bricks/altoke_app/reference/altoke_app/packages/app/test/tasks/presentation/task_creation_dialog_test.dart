import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_database/local_database.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

import '../../helpers/helpers.dart';

@Dependencies([
  localTasksDao,
])
void main() {
  testWidgets(
    '''

GIVEN a tasks creation dialog
WHEN it is displayed
THEN it shows its content
''',
    (tester) async {
      await tester.pumpAppWithScaffold(const TaskCreationDialog());
      final contentFinder = find.byType(TaskCreationDialogContent);
      expect(contentFinder, findsOneWidget);
    },
  );

  testWidgets(
    '''

GIVEN a tasks creation dialog content
WHEN it is displayed
THEN it shows a new task form
''',
    (tester) async {
      await tester.pumpAppWithScaffold(const TaskCreationDialogContent());
      final newTaskFormFinder = find.byType(NewTaskForm);
      expect(newTaskFormFinder, findsOneWidget);
    },
  );

  testWidgets(
    '''

GIVEN a localization variant for a task title field label
WHEN testing the new task form
THEN the form should include the localized label
''',
    (tester) async {
      await tester.pumpAppWithScreen(
        const ProviderScope(child: Scaffold(body: NewTaskForm())),
      );
      expect(
        find.l10n.widgetWithText(
          TextFormField,
          (l10n) => l10n.newTaskFormTitleLabel,
        ),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    '''

GIVEN a localization variant for a task description field label
WHEN testing the new task form
THEN the form should include the localized label
''',
    (tester) async {
      await tester.pumpAppWithScreen(
        const ProviderScope(child: Scaffold(body: NewTaskForm())),
      );
      expect(
        find.l10n.widgetWithText(
          TextFormField,
          (l10n) => l10n.newTaskFormDescriptionLabel,
        ),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    '''

GIVEN a localization variant for a task priority field label
WHEN testing the new task form
THEN the form should include the localized label
''',
    (tester) async {
      await tester.pumpAppWithScreen(
        const ProviderScope(child: Scaffold(body: NewTaskForm())),
      );
      expect(
        find.l10n.widgetWithText(
          DropdownButtonFormField<TaskPriority>,
          (l10n) => l10n.newTaskFormPriorityLabel,
        ),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    '''

GIVEN a localization variant for a new task submit button label
WHEN testing the new task form
THEN the form should include the localized label
''',
    (tester) async {
      await tester.pumpAppWithScreen(
        const ProviderScope(child: Scaffold(body: NewTaskForm())),
      );
      expect(
        find.l10n.widgetWithText(
          ElevatedButton,
          (l10n) => l10n.newTaskFormSubmitButtonLabel,
        ),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    '''

GIVEN a localization variant for a generic error message when creating a task
WHEN testing the new task form
THEN the form should show the localized error
''',
    (tester) async {
      await tester.pumpAppWithScreen(
        const ProviderScope(
          child: Scaffold(
            body: NewTaskForm(),
          ),
        ),
      );
      final context = tester.element(find.byType(NewTaskForm));
      final container = ProviderScope.containerOf(context, listen: false);
      createTaskMutation
          .run(container, (tsx) async => throw Exception('unknown error'))
          .ignore();
      await tester.pumpAndSettle();
      expect(
        find.l10n.text((l10n) => l10n.createTaskGenericMessage),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    '''

  GIVEN a localization variant for an empty title error message when creating a task
  WHEN testing the new task form
  THEN the form should show the localized error
  ''',
    (tester) async {
      await tester.pumpAppWithScreen(
        const ProviderScope(
          child: Scaffold(
            body: NewTaskForm(),
          ),
        ),
      );
      final context = tester.element(find.byType(NewTaskForm));
      final container = ProviderScope.containerOf(context, listen: false);
      createTaskMutation
          .run(
            container,
            (tsx) async => throw const CreateTaskFailureInvalidData(
              titleValidationErrors: {TaskTitleValidationError.empty},
              complexValidationErrors: {},
            ),
          )
          .ignore();
      await tester.pumpAndSettle();
      expect(
        find.l10n.widgetWithText(
          TextFormField,
          (l10n) => l10n.createTaskTitleEmptyError,
        ),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    '''

  GIVEN a localization variant for a description required error message when creating a high priority task
  WHEN testing the new task form
  THEN the form should show the localized error
  ''',
    (tester) async {
      await tester.pumpAppWithScreen(
        const ProviderScope(
          child: Scaffold(
            body: NewTaskForm(),
          ),
        ),
      );
      final context = tester.element(find.byType(NewTaskForm));
      final container = ProviderScope.containerOf(context, listen: false);
      createTaskMutation
          .run(
            container,
            (tsx) async => throw const CreateTaskFailureInvalidData(
              titleValidationErrors: {},
              complexValidationErrors: {
                TaskComplexValidationError.highPriorityWithNoDescription,
              },
            ),
          )
          .ignore();
      await tester.pumpAndSettle();
      expect(
        find.l10n.widgetWithText(
          TextFormField,
          (l10n) => l10n.createTaskDescriptionRequiredForHighPriorityTaskError,
        ),
        findsOneWidget,
      );
    },
  );
}
