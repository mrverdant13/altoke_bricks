import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  testWidgets(
    '''

GIVEN a home app bar
WHEN it is displayed
THEN the app bar should include the localized title
''',
    (tester) async {
      await tester.pumpAppWithScreen(
        Scaffold(
          appBar: HomeAppBar(),
        ),
      );
      expect(find.byType(HomeAppBarTitle), findsOneWidget);
      expect(
        find.l10n.widgetWithText(
          HomeAppBarTitle,
          (l10n) => l10n.homeAppBarTitle,
        ),
        findsOneWidget,
      );
    },
  );
}
