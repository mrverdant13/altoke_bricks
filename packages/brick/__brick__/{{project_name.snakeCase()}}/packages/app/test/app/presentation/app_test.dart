import 'package:{{project_name.snakeCase()}}/app/app.dart';
import 'package:{{project_name.snakeCase()}}/routing/routing.dart';
import 'package:flutter_test/flutter_test.dart';{{#use_go_router_router}}import 'package:go_router/go_router.dart';{{/use_go_router_router}}void main() {
{{#use_auto_route_router}}testWidgets(
    '''

GIVEN an app
AND an app router
WHEN the app is built
THEN the home screen should be shown
''',
    (tester) async {
      final routerConfig = AppRouter().config();
      await tester.pumpWidget(MyApp(routerConfig: routerConfig));
      await tester.pumpAndSettle();
      final homeScreenFinder = find.byType(HomeScreen);
      expect(homeScreenFinder, findsOneWidget);
    },
  );{{/use_auto_route_router}}{{#use_go_router_router}}testWidgets(
    '''

GIVEN an app
AND an app router
WHEN the app is built
THEN the home screen should be shown
''',
    (tester) async {
      final routerConfig = GoRouter(routes: $appRoutes);
      await tester.pumpWidget(MyApp(routerConfig: routerConfig));
      await tester.pumpAndSettle();
      final homeScreenFinder = find.byType(HomeScreen);
      expect(homeScreenFinder, findsOneWidget);
    },
  );{{/use_go_router_router}}
}
