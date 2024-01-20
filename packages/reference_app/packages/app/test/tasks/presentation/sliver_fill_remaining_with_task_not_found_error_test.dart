import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group(
    '''

GIVEN a localization variant for the message shown when a task is not found by its ID''',
    () {
      final localizationVariant = LocalizationVariant.withCommonSelector(
        localizedTextSelector: (l10) => l10.tasksNoTaskFoundByIdMessage,
        partialCases: {
          const (Locale('en'), 'No task found'),
          const (Locale('es'), 'No se encontró ninguna tarea'),
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
              SliverFillRemainingWithTaskNotFoundError(),
            ],
          ),
        ),
        ancestorFinder: find.byKey(
          const Key(
            '<tasks:sliver-fill-remaining-with-task-not-found-error:message>',
          ),
        ),
        variant: localizationVariant,
      );
    },
  );
}
