import 'package:altoke_app/app/app.dart';
import 'package:altoke_app/routing/routing.dart';
/*{{#use_auto_route_router}}*/
import 'package:auto_route/auto_route.dart';
/*{{/use_auto_route_router}}*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
/*{{#use_go_router_router}}*/
import 'package:go_router/go_router.dart';
/*{{/use_go_router_router}}*/

void main() {
/*w 1v w*/
/*{{#use_auto_route_router}}*/
  testWidgets(
    '''

GIVEN a routed app
├─ THAT starts with the task details path
WHEN the app starts
THEN the task details screen should be shown
''',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MyApp(
            routerConfig: AppRouter().config(
              deepLinkBuilder: (_) => const DeepLink.path('/tasks/123'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final tasksScreenFinder = find.byType(TaskDetailsScreen);
      expect(tasksScreenFinder, findsOneWidget);
    },
  );
/*{{/use_auto_route_router}}*/

/*{{#use_go_router_router}}*/
  testWidgets(
    '''

GIVEN a routed app
├─ THAT starts with the task details path
WHEN the app starts
THEN the task details screen should be shown
''',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MyApp(
            routerConfig: GoRouter(
              routes: $appRoutes,
              initialLocation: '/tasks/123',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final tasksScreenFinder = find.byType(TaskDetailsScreen);
      expect(tasksScreenFinder, findsOneWidget);
    },
  );
/*{{/use_go_router_router}}*/
}
