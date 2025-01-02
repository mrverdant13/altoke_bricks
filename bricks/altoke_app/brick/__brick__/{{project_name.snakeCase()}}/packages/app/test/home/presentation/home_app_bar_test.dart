import 'package:{{project_name.snakeCase()}}/home/home.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  final localizationVariant = LocalizationVariant.withCommonSelector(
    localizedTextSelector: (l10n) => l10n.homeAppBarTitle,
    partialCases: {
      const (
        Locale('en'),
        'Examples',
      ),
      const (
        Locale('es'),
        // cspell:disable-next-line
        'Ejemplos',
      ),
    },
  );

  testExhaustiveLocalizationVariant(
    '''

GIVEN a localization variant
WHEN testing the home app bar
THEN all supported locales should be considered
''',
    localizationVariant,
  );

  testLocalizedWidget(
    '''

GIVEN a home app bar
WHEN it is displayed
THEN the app bar should include the localized title
''',
    HomeAppBar(),
    ancestorFinder: find.byKey(HomeAppBarTitle.textKey),
    variant: localizationVariant,
  );
}
