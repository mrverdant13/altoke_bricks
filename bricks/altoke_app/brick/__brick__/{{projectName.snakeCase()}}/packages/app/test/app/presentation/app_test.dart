import 'package:{{projectName.snakeCase()}}/app/app.dart';
import 'package:{{projectName.snakeCase()}}/routing/routing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
{{#use_auto_route_router}}testWidgets(
    '''

GIVEN an app
AND an app router
WHEN the app is built
THEN the counter screen should be shown
''',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();
      final homeScreenFinder = find.byType(CounterScreen);
      expect(homeScreenFinder, findsOneWidget);
    },
  );{{/use_auto_route_router}}{{#use_go_router_router}}testWidgets(
    '''

GIVEN an app
AND an app router
WHEN the app is built
THEN the counter screen should be shown
''',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();
      final homeScreenFinder = find.byType(CounterScreen);
      expect(homeScreenFinder, findsOneWidget);
    },
  );{{/use_go_router_router}}
}
