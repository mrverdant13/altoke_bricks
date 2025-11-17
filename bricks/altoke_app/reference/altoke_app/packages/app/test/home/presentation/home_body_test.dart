/*remove-start*/
import 'package:altoke_app/app/app.dart';
/*remove-end-x*/
import 'package:altoke_app/counter/counter.dart';
/*remove-start*/
import 'package:altoke_app/external/external.dart';
/*remove-end-x*/
import 'package:altoke_app/home/home.dart';
/*remove-start*/
import 'package:altoke_app/routing/routing.dart';
import 'package:altoke_app/tasks/tasks.dart';
/*remove-end*/
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

import '../../helpers/helpers.dart';

@Dependencies([
  Counter,
  /*remove-start*/
  SelectedLocalDatabasePackage,
  SelectedRouterPackage,
  SelectedStateManagementPackage,
  asyncTasks,
  localTasksDao,
  /*remove-end-x*/
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
      /*x-remove-start*/
      expect(find.byType(TasksExampleListTile), findsOneWidget);
      /*remove-end*/
    },
  );
}
