import 'package:altoke_app/app/app.dart';
import 'package:altoke_app/counter/state/counter_pod.dart';
/*remove-start*/
import 'package:altoke_app/external/external.dart';
/*remove-end-x*/
import 'package:altoke_app/flavors/flavors.dart';
import 'package:altoke_app/routing/routing.dart';
/*remove-start*/
import 'package:altoke_app/tasks/tasks.dart';
/*remove-end-x*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
/*x{{#use_go_router}}*/
import 'package:go_router/go_router.dart';
/*x{{/use_go_router}}*/
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([
  Counter,
  /*remove-start*/
  SelectedRouterPackage,
  SelectedStateManagementPackage,
  SelectedLocalDatabasePackage,
  asyncTasks,
  localTasksDao,
  /*remove-end-x*/
])
void main() {
  setUp(() {
    debugFlavor = AppFlavor.dev;
  });

  tearDown(() {
    debugFlavor = null;
  });

  testWidgets(
    '''

GIVEN a routed app
├─ THAT starts with the home path
WHEN the app starts
THEN the home screen should be shown
''',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            asyncInitializationPod.overrideWith((_) async {}),
            /*x-remove-start*/
            routerConfigPod.overrideWithValue(
              GoRouter(routes: $appRoutes, initialLocation: '/'),
            ),
            /*remove-end*/
          ],
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();
      final homeScreenFinder = find.byType(HomeScreen);
      expect(homeScreenFinder, findsOneWidget);
    },
  );
}
