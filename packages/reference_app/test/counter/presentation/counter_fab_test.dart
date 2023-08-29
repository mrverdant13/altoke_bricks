import 'package:altoke_app/counter/counter.dart';
import 'package:flutter/material.dart';
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
    CounterFab(
      onTap: () {},
    ),
    postPumpAction: (tester) async {
      final tooltipFinder = find.byType(Tooltip);
      await tester.longPress(tooltipFinder);
      await tester.pumpAndSettle();
    },
    ancestorFinder: find.byType(Overlay),
    variant: localizationVariant,
  );
}
