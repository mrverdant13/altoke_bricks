import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tasks/tasks.dart';

import '../../helpers/helpers.dart';

void main() {
  registerFallbackValues();

  final tooltipLocalizationVariant = LocalizationVariant.withCommonSelector(
    localizedTextSelector: (l10n) => l10n.tasksUpdateTaskButtonTooltip,
    partialCases: {
      const (Locale('en'), 'Apply changes'),
      const (Locale('es'), 'Aplicar cambios'),
    },
  );

  testExhaustiveLocalizationVariant(
    '''

GIVEN a tooltip localization variant
WHEN testing the update task fab
THEN all supported locales should be considered
''',
    tooltipLocalizationVariant,
  );

  testLocalizedWidget(
    '''

GIVEN an update task fab
AND an injected scoped task ID
AND and injected task form group
WHEN it is displayed
THEN the fab should include the localized tooltip
''',
    ProviderScope(
      overrides: [
        scopedTaskIdPod.overrideWithValue(13),
      ],
      child: ReactiveFormBuilder(
        form: TaskFormGroup.new,
        builder: (context, formGroup, child) => child!,
        child: const UpdateTaskFab(),
      ),
    ),
    postPumpAction: (tester) async {
      final tooltipFinder = find.byType(Tooltip);
      await tester.longPress(tooltipFinder);
      await tester.pumpAndSettle();
    },
    ancestorFinder: find.byType(Overlay),
    variant: tooltipLocalizationVariant,
  );

  testWidgets(
    '''

GIVEN an update task fab
AND an injected scoped task ID
AND and injected task form group
├─ THAT is disabled
WHEN the update task fab is displayed
THEN the fab should be disabled
''',
    (tester) async {
      await tester.pumpTestableWidget(
        ProviderScope(
          overrides: [
            scopedTaskIdPod.overrideWithValue(28),
          ],
          child: ReactiveFormBuilder(
            form: () => TaskFormGroup()..markAsDisabled(),
            builder: (context, formGroup, child) => child!,
            child: const UpdateTaskFab(),
          ),
        ),
      );
      final fabFinder = find.byType(FloatingActionButton);
      expect(fabFinder, findsOneWidget);
      final fab = tester.widget<FloatingActionButton>(fabFinder);
      expect(fab.onPressed, isNull);
    },
  );

  testWidgets(
    '''

GIVEN an update task fab
AND an injected scoped task ID
AND and injected task form group
├─ THAT is enabled
├─ AND is invalid
WHEN the update task fab is displayed
THEN the fab should be disabled
WHEN the update task fab is tapped
THEN the form group should be marked as touched
''',
    (tester) async {
      await tester.pumpTestableWidget(
        ProviderScope(
          overrides: [
            scopedTaskIdPod.overrideWithValue(28),
          ],
          child: ReactiveFormBuilder(
            form: () => TaskFormGroup()..markAsEnabled(),
            builder: (context, formGroup, child) => child!,
            child: const UpdateTaskFab(),
          ),
        ),
      );
      final fabFinder = find.byType(FloatingActionButton);
      final formGroup = ReactiveForm.of(tester.element(fabFinder))!;
      expect(fabFinder, findsOneWidget);
      final fab = tester.widget<FloatingActionButton>(fabFinder);
      expect(fab.onPressed, isNotNull);
      expect(formGroup.touched, isFalse);
      await tester.tap(fabFinder);
      expect(formGroup.touched, isTrue);
    },
  );

  testWidgets(
    '''

GIVEN an update task fab
AND an injected scoped task ID
AND and injected task form group
├─ THAT is enabled
├─ AND is valid
WHEN the update task fab is displayed
THEN the fab should be disabled
WHEN the update task fab is tapped
THEN the task update process should be started
''',
    (tester) async {
      final tasksMutator = MockTasksMutator(
        initialState: const TasksMutationIdle(),
      );
      when(
        () => tasksMutator.updateTask(
          taskId: any(named: 'taskId'),
          partialTask: any(named: 'partialTask'),
        ),
      ).thenAnswer(
        (_) async {
          return;
        },
      );
      await tester.pumpTestableWidget(
        ProviderScope(
          overrides: [
            scopedTaskIdPod.overrideWithValue(28),
            tasksMutatorPod.overrideWith(() => tasksMutator),
          ],
          child: ReactiveFormBuilder(
            form: () => TaskFormGroup()
              ..markAsEnabled()
              ..titleControl.value = 'title',
            builder: (context, formGroup, child) => child!,
            child: const UpdateTaskFab(),
          ),
        ),
      );
      final fabFinder = find.byType(FloatingActionButton);
      expect(fabFinder, findsOneWidget);
      final fab = tester.widget<FloatingActionButton>(fabFinder);
      expect(fab.onPressed, isNotNull);
      await tester.tap(fabFinder);
      verify(
        () => tasksMutator.updateTask(
          taskId: 28,
          partialTask: any(
            named: 'partialTask',
            that: isA<PartialTask>()
                .having(
                  (task) => task.title?.call(),
                  'title',
                  'title',
                )
                .having(
                  (task) => task.description?.call(),
                  'description',
                  isNull,
                ),
          ),
        ),
      ).called(1);
      verifyNoMoreInteractions(tasksMutator);
    },
  );
}
