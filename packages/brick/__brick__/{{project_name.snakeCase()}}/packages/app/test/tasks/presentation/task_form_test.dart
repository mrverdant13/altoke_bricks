import 'package:{{project_name.snakeCase()}}/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../helpers/helpers.dart';

void main() {
  group(
    '''

GIVEN an injected task form group''',
    () {
      late TaskFormGroup taskFormGroup;

      setUp(
        () {
          taskFormGroup = TaskFormGroup();
        },
      );

      tearDown(
        () {
          taskFormGroup.dispose();
        },
      );

      group(
        '''

AND a localization variant for the label of the task title field''',
        () {
          final localizationVariant = LocalizationVariant.withCommonSelector(
            localizedTextSelector: (l10n) => l10n.tasksTaskTitleTextFieldLabel,
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

WHEN testing the task title field
THEN all supported locales should be considered
''',
            localizationVariant,
          );

          testLocalizedWidget(
            '''

WHEN the task title field is displayed
THEN the field should include the localized label
''',
            Scaffold(
              body: ReactiveFormBuilder(
                form: () => taskFormGroup,
                child: const ReactiveTaskTitleField(),
                builder: (context, form, child) => child!,
              ),
            ),
            ancestorFinder: find.byKey(
              const Key(
                '<tasks::reactive-task-title-field::label>',
              ),
            ),
            variant: localizationVariant,
          );
        },
      );

      group(
        '''

AND a localization variant for the error message of the task title field when the field is empty''',
        () {
          final localizationVariant = LocalizationVariant.withCommonSelector(
            localizedTextSelector: (l10n) =>
                l10n.tasksRequiredTaskTitleTextFieldErrorMessage,
            partialCases: {
              const (
                Locale('en'),
                'The title is required',
              ),
              const (
                Locale('es'),
                // cspell:disable-next-line
                'El título es obligatorio',
              ),
            },
          );

          testExhaustiveLocalizationVariant(
            '''

WHEN testing the task title field
THEN all supported locales should be considered
''',
            localizationVariant,
          );

          testLocalizedWidget(
            '''

AND an empty task title field
WHEN the task title field is displayed
AND the field is marked as touched
THEN the field should include the localized error message
''',
            Scaffold(
              body: ReactiveFormBuilder(
                form: () => taskFormGroup
                  ..titleControl.value = ''
                  ..markAllAsTouched(),
                child: const ReactiveTaskTitleField(),
                builder: (context, form, child) => child!,
              ),
            ),
            ancestorFinder: find.descendant(
              of: find.byType(InputDecorator),
              matching: find.descendant(
                of: find.byType(Semantics),
                matching: find.descendant(
                  of: find.byType(FadeTransition),
                  matching: find.byType(FractionalTranslation),
                ),
              ),
            ),
            variant: localizationVariant,
          );
        },
      );

      group(
        '''

AND a localization variant for the label of the task description field''',
        () {
          final localizationVariant = LocalizationVariant.withCommonSelector(
            localizedTextSelector: (l10n) =>
                l10n.tasksTaskDescriptionTextFieldLabel,
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

WHEN testing the task description field
THEN all supported locales should be considered
''',
            localizationVariant,
          );

          testLocalizedWidget(
            '''

WHEN the task description field is displayed
THEN the field should include the localized
''',
            Scaffold(
              body: ReactiveFormBuilder(
                form: () => taskFormGroup,
                child: const ReactiveTaskDescriptionField(),
                builder: (context, form, child) => child!,
              ),
            ),
            ancestorFinder: find.byKey(
              const Key(
                '<tasks::reactive-task-description-field::label>',
              ),
            ),
            variant: localizationVariant,
          );
        },
      );
    },
  );
}
