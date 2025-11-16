import 'package:altoke_app/counter/counter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

import '../../helpers/helpers.dart';

@Dependencies([
  Counter,
])
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
