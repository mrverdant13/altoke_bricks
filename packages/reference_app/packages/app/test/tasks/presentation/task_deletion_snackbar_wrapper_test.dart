import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tasks/tasks.dart';

import '../../helpers/helpers.dart';

void main() {
  final snackBarFinder = find.byType(SnackBar);
  final snackBarActionFinder = find.byType(SnackBarAction);
  final wrapperFinder = find.byType(TaskDeletionSnackbarWrapper);

  group(
    '''

GIVEN a localization variant for the task deletion snackbar content''',
    () {
      final localizationVariant = LocalizationVariant.withCommonSelector(
        localizedTextSelector: (l10n) => l10n.tasksTaskDeletedSnackbarMessage,
        partialCases: {
          const (
            Locale('en'),
            'Task deleted',
          ),
          const (
            Locale('es'),
            // cspell:disable-next-line
            'Tarea borrada',
          ),
        },
      );

      testExhaustiveLocalizationVariant(
        '''

WHEN testing the task deletion snackbar content
THEN all supported locales should be considered
''',
        localizationVariant,
      );

      testLocalizedWidget(
        '''

AND a task deletion snackbar
WHEN the snackbar is displayed
THEN the snackbar should include its localized content
''',
        const ProviderScope(
          child: Scaffold(
            body: TaskDeletionSnackbarWrapper(
              child: SizedBox.shrink(),
            ),
          ),
        ),
        postPumpAction: (tester) async {
          final wrapperContext = tester.element(wrapperFinder);
          final container = ProviderScope.containerOf(wrapperContext);
          container.read(latestDeletedTaskPod.notifier).state = AsyncValue.data(
            Task(
              id: 596,
              title: 'title',
              isCompleted: true,
              createdAt: DateTime.now(),
            ),
          );
          await tester.pumpAndSettle();
        },
        ancestorFinder: find.byKey(
          const Key(
            '<tasks::task-deletion-snackbar-wrapper::snackbar-content>',
          ),
        ),
        variant: localizationVariant,
      );
    },
  );

  group(
    '''

GIVEN a localization variant for the task deletion snackbar action''',
    () {
      final localizationVariant = LocalizationVariant.withCommonSelector(
        localizedTextSelector: (l10n) =>
            l10n.tasksRestoreDeletedTaskSnackbarActionLabel,
        partialCases: {
          const (
            Locale('en'),
            'Undo',
          ),
          const (
            Locale('es'),
            // cspell:disable-next-line
            'Deshacer',
          ),
        },
      );

      testExhaustiveLocalizationVariant(
        '''

WHEN testing the task deletion snackbar action
THEN all supported locales should be considered
''',
        localizationVariant,
      );

      testLocalizedWidget(
        '''

AND a task deletion snackbar
WHEN the snackbar is displayed
THEN the snackbar should include its localized action
''',
        const ProviderScope(
          child: Scaffold(
            body: TaskDeletionSnackbarWrapper(
              child: SizedBox.shrink(),
            ),
          ),
        ),
        postPumpAction: (tester) async {
          final wrapperContext = tester.element(wrapperFinder);
          final container = ProviderScope.containerOf(wrapperContext);
          container.read(latestDeletedTaskPod.notifier).state = AsyncValue.data(
            Task(
              id: 596,
              title: 'title',
              isCompleted: true,
              createdAt: DateTime.now(),
            ),
          );
          await tester.pumpAndSettle();
        },
        ancestorFinder: snackBarActionFinder,
        variant: localizationVariant,
      );
    },
  );

  testWidgets(
    '''

GIVEN a task deletion snackbar wrapper
WHEN a task is deleted
THEN a snackbar is shown
WHEN the wrapper is removed
THEN the snackbar is removed
''',
    (tester) async {
      final container = ProviderContainer();
      var useWrapper = true;
      addTearDown(container.dispose);
      final latestDeletedTasksNotifier =
          container.read(latestDeletedTaskPod.notifier);
      await tester.pumpTestableWidget(
        Scaffold(
          body: UncontrolledProviderScope(
            container: container,
            child: StatefulBuilder(
              builder: (context, setState) {
                const innerChild = Text('child');
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => setState(() => useWrapper = !useWrapper),
                      child: const Text('toggle wrapper'),
                    ),
                    switch (useWrapper) {
                      true => const TaskDeletionSnackbarWrapper(
                          child: innerChild,
                        ),
                      false => innerChild,
                    },
                  ],
                );
              },
            ),
          ),
        ),
      );
      expect(useWrapper, isTrue);
      expect(wrapperFinder, findsOneWidget);
      expect(snackBarFinder, findsNothing);
      latestDeletedTasksNotifier.state = AsyncValue.data(
        Task(
          id: 324,
          title: 'title',
          isCompleted: false,
          createdAt: DateTime.now(),
        ),
      );
      await tester.pumpAndSettle();
      expect(useWrapper, isTrue);
      expect(wrapperFinder, findsOneWidget);
      expect(snackBarFinder, findsOneWidget);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(useWrapper, isFalse);
      expect(wrapperFinder, findsNothing);
      expect(snackBarFinder, findsNothing);
    },
  );
}
