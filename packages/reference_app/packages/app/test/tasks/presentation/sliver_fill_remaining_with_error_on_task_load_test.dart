import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group(
    '''

GIVEN a localization variant for the message shown when there is an error when loading a task''',
    () {
      final localizationVariant = LocalizationVariant.withCommonSelector(
        localizedTextSelector: (l10) =>
            l10.tasksUnexpectedErrorWhenLoadingTaskDetailsMessage,
        partialCases: {
          const (
            Locale('en'),
            'Uh oh! Something went wrong while loading the task details.'
          ),
          const (
            Locale('es'),
            // cspell:disable-next-line
            'Oh no! Algo salió mal al cargar los detalles de la tarea',
          ),
        },
      );

      testExhaustiveLocalizationVariant(
        '''

WHEN testing the error widget
THEN all supported locales should be considered
''',
        localizationVariant,
      );

      testLocalizedWidget(
        '''

WHEN the error widget is displayed
THEN the message should be localized
''',
        const Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverFillRemainingWithErrorOnTaskLoad(),
            ],
          ),
        ),
        ancestorFinder: find.byKey(
          const Key(
            '<tasks:sliver-fill-remaining-with-error-on-task-load:message>',
          ),
        ),
        variant: localizationVariant,
      );
    },
  );
}
