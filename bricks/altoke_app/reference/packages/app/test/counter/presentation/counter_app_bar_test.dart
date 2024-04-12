import 'package:altoke_app/counter/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  final localizationVariant = LocalizationVariant.withCommonSelector(
    localizedTextSelector: (l10n) => l10n.counterAppBarTitle,
    partialCases: {
      const (
        Locale('en'),
        'Counter',
      ),
      const (
        Locale('es'),
        // cspell:disable-next-line
        'Contador',
      ),
    },
  );

  testExhaustiveLocalizationVariant(
    '''

GIVEN a localization variant
WHEN testing the counter app bar
THEN all supported locales should be considered
''',
    localizationVariant,
  );

  testLocalizedWidget(
    '''

GIVEN a counter app bar
WHEN it is displayed
THEN the app bar should include the localized title
''',
    CounterAppBar(),
    ancestorFinder: find.byKey(
      const Key('<counter::counter-app-bar::title>'),
    ),
    variant: localizationVariant,
  );

  testWidgets(
    '''

GIVEN a counter app bar
WHEN it is displayed
THEN the app bar should include a reset counter icon button
''',
    (tester) async {
      await tester.pumpTestableWidget(CounterAppBar());
      expect(find.byType(ResetCounterIconButton), findsOneWidget);
    },
  );
}
