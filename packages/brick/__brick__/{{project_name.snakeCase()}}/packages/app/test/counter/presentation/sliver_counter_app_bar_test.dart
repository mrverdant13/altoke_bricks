import 'package:{{project_name.snakeCase()}}/counter/counter.dart';
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
WHEN testing the sliver counter app bar
THEN all supported locales should be considered
''',
    localizationVariant,
  );

  testLocalizedWidget(
    '''

GIVEN a sliver counter app bar
WHEN it is displayed
THEN the app bar should include the localized title
''',
    const CustomScrollView(
      slivers: [
        SliverCounterAppBar(),
      ],
    ),
    ancestorFinder: find.byKey(
      const Key(
        '<counter::sliver-counter-app-bar::title>',
      ),
    ),
    variant: localizationVariant,
  );
}
