import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group(
    '''

GIVEN a localization variant for the message shown when there is a counting error''',
    () {
      final localizationVariant = LocalizationVariant.withCommonSelector(
        localizedTextSelector: (l10) =>
            l10.tasksUnexpectedTasksLoadErrorMessage,
        partialCases: {
          const (
            Locale('en'),
            'Uh oh! Something went wrong while loading the tasks.'
          ),
          const (
            Locale('es'),
            // cspell:disable-next-line
            'Oh no! Algo salió mal al cargar las tareas',
          ),
        },
      );

      testExhaustiveLocalizationVariant(
        '''

WHEN testing the sliver count error message
THEN all supported locales should be considered
''',
        localizationVariant,
      );

      testLocalizedWidget(
        '''

WHEN the sliver count error message is displayed
THEN the message should be localized
''',
        const Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverFillRemainingWithErrorOnTasksLoad(),
            ],
          ),
        ),
        ancestorFinder: find.byType(SliverFillRemaining),
        variant: localizationVariant,
      );
    },
  );
}
