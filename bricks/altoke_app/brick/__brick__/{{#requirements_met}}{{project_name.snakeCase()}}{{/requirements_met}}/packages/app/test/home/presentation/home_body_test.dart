import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/counter/counter.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/home/home.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

import '../../helpers/helpers.dart';

@Dependencies([
  Counter,
  ])
void main() {
  testWidgets(
    '''

GIVEN a home body
WHEN it is displayed
THEN a counter example list tile should be displayed
''',
    (tester) async {
      await tester.pumpAppWithScaffold(const HomeBody());
      expect(find.byType(CounterExampleListTile), findsOneWidget);
    },
  );
}
