import 'package:{{projectName.snakeCase()}}/counter/counter.dart';
import 'package:{{projectName.snakeCase()}}/home/home.dart';
import 'package:{{projectName.snakeCase()}}/tasks/tasks.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  testWidgets('''

GIVEN a home body
WHEN it is displayed
THEN a counter example list tile should be displayed
''', (tester) async {
    await tester.pumpAppWithScaffold(const HomeBody());
    expect(find.byType(CounterExampleListTile), findsOneWidget);});
}
