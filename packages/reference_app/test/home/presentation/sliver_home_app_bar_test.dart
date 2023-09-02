import 'package:altoke_app/home/home.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  final localizationVariant = LocalizationVariant.withCommonSelector(
    localizedTextSelector: (l10n) => l10n.homeAppBarTitle,
    partialCases: {
      const (Locale('en'), 'Examples'),
      const (Locale('es'), 'Ejemplos'),
    },
  );

  testExhaustiveLocalizationVariant(
    '''

GIVEN a localization variant
WHEN testing the sliver home app bar
THEN all supported locales should be considered
''',
    localizationVariant,
  );

  testLocalizedWidget(
    '''

GIVEN a sliver home app bar
WHEN it is displayed
THEN the app bar should include the localized title
''',
    const CustomScrollView(
      slivers: [
        SliverHomeAppBar(),
      ],
    ),
    ancestorFinder: find.byKey(
      const Key(
        '<counter::sliver-home-app-bar::title>',
      ),
    ),
    variant: localizationVariant,
  );
}
