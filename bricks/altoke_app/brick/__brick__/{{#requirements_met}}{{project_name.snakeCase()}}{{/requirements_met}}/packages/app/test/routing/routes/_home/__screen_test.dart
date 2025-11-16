import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/app/app.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/counter/state/counter_pod.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/flavors/flavors.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/routing/routing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';{{#use_go_router}}
import 'package:go_router/go_router.dart';{{/use_go_router}}
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([
  Counter,
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
