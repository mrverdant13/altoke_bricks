import 'package:altoke_app/counter/counter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  {
    final localizationVariant = LocalizationVariant.withCommonSelector(
      localizedTextSelector: (l10n) => l10n.counterPushTimesMessage(0),
      partialCases: {
        const (Locale('en'), 'You have not pushed the button yet.'),
        const (Locale('es'), 'Aún no has pulsado el botón.'),
      },
    );

    testExhaustiveLocalizationVariant(
      '''

GIVEN a localization variant
AND a counter body
├─ THAT has a count of 0
WHEN testing the counter body
THEN all supported locales should be considered
''',
      localizationVariant,
    );

    testLocalizedWidget(
      '''

GIVEN a counter body
├─ THAT has a count of 0
WHEN it is displayed
THEN the body should include the localized message
''',
      CustomScrollView(
        slivers: [
          SliverCounterBody(
            count: 0,
          ),
        ],
      ),
      ancestorFinder: find.byKey(
        const Key('<counter::sliver-counter-body::push-count-message>'),
      ),
      variant: localizationVariant,
    );
  }

  {
    final localizationVariant = LocalizationVariant.withCommonSelector(
      localizedTextSelector: (l10n) => l10n.counterPushTimesMessage(1),
      partialCases: {
        const (Locale('en'), 'You have pushed the button one time.'),
        const (Locale('es'), 'Has pulsado el botón una vez.'),
      },
    );

    testExhaustiveLocalizationVariant(
      '''

GIVEN a localization variant
AND a counter body
├─ THAT has a count of 1
WHEN testing the counter body
THEN all supported locales should be considered
''',
      localizationVariant,
    );

    testLocalizedWidget(
      '''

GIVEN a counter body
├─ THAT has a count of 1
WHEN it is displayed
THEN the body should include the localized message
''',
      CustomScrollView(
        slivers: [
          SliverCounterBody(
            count: 1,
          ),
        ],
      ),
      ancestorFinder: find.byKey(
        const Key('<counter::sliver-counter-body::push-count-message>'),
      ),
      variant: localizationVariant,
    );
  }

  {
    final localizationVariant = LocalizationVariant.withCommonSelector(
      localizedTextSelector: (l10n) => l10n.counterPushTimesMessage(8),
      partialCases: {
        const (Locale('en'), 'You have pushed the button 8 times.'),
        const (Locale('es'), 'Has pulsado el botón 8 veces.'),
      },
    );

    testExhaustiveLocalizationVariant(
      '''

GIVEN a localization variant
AND a counter body
├─ THAT has a count of 8
WHEN testing the counter body
THEN all supported locales should be considered
''',
      localizationVariant,
    );

    testLocalizedWidget(
      '''

GIVEN a counter body
├─ THAT has a count of 8
WHEN it is displayed
THEN the body should include the localized message
''',
      CustomScrollView(
        slivers: [
          SliverCounterBody(
            count: 8,
          ),
        ],
      ),
      ancestorFinder: find.byKey(
        const Key('<counter::sliver-counter-body::push-count-message>'),
      ),
      variant: localizationVariant,
    );
  }
}
