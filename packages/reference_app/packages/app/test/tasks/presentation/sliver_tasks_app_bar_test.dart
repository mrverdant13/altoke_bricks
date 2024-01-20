import 'package:altoke_app/l10n/l10n.dart';
import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  group(
    '''

GIVEN a localization variant for the mark all tasks as completed button tooltip''',
    () {
      final markAllTasksAsCompletedButtonTooltipLocalizationVariant =
          LocalizationVariant.withCommonSelector(
        localizedTextSelector: (l10n) =>
            l10n.tasksMarkAllTasksAsCompletedButtonTooltip,
        partialCases: {
          const (Locale('en'), 'Mark all tasks as completed'),
          const (Locale('es'), 'Marcar todas las tareas como completadas'),
        },
      );

      testExhaustiveLocalizationVariant(
        '''

WHEN testing the mark all tasks as completed button
THEN all supported locales should be considered
''',
        markAllTasksAsCompletedButtonTooltipLocalizationVariant,
      );

      testLocalizedWidget(
        '''

AND an injected tasks mutator pod
AND a mark all tasks as completed button
WHEN it is displayed
THEN the fab should include the localized tooltip
''',
        ProviderScope(
          overrides: [
            tasksMutatorPod.overrideWith(
              () => MockTasksMutator(
                initialState: const TasksMutationIdle(),
              ),
            ),
          ],
          child: const MarkAllTasksAsCompletedButton(),
        ),
        postPumpAction: (tester) async {
          final tooltipFinder = find.byType(Tooltip);
          await tester.longPress(tooltipFinder);
          await tester.pumpAndSettle();
        },
        ancestorFinder: find.byType(Overlay),
        variant: markAllTasksAsCompletedButtonTooltipLocalizationVariant,
      );
    },
  );

  final iconButtonFinder = find.byType(IconButton);
  final snackbarFinder = find.byType(SnackBar);

  group(
    '''

GIVEN a mark all tasks as completed button''',
    () {
      final iconFinder = find.byIcon(Icons.done_all);

      group(
        '''

AND an injected tasks mutator''',
        () {
          late TasksMutator tasksMutator;
          late Widget button;

          setUp(
            () {
              tasksMutator = MockTasksMutator(
                initialState: const TasksMutationIdle(),
              );
              button = ProviderScope(
                overrides: [
                  tasksMutatorPod.overrideWith(
                    () => tasksMutator,
                  ),
                ],
                child: const MarkAllTasksAsCompletedButton(),
              );
            },
          );

          tearDown(
            () {
              verifyNoMoreInteractions(tasksMutator);
            },
          );

          testWidgets(
            '''

WHEN the button is displayed
THEN the proper icon should be used
''',
            (tester) async {
              await tester.pumpTestableWidget(button);
              expect(iconFinder, findsOneWidget);
              expect(iconButtonFinder, findsOneWidget);
            },
          );

          testWidgets(
            '''

WHEN the button is tapped
THEN all tasks should be marked as completed
├─ BY calling the tasks mutator pod
''',
            (tester) async {
              when(
                () => tasksMutator.markAllAsCompleted(),
              ).thenAnswer(
                (_) async {},
              );
              await tester.pumpTestableWidget(button);
              await tester.tap(iconButtonFinder);
              verify(
                () => tasksMutator.markAllAsCompleted(),
              ).called(1);
            },
          );
        },
      );

      group(
        '''

AND an injected listenable tasks mutator''',
        () {
          late ProviderContainer container;
          late Widget button;

          setUp(
            () {
              container = ProviderContainer(
                overrides: [
                  tasksRepositoryPod.overrideWithValue(
                    FakeTasksRepository(),
                  ),
                ],
              );
              button = Scaffold(
                body: UncontrolledProviderScope(
                  container: container,
                  child: const MarkAllTasksAsCompletedButton(),
                ),
              );
            },
          );

          tearDown(
            () {
              container.dispose();
            },
          );

          testWidgets(
            '''

├─ THAT was not marking all tasks as completed
WHEN the mutator emits another state
THEN no action should be performed
''',
            (tester) async {
              final mutator = container.read(tasksMutatorPod.notifier);
              await tester.pumpTestableWidget(button);
              expect(mutator.state, isNot(isA<TasksMarkingAllAsCompleted>()));
              expect(snackbarFinder, findsNothing);
              mutator.state = const TasksMutationIdle();
              await tester.pump();
              expect(snackbarFinder, findsNothing);
              await tester.pumpAndSettle();
            },
          );

          testWidgets(
            '''

├─ THAT was marking all tasks as completed
WHEN the mutator emits the idle state
THEN a snackbar with the proper message should be shown
''',
            (tester) async {
              final mutator = container.read(tasksMutatorPod.notifier);
              await tester.pumpTestableWidget(button);
              mutator.state = const TasksMarkingAllAsCompleted();
              expect(mutator.state, isA<TasksMarkingAllAsCompleted>());
              expect(snackbarFinder, findsNothing);
              mutator.state = const TasksMutationIdle();
              await tester.pump();
              expect(snackbarFinder, findsOneWidget);
              final l10n = tester.element(snackbarFinder).l10n;
              final snackbarMessageFinder = find.widgetWithText(
                SnackBar,
                l10n.tasksAllTasksMarkedAsCompletedSnackbarMessage,
              );
              expect(snackbarMessageFinder, findsOneWidget);
              await tester.pumpAndSettle();
            },
          );

          testWidgets(
            '''

├─ THAT was marking all tasks as completed
WHEN the mutator emits the failure state
THEN a snackbar with the proper message should be shown
''',
            (tester) async {
              final mutator = container.read(tasksMutatorPod.notifier);
              await tester.pumpTestableWidget(button);
              mutator.state = const TasksMarkingAllAsCompleted();
              expect(mutator.state, isA<TasksMarkingAllAsCompleted>());
              expect(snackbarFinder, findsNothing);
              mutator.state = TasksMutationFailure(
                error: Exception(),
                stackTrace: StackTrace.empty,
              );
              await tester.pump();
              expect(snackbarFinder, findsOneWidget);
              final l10n = tester.element(snackbarFinder).l10n;
              final snackbarMessageFinder = find.widgetWithText(
                SnackBar,
                l10n.tasksFailedToMarkAllTasksAsCompletedSnackbarMessage,
              );
              expect(snackbarMessageFinder, findsOneWidget);
              await tester.pumpAndSettle();
            },
          );
        },
      );
    },
  );

  group(
    '''

GIVEN a localization variant for the delete all completed tasks button tooltip''',
    () {
      final deleteAllCompletedTasksButtonTooltipLocalizationVariant =
          LocalizationVariant.withCommonSelector(
        localizedTextSelector: (l10n) =>
            l10n.tasksDeleteAllCompletedTasksButtonTooltip,
        partialCases: {
          const (Locale('en'), 'Delete all completed tasks'),
          const (Locale('es'), 'Borrar todas las tareas completadas'),
        },
      );

      testExhaustiveLocalizationVariant(
        '''

WHEN testing the delete all completed tasks button
THEN all supported locales should be considered
''',
        deleteAllCompletedTasksButtonTooltipLocalizationVariant,
      );

      testLocalizedWidget(
        '''

AND an injected tasks mutator pod
AND a delete all completed tasks button
WHEN it is displayed
THEN the fab should include the localized tooltip
''',
        ProviderScope(
          overrides: [
            tasksMutatorPod.overrideWith(
              () => MockTasksMutator(
                initialState: const TasksMutationIdle(),
              ),
            ),
          ],
          child: const DeleteCompletedTasksButton(),
        ),
        postPumpAction: (tester) async {
          final tooltipFinder = find.byType(Tooltip);
          await tester.longPress(tooltipFinder);
          await tester.pumpAndSettle();
        },
        ancestorFinder: find.byType(Overlay),
        variant: deleteAllCompletedTasksButtonTooltipLocalizationVariant,
      );
    },
  );

  group(
    '''

GIVEN a delete all completed tasks button''',
    () {
      final iconFinder = find.byIcon(Icons.remove_done);

      group(
        '''

AND an injected tasks mutator''',
        () {
          late TasksMutator tasksMutator;
          late Widget button;

          setUp(
            () {
              tasksMutator = MockTasksMutator(
                initialState: const TasksMutationIdle(),
              );
              button = ProviderScope(
                overrides: [
                  tasksMutatorPod.overrideWith(
                    () => tasksMutator,
                  ),
                ],
                child: const DeleteCompletedTasksButton(),
              );
            },
          );

          tearDown(
            () {
              verifyNoMoreInteractions(tasksMutator);
            },
          );

          testWidgets(
            '''

WHEN the button is displayed
THEN the proper icon should be used
''',
            (tester) async {
              await tester.pumpTestableWidget(button);
              expect(iconFinder, findsOneWidget);
              expect(iconButtonFinder, findsOneWidget);
            },
          );

          testWidgets(
            '''

WHEN the button is tapped
THEN all completed tasks should be deleted
├─ BY calling the tasks mutator pod
''',
            (tester) async {
              when(
                () => tasksMutator.deleteAllCompletedTasks(),
              ).thenAnswer(
                (_) async {},
              );
              await tester.pumpTestableWidget(button);
              await tester.tap(iconButtonFinder);
              verify(
                () => tasksMutator.deleteAllCompletedTasks(),
              ).called(1);
            },
          );
        },
      );

      group(
        '''

AND an injected listenable tasks mutator''',
        () {
          late ProviderContainer container;
          late Widget button;

          setUp(
            () {
              container = ProviderContainer(
                overrides: [
                  tasksRepositoryPod.overrideWithValue(
                    FakeTasksRepository(),
                  ),
                ],
              );
              button = Scaffold(
                body: UncontrolledProviderScope(
                  container: container,
                  child: const DeleteCompletedTasksButton(),
                ),
              );
            },
          );

          tearDown(
            () {
              container.dispose();
            },
          );

          testWidgets(
            '''

├─ THAT was not deleting all completed tasks
WHEN the mutator emits another state
THEN no action should be performed
''',
            (tester) async {
              final mutator = container.read(tasksMutatorPod.notifier);
              await tester.pumpTestableWidget(button);
              expect(mutator.state, isNot(isA<TasksDeletingAllCompleted>()));
              expect(snackbarFinder, findsNothing);
              mutator.state = const TasksMutationIdle();
              await tester.pump();
              expect(snackbarFinder, findsNothing);
              await tester.pumpAndSettle();
            },
          );

          testWidgets(
            '''

├─ THAT was deleting all completed tasks
WHEN the mutator emits the idle state
THEN a snackbar with the proper message should be shown
''',
            (tester) async {
              final mutator = container.read(tasksMutatorPod.notifier);
              await tester.pumpTestableWidget(button);
              mutator.state = const TasksDeletingAllCompleted();
              expect(mutator.state, isA<TasksDeletingAllCompleted>());
              expect(snackbarFinder, findsNothing);
              mutator.state = const TasksMutationIdle();
              await tester.pump();
              expect(snackbarFinder, findsOneWidget);
              final l10n = tester.element(snackbarFinder).l10n;
              final snackbarMessageFinder = find.widgetWithText(
                SnackBar,
                l10n.tasksAllCompletedTasksDeletedSnackbarMessage,
              );
              expect(snackbarMessageFinder, findsOneWidget);
              await tester.pumpAndSettle();
            },
          );

          testWidgets(
            '''

├─ THAT was deleting all completed tasks
WHEN the mutator emits the failure state
THEN a snackbar with the proper message should be shown
''',
            (tester) async {
              final mutator = container.read(tasksMutatorPod.notifier);
              await tester.pumpTestableWidget(button);
              mutator.state = const TasksDeletingAllCompleted();
              expect(mutator.state, isA<TasksDeletingAllCompleted>());
              expect(snackbarFinder, findsNothing);
              mutator.state = TasksMutationFailure(
                error: Exception(),
                stackTrace: StackTrace.empty,
              );
              await tester.pump();
              expect(snackbarFinder, findsOneWidget);
              final l10n = tester.element(snackbarFinder).l10n;
              final snackbarMessageFinder = find.widgetWithText(
                SnackBar,
                l10n.tasksFailedToDeleteAllCompletedTasksSnackbarMessage,
              );
              expect(snackbarMessageFinder, findsOneWidget);
              await tester.pumpAndSettle();
            },
          );
        },
      );
    },
  );
}
