import 'package:{{project_name.snakeCase()}}/counter/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  final localizationVariant = LocalizationVariant.withCommonSelector(
    localizedTextSelector: (l10n) => l10n.counterIncrementButtonTooltip,
    partialCases: {
      const (Locale('en'), 'Increment'),
      const (Locale('es'), 'Incrementar'),
    },
  );

  testExhaustiveLocalizationVariant(
    '''

GIVEN a localization variant
WHEN testing the counter fab
THEN all supported locales should be considered
''',
    localizationVariant,
  );

  testLocalizedWidget(
    '''

GIVEN a counter fab
WHEN it is displayed
THEN the fab should include the localized tooltip
''',
    const CounterFab(),
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

GIVEN a counter fab
WHEN it is tapped
THEN the counter should be incremented
''',
    (tester) async {
      final container = ProviderContainer();
      await tester.pumpTestableWidget(
        ProviderScope(
          parent: container,
          child: Consumer(
            builder: (context, ref, child) {
              ref.watch(counterPod);
              return child!;
            },
            child: const CounterFab(),
          ),
        ),
      );
      expect(container.read(counterPod), 0);
      await tester.pumpAndSettle();
      final incrementButtonFinder = find.byType(CounterFab);
      await tester.tap(incrementButtonFinder);
      await tester.pumpAndSettle();
      expect(container.read(counterPod), 1);
    },
  );
}
