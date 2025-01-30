import 'dart:math';

import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/counter/counter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  testWidgets(
    '''

GIVEN a reset counter icon button
WHEN it is displayed
THEN the button should include the localized tooltip
''',
    (tester) async {
      await tester.pumpAppWithScreen(
        const ResetCounterIconButton(),
      );
      expect(
        find.l10n.byTooltip(
          (l10n) => l10n.counterResetButtonTooltip,
        ),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    '''

GIVEN a reset counter icon button
WHEN it is tapped
THEN the counter should be reset
''',
    (tester) async {
      final counterNotifier = MockCounter(() => 0);
      final container = ProviderContainer(
        overrides: [
          counterPod.overrideWith(
            () => counterNotifier,
          ),
        ],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(counterPod.notifier, (_, __) {});
      addTearDown(subscription.close);
      await tester.pumpAppWithScreen(
        UncontrolledProviderScope(
          container: container,
          child: const ResetCounterIconButton(),
        ),
      );
      counterNotifier.state = Random().nextInt(100) + 1;
      expect(container.read(counterPod), isNonZero);
      await tester.pumpAndSettle();
      final resetButtonFinder = find.byType(ResetCounterIconButton);
      await tester.tap(resetButtonFinder);
      await tester.pumpAndSettle();
      expect(container.read(counterPod), isZero);
      await tester.pumpAndSettle();
    },
  );
}
