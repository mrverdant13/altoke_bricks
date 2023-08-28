import 'package:altoke_app/routing/routing.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/helpers.dart';

void main() {
  testWidgets(
    '''

GIVEN a routed app
├─ THAT starts with the home path
WHEN the app starts
THEN the home screen should be shown
''',
    (tester) async {
      await tester.pumpRouteAppWithInitialRoute('/');
      final homeScreenFinder = find.byType(HomeScreen);
      expect(homeScreenFinder, findsOneWidget);
    },
  );
}
