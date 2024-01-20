import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tasks/tasks.dart';

import '../../helpers/helpers.dart';

void main() {
  group(
    '''

GIVEN a localization variant for the app bar title when the details for an existing task''',
    () {
      final localizationVariant = LocalizationVariant.withCommonSelector(
        localizedTextSelector: (l10) => l10.tasksExistingTaskDetailsAppBarTitle,
        partialCases: {
          const (
            Locale('en'),
            'Details',
          ),
          const (
            Locale('es'),
            // cspell:disable-next-line
            'Detalles',
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

AND an existing task
WHEN the app bar is displayed
THEN the title should be localized
''',
        Scaffold(
          body: CustomScrollView(
            slivers: [
              ProviderScope(
                overrides: [
                  asyncTaskPod.overrideWith(
                    (ref) => Task(
                      id: 3294,
                      title: 'title',
                      isCompleted: false,
                      createdAt: DateTime.now(),
                    ),
                  ),
                ],
                child: const SliverTaskDetailsAppBar(),
              ),
            ],
          ),
        ),
        ancestorFinder: find.byKey(
          const Key('<tasks:sliver-task-details-app-bar:title>'),
        ),
        variant: localizationVariant,
      );
    },
  );

  group(
    '''

GIVEN a localization variant for the app bar title when the details for a non-exiting task''',
    () {
      final localizationVariant = LocalizationVariant.withCommonSelector(
        localizedTextSelector: (l10) =>
            l10.tasksNonExistingTaskDetailsAppBarTitle,
        partialCases: {
          const (
            Locale('en'),
            'Task not found',
          ),
          const (
            Locale('es'),
            // cspell:disable-next-line
            'Tarea no encontrada',
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

AND an non-existing task
WHEN the app bar is displayed
THEN the title should be localized
''',
        Scaffold(
          body: CustomScrollView(
            slivers: [
              ProviderScope(
                overrides: [
                  asyncTaskPod.overrideWith(
                    (ref) => null,
                  ),
                ],
                child: const SliverTaskDetailsAppBar(),
              ),
            ],
          ),
        ),
        ancestorFinder: find.byKey(
          const Key('<tasks:sliver-task-details-app-bar:title>'),
        ),
        variant: localizationVariant,
      );
    },
  );

  group(
    '''

GIVEN a localization variant for the app bar title when the details for an errored task''',
    () {
      final localizationVariant = LocalizationVariant.withCommonSelector(
        localizedTextSelector: (l10) => l10.tasksErroredTaskDetailsAppBarTitle,
        partialCases: {
          const (Locale('en'), 'Error'),
          const (Locale('es'), 'Error'),
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

AND an errored task
WHEN the app bar is displayed
THEN the title should be localized
''',
        Scaffold(
          body: CustomScrollView(
            slivers: [
              ProviderScope(
                overrides: [
                  asyncTaskPod.overrideWith(
                    (ref) => throw Exception('oops'),
                  ),
                ],
                child: const SliverTaskDetailsAppBar(),
              ),
            ],
          ),
        ),
        ancestorFinder: find.byKey(
          const Key('<tasks:sliver-task-details-app-bar:title>'),
        ),
        variant: localizationVariant,
      );
    },
  );

  group(
    '''

GIVEN a localization variant for the app bar title when the details for a loading task''',
    () {
      final localizationVariant = LocalizationVariant.withCommonSelector(
        localizedTextSelector: (l10) => l10.tasksLoadingTaskDetailsAppBarTitle,
        partialCases: {
          const (
            Locale('en'),
            'Loading...',
          ),
          const (
            Locale('es'),
            // cspell:disable-next-line
            'Cargando...',
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

AND an errored task
WHEN the app bar is displayed
THEN the title should be localized
''',
        Scaffold(
          body: CustomScrollView(
            slivers: [
              ProviderScope(
                overrides: [
                  asyncTaskPod.overrideWith(
                    (ref) async {
                      await Future.doWhile(() => false);
                      return null;
                    },
                  ),
                ],
                child: const SliverTaskDetailsAppBar(),
              ),
            ],
          ),
        ),
        ancestorFinder: find.byKey(
          const Key('<tasks:sliver-task-details-app-bar:title>'),
        ),
        variant: localizationVariant,
      );
    },
  );
}
