import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

import '../../helpers/helpers.dart';

@Dependencies([
  localTasksDao,
])
void main() {
  testWidgets(
    '''

GIVEN a show task creation dialog fab
WHEN it is displayed
THEN the fab should include the localized tooltip
''',
    (tester) async {
      await tester.pumpAppWithScaffold(const ShowTaskCreationDialogFab());
      expect(
        find.l10n.byTooltip((l10n) => l10n.createTaskButtonTooltip),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    '''

GIVEN a show task creation dialog fab
WHEN it is tapped
THEN a task creation dialog should be shown
''',
    (tester) async {
      await tester.pumpAppWithScaffold(const ShowTaskCreationDialogFab());
      final showTaskCreationDialogButtonFinder = find.byType(
        ShowTaskCreationDialogFab,
      );
      await tester.tap(showTaskCreationDialogButtonFinder);
      await tester.pumpAndSettle();
      expect(find.byType(TaskCreationDialog), findsOneWidget);
    },
  );
}
