import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_database/local_database.dart';

import '../../helpers/helpers.dart';

void main() {
  testWidgets('''

GIVEN a tasks creation dialog
WHEN it is displayed
THEN it shows its content
''', (tester) async {
    await tester.pumpAppWithScaffold(
      const TaskCreationDialog(),
    );
    final contentFinder = find.byType(TaskCreationDialogContent);
    expect(contentFinder, findsOneWidget);
  });

  testWidgets('''

GIVEN a tasks creation dialog content
WHEN it is displayed
THEN it shows a new task form
''', (tester) async {
    await tester.pumpAppWithScaffold(
      const TaskCreationDialogContent(),
    );
    final newTaskFormFinder = find.byType(NewTaskForm);
    expect(newTaskFormFinder, findsOneWidget);
  });

  final taskTitleFieldLabelL10nVariant = LocalizationVariant.withCommonSelector(
    localizedTextSelector: (l10n) => l10n.newTaskFormTitleLabel,
    partialCases: {
      const (
        Locale('en'),
        'Title',
      ),
      const (
        Locale('es'),
        // cspell:disable-next-line
        'Título',
      ),
    },
  );

  testExhaustiveLocalizationVariant(
    '''

GIVEN a localization variant for a task title field label
WHEN testing the field
THEN all supported locales should be considered
''',
    taskTitleFieldLabelL10nVariant,
  );

  testLocalizedWidget(
    '''

GIVEN a localization variant for a task title field label
WHEN testing the new task form
THEN the form should include the localized label
''',
    const Scaffold(body: NewTaskForm()),
    ancestorFinder: find.byType(TextFormField).at(0),
    variant: taskTitleFieldLabelL10nVariant,
  );

  final taskDescriptionFieldLabelL10nVariant =
      LocalizationVariant.withCommonSelector(
    localizedTextSelector: (l10n) => l10n.newTaskFormDescriptionLabel,
    partialCases: {
      const (
        Locale('en'),
        'Description',
      ),
      const (
        Locale('es'),
        // cspell:disable-next-line
        'Descripción',
      ),
    },
  );

  testExhaustiveLocalizationVariant(
    '''

GIVEN a localization variant for a task description field label
WHEN testing the field
THEN all supported locales should be considered
''',
    taskDescriptionFieldLabelL10nVariant,
  );

  testLocalizedWidget(
    '''

GIVEN a localization variant for a task description field label
WHEN testing the new task form
THEN the form should include the localized label
''',
    const Scaffold(body: NewTaskForm()),
    ancestorFinder: find.byType(TextFormField).at(1),
    variant: taskDescriptionFieldLabelL10nVariant,
  );

  final taskPriorityFieldLabelL10nVariant =
      LocalizationVariant.withCommonSelector(
    localizedTextSelector: (l10n) => l10n.newTaskFormPriorityLabel,
    partialCases: {
      const (
        Locale('en'),
        'Priority',
      ),
      const (
        Locale('es'),
        // cspell:disable-next-line
        'Prioridad',
      ),
    },
  );

  testExhaustiveLocalizationVariant(
    '''

GIVEN a localization variant for a task priority field label
WHEN testing the field
THEN all supported locales should be considered
''',
    taskPriorityFieldLabelL10nVariant,
  );

  testLocalizedWidget(
    '''

GIVEN a localization variant for a task priority field label
WHEN testing the new task form
THEN the form should include the localized label
''',
    const Scaffold(body: NewTaskForm()),
    ancestorFinder: find.byType(DropdownButtonFormField<TaskPriority>),
    variant: taskPriorityFieldLabelL10nVariant,
  );

  final newTaskSubmitButtonLabelL10nVariant =
      LocalizationVariant.withCommonSelector(
    localizedTextSelector: (l10n) => l10n.newTaskFormSubmitButtonLabel,
    partialCases: {
      const (
        Locale('en'),
        'Create task',
      ),
      const (
        Locale('es'),
        // cspell:disable-next-line
        'Crear tarea',
      ),
    },
  );

  testExhaustiveLocalizationVariant(
    '''

GIVEN a localization variant for a new task submit button label
WHEN testing the button
THEN all supported locales should be considered
''',
    newTaskSubmitButtonLabelL10nVariant,
  );

  testLocalizedWidget(
    '''

GIVEN a localization variant for a new task submit button label
WHEN testing the new task form
THEN the form should include the localized label
''',
    const Scaffold(body: NewTaskForm()),
    ancestorFinder: find.byType(ElevatedButton),
    variant: newTaskSubmitButtonLabelL10nVariant,
  );

  final createTaskGenericErrorMessageL10nVariant =
      LocalizationVariant.withCommonSelector(
    localizedTextSelector: (l10n) => l10n.createTaskGenericMessage,
    partialCases: {
      const (
        Locale('en'),
        'Unexpected error creating task',
      ),
      const (
        Locale('es'),
        // cspell:disable-next-line
        'Error inesperado al crear tarea',
      ),
    },
  );

  testExhaustiveLocalizationVariant(
    '''

GIVEN a localization variant for a generic error message when creating a task
WHEN testing the error
THEN all supported locales should be considered
''',
    createTaskGenericErrorMessageL10nVariant,
  );

  testLocalizedWidget(
    '''

GIVEN a localization variant for a generic error message when creating a task
WHEN testing the new task form
THEN the form should show the localized error
''',
    const ProviderScope(
      child: Scaffold(
        body: NewTaskForm(),
      ),
    ),
    postPumpAction: (tester) async {
      final context = tester.element(find.byType(NewTaskForm));
      final container = ProviderScope.containerOf(context, listen: false);
      final subscription = container.listen(
        createTaskMutationPod.notifier,
        (_, __) {},
      );
      addTearDown(subscription.close);
      subscription.read().state = const AsyncError(
        Object(),
        StackTrace.empty,
      );
      await tester.pumpAndSettle();
    },
    ancestorFinder: find.byType(Text),
    variant: createTaskGenericErrorMessageL10nVariant,
  );

  final createTaskEmptyTitleErrorMessageL10nVariant =
      LocalizationVariant.withCommonSelector(
    localizedTextSelector: (l10n) => l10n.createTaskTitleEmptyError,
    partialCases: {
      const (
        Locale('en'),
        'The title should not be empty',
      ),
      const (
        Locale('es'),
        // cspell:disable-next-line
        'El título no puede estar vacío',
      ),
    },
  );

  testExhaustiveLocalizationVariant(
    '''

GIVEN a localization variant for an empty title error message when creating a task
WHEN testing the error
THEN all supported locales should be considered
''',
    createTaskEmptyTitleErrorMessageL10nVariant,
  );

  testLocalizedWidget(
    '''

GIVEN a localization variant for an empty title error message when creating a task
WHEN testing the new task form
THEN the form should show the localized error
''',
    const ProviderScope(
      child: Scaffold(
        body: NewTaskForm(),
      ),
    ),
    postPumpAction: (tester) async {
      final context = tester.element(find.byType(NewTaskForm));
      final container = ProviderScope.containerOf(context, listen: false);
      final subscription = container.listen(
        createTaskMutationPod.notifier,
        (_, __) {},
      );
      addTearDown(subscription.close);
      subscription.read().state = const AsyncError(
        CreateTaskFailureInvalidData(
          titleValidationErrors: {
            TaskTitleValidationError.empty,
          },
          complexValidationErrors: {},
        ),
        StackTrace.empty,
      );
      await tester.pumpAndSettle();
    },
    ancestorFinder: find.byType(TextFormField).at(0),
    variant: createTaskEmptyTitleErrorMessageL10nVariant,
  );

  // ignore: lines_longer_than_80_chars
  final createTaskDescriptionRequiredForHighPriorityTaskErrorMessageL10nVariant =
      LocalizationVariant.withCommonSelector(
    localizedTextSelector: (l10n) =>
        l10n.createTaskDescriptionRequiredForHighPriorityTaskError,
    partialCases: {
      const (
        Locale('en'),
        'A description is required for high priority tasks',
      ),
      const (
        Locale('es'),
        // cspell:disable-next-line
        'Una descripción es necesaria para tareas de alta prioridad',
      ),
    },
  );

  testExhaustiveLocalizationVariant(
    '''

GIVEN a localization variant for a description required error message when creating a high priority task
WHEN testing the error
THEN all supported locales should be considered
''',
    createTaskDescriptionRequiredForHighPriorityTaskErrorMessageL10nVariant,
  );

  testLocalizedWidget(
    '''

GIVEN a localization variant for a description required error message when creating a high priority task
WHEN testing the new task form
THEN the form should show the localized error
''',
    const ProviderScope(
      child: Scaffold(
        body: NewTaskForm(),
      ),
    ),
    postPumpAction: (tester) async {
      final context = tester.element(find.byType(NewTaskForm));
      final container = ProviderScope.containerOf(context, listen: false);
      final subscription = container.listen(
        createTaskMutationPod.notifier,
        (_, __) {},
      );
      addTearDown(subscription.close);
      subscription.read().state = const AsyncError(
        CreateTaskFailureInvalidData(
          titleValidationErrors: {},
          complexValidationErrors: {
            TaskComplexValidationError.highPriorityWithNoDescription,
          },
        ),
        StackTrace.empty,
      );
      await tester.pumpAndSettle();
    },
    ancestorFinder: find.byType(TextFormField).at(1),
    variant:
        createTaskDescriptionRequiredForHighPriorityTaskErrorMessageL10nVariant,
  );
}
