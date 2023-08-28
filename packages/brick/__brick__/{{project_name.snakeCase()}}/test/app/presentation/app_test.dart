import 'package:{{project_name.snakeCase()}}/app/app.dart';
import 'package:{{project_name.snakeCase()}}/routing/routing.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    '''

GIVEN an app
AND an app router
WHEN the app is built
THEN the home screen should be shown
''',
    (tester) async {
      final router = AppRouter();
      await tester.pumpWidget(MyApp(router: router));
      await tester.pumpAndSettle();
      final homeScreenFinder = find.byType(HomeScreen);
      expect(homeScreenFinder, findsOneWidget);
    },
  );
}
