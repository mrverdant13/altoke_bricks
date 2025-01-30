import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/counter/counter.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  testWidgets(
    '''

GIVEN a counter app bar
WHEN it is displayed
THEN the app bar should include the localized title
''',
    (tester) async {
      await tester.pumpAppWithScreen(CounterAppBar());
      expect(find.l10n.text((l10n) => l10n.counterAppBarTitle), findsOneWidget);
    },
  );

  testWidgets(
    '''

GIVEN a counter app bar
WHEN it is displayed
THEN the app bar should include a title and reset counter icon button
''',
    (tester) async {
      await tester.pumpAppWithScreen(CounterAppBar());
      expect(find.byType(CounterAppBarTitle), findsOneWidget);
      expect(find.byType(ResetCounterIconButton), findsOneWidget);
    },
  );
}
