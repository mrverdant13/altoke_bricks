import 'package:altoke_app/counter/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

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
      final container = ProviderContainer();
      addTearDown(container.dispose);
      await tester.pumpTestableWidget(
        UncontrolledProviderScope(
          container: container,
          child: Consumer(
            builder: (context, ref, child) {
              ref.watch(counterPod);
              return child!;
            },
            child: const IncrementCounterFab(),
          ),
        ),
      );
      expect(container.read(counterPod), 0);
      await tester.pumpAndSettle();
      final incrementButtonFinder = find.byType(IncrementCounterFab);
      await tester.tap(incrementButtonFinder);
      await tester.pumpAndSettle();
      expect(container.read(counterPod), 1);
    },
  );
}
