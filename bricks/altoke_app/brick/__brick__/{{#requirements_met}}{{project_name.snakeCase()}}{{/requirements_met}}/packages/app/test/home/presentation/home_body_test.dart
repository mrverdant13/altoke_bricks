
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/counter/counter.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/home/home.dart';

import 'package:flutter_test/flutter_test.dart';{{#use_riverpod}}import 'package:riverpod_annotation/experimental/scope.dart';{{/use_riverpod}}import '../../helpers/helpers.dart';

{{#use_riverpod}}@Dependencies([
  Counter,
  ]){{/use_riverpod}}
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
