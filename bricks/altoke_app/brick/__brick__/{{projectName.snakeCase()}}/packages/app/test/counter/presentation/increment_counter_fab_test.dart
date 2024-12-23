import 'package:{{projectName.snakeCase()}}/counter/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  final localizationVariant = LocalizationVariant.withCommonSelector(
    localizedTextSelector: (l10n) => l10n.counterIncrementButtonTooltip,
    partialCases: {
      const (
        Locale('en'),
        'Increment',
      ),
      const (
        Locale('es'),
        // cspell:disable-next-line
        'Incrementar',
      ),
    },
  );

  testExhaustiveLocalizationVariant(
    '''

GIVEN a localization variant
WHEN testing the increment counter fab
THEN all supported locales should be considered
''',
    localizationVariant,
  );

  testLocalizedWidget(
    '''

GIVEN a increment counter fab
WHEN it is displayed
THEN the fab should include the localized tooltip
''',
    const IncrementCounterFab(),
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

GIVEN a increment counter fab
WHEN it is tapped
THEN the counter should be incremented
''',
    (tester) async {
      final counterNotifier = MockCounter(() => 5);
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
          child: const IncrementCounterFab(),
        ),
      );
      expect(container.read(counterPod), isNonZero);
      await tester.pumpAndSettle();
      final incrementButtonFinder = find.byType(IncrementCounterFab);
      await tester.tap(incrementButtonFinder);
      await tester.pumpAndSettle();
      verify(counterNotifier.increment).called(1);
    },
  );
}
