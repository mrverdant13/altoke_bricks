import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group(
    '''

GIVEN a localization variant for the title of the new task app bar''',
    () {
      final localizationVariant = LocalizationVariant.withCommonSelector(
        localizedTextSelector: (l10) => l10.tasksNewTaskAppBarTitle,
        partialCases: {
          const (
            Locale('en'),
            'New task',
          ),
          const (
            Locale('es'),
            // cspell:disable-next-line
            'Nueva tarea',
          ),
        },
      );

      testExhaustiveLocalizationVariant(
        '''

WHEN testing the app bar
THEN all supported locales should be considered
''',
        localizationVariant,
      );

      testLocalizedWidget(
        '''

WHEN the app bar is displayed
THEN the title should be localized
''',
        const Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverNewTaskAppBar(),
            ],
          ),
        ),
        ancestorFinder: find.byKey(
          const Key('<tasks::sliver-new-task-app-bar::title>'),
        ),
        variant: localizationVariant,
      );
    },
  );
}
