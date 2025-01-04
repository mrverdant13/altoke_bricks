import 'package:altoke_app/counter/counter.dart';
import 'package:altoke_app/home/home.dart';
import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  testWidgets('''

GIVEN a home body
WHEN it is displayed
THEN a counter example list tile should be displayed
''', (tester) async {
    await tester.pumpAppWithScaffold(const HomeBody());
    expect(find.byType(CounterExampleListTile), findsOneWidget);
    /*remove-start*/
    expect(find.byType(TasksExampleListTile), findsOneWidget);
    /*remove-end*/
  });
}