import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  final localizationVariant = LocalizationVariant.withCommonSelector(
    localizedTextSelector: (l10n) => l10n.createTaskButtonTooltip,
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

GIVEN a localization variant
WHEN testing the show task creation dialog fab
THEN all supported locales should be considered
''',
    localizationVariant,
  );

  testLocalizedWidget(
    '''

GIVEN a show task creation dialog fab
WHEN it is displayed
THEN the fab should include the localized tooltip
''',
    const ShowTaskCreationDialogFab(),
    postPumpAction: (tester) async {
      final tooltipFinder = find.byType(Tooltip);
      await tester.longPress(tooltipFinder);
      await tester.pumpAndSettle();
    },
    ancestorFinder: find.byType(Overlay),
    variant: localizationVariant,
  );

  testWidgets(
    '''

GIVEN a show task creation dialog fab
WHEN it is tapped
THEN a task creation dialog should be shown
''',
    (tester) async {
      await tester.pumpAppWithScaffold(
        const ShowTaskCreationDialogFab(),
      );
      final showTaskCreationDialogButtonFinder =
          find.byType(ShowTaskCreationDialogFab);
      await tester.tap(showTaskCreationDialogButtonFinder);
      await tester.pumpAndSettle();
      expect(find.byType(TaskCreationDialog), findsOneWidget);
    },
  );
}
