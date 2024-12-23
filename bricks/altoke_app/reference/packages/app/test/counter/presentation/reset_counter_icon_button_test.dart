import 'dart:math';

import 'package:altoke_app/counter/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  final localizationVariant = LocalizationVariant.withCommonSelector(
    localizedTextSelector: (l10n) => l10n.counterResetButtonTooltip,
    partialCases: {
      const (
        Locale('en'),
        'Reset',
      ),
      const (
        Locale('es'),
        // cspell:disable-next-line
        'Reiniciar',
      ),
    },
  );

  testExhaustiveLocalizationVariant(
    '''

GIVEN a localization variant
WHEN testing the reset counter icon button
THEN all supported locales should be considered
''',
    localizationVariant,
  );

  testLocalizedWidget(
    '''

GIVEN a reset counter icon button
WHEN it is displayed
THEN the button should include the localized tooltip
''',
    const ResetCounterIconButton(),
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
