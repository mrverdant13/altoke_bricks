import 'package:{{project_name.snakeCase()}}/app/app.dart';
import 'package:{{project_name.snakeCase()}}/routing/routing.dart';
import 'package:{{project_name.snakeCase()}}/tasks/tasks.dart';{{#use_auto_route_router}}import 'package:auto_route/auto_route.dart';{{/use_auto_route_router}}import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';{{#use_go_router_router}}import 'package:go_router/go_router.dart';{{/use_go_router_router}}import '../../../../helpers/app_tester.dart';

void main() {
{{#use_auto_route_router}}testWidgets(
    '''

GIVEN a routed app
├─ THAT starts with the tasks path
WHEN the app starts
THEN the tasks screen should be shown
''',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MyApp(
            routerConfig: AppRouter().config(
              deepLinkBuilder: (_) => const DeepLink.path('/tasks'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final tasksScreenFinder = find.byType(TasksScreen);
      expect(tasksScreenFinder, findsOneWidget);
    },
  );{{/use_auto_route_router}}{{#use_go_router_router}}testWidgets(
    '''

GIVEN a routed app
├─ THAT starts with the tasks path
WHEN the app starts
THEN the tasks screen should be shown
''',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MyApp(
            routerConfig: GoRouter(
              routes: $appRoutes,
              initialLocation: '/tasks',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final tasksScreenFinder = find.byType(TasksScreen);
      expect(tasksScreenFinder, findsOneWidget);
    },
  );{{/use_go_router_router}}testWidgets(
    '''

GIVEN a tasks screen
WHEN the screen is displayed
THEN its layout should be shown
├─ THAT includes a tasks app bar
├─ AND includes the tasks filter controls
├─ AND includes the tasks list
├─ AND includes a FAB to create a new task
''',
    (tester) async {
      await tester.pumpTestableWidget(
        const ProviderScope(
          child: TasksScreen(),
        ),
      );
      final layoutFinder = find.byType(TasksScreenLayout);
      expect(layoutFinder, findsOneWidget);
      final appBarFinder = find.descendant(
        of: layoutFinder,
        matching: find.byType(SliverTasksAppBar),
      );
      expect(appBarFinder, findsOneWidget);
      final filterControlsFinder = find.descendant(
        of: layoutFinder,
        matching: find.byType(SliverTasksFilterControls),
      );
      expect(filterControlsFinder, findsOneWidget);
      final listFinder = find.descendant(
        of: layoutFinder,
        matching: find.byType(SliverTasksList),
      );
      expect(listFinder, findsOneWidget);
      final fabFinder = find.descendant(
        of: layoutFinder,
        matching: find.byType(NewTaskFab),
      );
      expect(fabFinder, findsOneWidget);
    },
  );
}
