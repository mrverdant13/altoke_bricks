import 'package:altoke_app/counter/counter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  testWidgets('''

GIVEN a counter body
WHEN it is displayed
THEN a count message and a count value should be shown
''', (tester) async {
    await tester.pumpAppWithScreen(const CounterBody());
    expect(find.byType(PushCountMessage), findsOneWidget);
    expect(find.byType(PushCountValue), findsOneWidget);
  });

  testWidgets(
    '''

GIVEN a counter body
├─ THAT has a count of 0
WHEN it is displayed
THEN the body should include the localized message
''',
    (tester) async {
      await tester.pumpAppWithScreen(
        ProviderScope(
          overrides: [
            counterPod.overrideWith(
              () => MockCounter(() => 0),
            ),
          ],
          child: const CounterBody(),
        ),
      );
      expect(
        find.l10n.widgetWithText(
          PushCountMessage,
          (l10n) => l10n.counterPushTimesMessage(0),
        ),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    '''

GIVEN a counter body
├─ THAT has a count of 1
WHEN it is displayed
THEN the body should include the localized message
''',
    (tester) async {
      await tester.pumpAppWithScreen(
        ProviderScope(
          overrides: [
            counterPod.overrideWith(
              () => MockCounter(() => 1),
            ),
          ],
          child: const CounterBody(),
        ),
      );
      expect(
        find.l10n.widgetWithText(
          PushCountMessage,
          (l10n) => l10n.counterPushTimesMessage(1),
        ),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    '''

GIVEN a counter body
├─ THAT has a count of 8
WHEN it is displayed
THEN the body should include the localized message
''',
    (tester) async {
      await tester.pumpAppWithScreen(
        ProviderScope(
          overrides: [
            counterPod.overrideWith(
              () => MockCounter(() => 8),
            ),
          ],
          child: const CounterBody(),
        ),
      );
      expect(
        find.l10n.widgetWithText(
          PushCountMessage,
          (l10n) => l10n.counterPushTimesMessage(8),
        ),
        findsOneWidget,
      );
    },
  );
}
