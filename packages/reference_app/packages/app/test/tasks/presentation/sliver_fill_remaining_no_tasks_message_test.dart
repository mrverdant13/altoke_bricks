import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group(
    '''

GIVEN a localization variant for the message shown when there are no tasks''',
    () {
      final localizationVariant = LocalizationVariant.withCommonSelector(
        localizedTextSelector: (l10) => l10.tasksEmptyTasksMessage,
        partialCases: {
          const (
            Locale('en'),
            'No tasks yet',
          ),
          const (
            Locale('es'),
            // cspell:disable-next-line
            'Aún no hay tareas',
          ),
        },
      );

      testExhaustiveLocalizationVariant(
        '''

WHEN testing the sliver empty tasks message
THEN all supported locales should be considered
''',
        localizationVariant,
      );

      testLocalizedWidget(
        '''

WHEN the sliver empty tasks message is displayed
THEN the message should be localized
''',
        const Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverFillRemainingNoTasksMessage(),
            ],
          ),
        ),
        ancestorFinder: find.byType(SliverFillRemaining),
        variant: localizationVariant,
      );
    },
  );
}
