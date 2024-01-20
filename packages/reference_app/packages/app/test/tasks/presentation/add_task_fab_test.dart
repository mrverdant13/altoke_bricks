import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tasks/tasks.dart';

import '../../helpers/helpers.dart';

void main() {
  final tooltipLocalizationVariant = LocalizationVariant.withCommonSelector(
    localizedTextSelector: (l10n) => l10n.tasksAddTaskButtonTooltip,
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

GIVEN a tooltip localization variant
WHEN testing the add task fab
THEN all supported locales should be considered
''',
    tooltipLocalizationVariant,
  );

  testLocalizedWidget(
    '''

GIVEN a add task fab
WHEN it is displayed
THEN the fab should include the localized tooltip
''',
    const AddTaskFab(),
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

GIVEN a add task fab
AND a task form group
├─ THAT is valid
WHEN the add task fab is tapped
THEN the task creation process should be started
''',
    (tester) async {
      registerFallbackValues();
      final taskCreator = MockTaskCreator(
        initialState: false,
      );
      when(
        () => taskCreator.create(
          newTask: any(named: 'newTask'),
        ),
      ).thenAnswer(
        (_) async {
          return;
        },
      );
      await tester.pumpTestableWidget(
        ProviderScope(
          overrides: [
            taskCreatorPod.overrideWith(
              () => taskCreator,
            ),
          ],
          child: ReactiveFormBuilder(
            form: () => TaskFormGroup()..titleControl.value = 'title',
            builder: (context, formGroup, child) => child!,
            child: const AddTaskFab(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final addTaskButtonFinder = find.byType(AddTaskFab);
      await tester.tap(addTaskButtonFinder);
      verify(
        () => taskCreator.create(
          newTask: const NewTask(
            title: 'title',
          ),
        ),
      ).called(1);
      verifyNoMoreInteractions(taskCreator);
    },
  );

  testWidgets(
    '''

GIVEN a add task fab
AND a task form group
├─ THAT is invalid
WHEN the add task fab is tapped
THEN the form group is marked as touched
''',
    (tester) async {
      // *NOTE* using a tear down and an uncontrolled provider scope as
      // workarounds. More details at: https://github.com/rrousselGit/riverpod/issues/1941
      final container = ProviderContainer();
      addTearDown(container.dispose);
      await tester.pumpTestableWidget(
        UncontrolledProviderScope(
          container: container,
          child: ReactiveFormBuilder(
            form: TaskFormGroup.new,
            builder: (context, formGroup, child) => child!,
            child: const AddTaskFab(),
          ),
        ),
      );
      final addTaskButtonFinder = find.byType(AddTaskFab);
      final formGroup = ReactiveForm.of(tester.element(addTaskButtonFinder))!;
      await tester.pumpAndSettle();
      expect(formGroup.touched, isFalse);
      await tester.tap(addTaskButtonFinder);
      expect(formGroup.touched, isTrue);
    },
  );
}
