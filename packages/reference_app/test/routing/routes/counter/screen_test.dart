import 'package:altoke_app/routing/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/helpers.dart';

void main() {
  testWidgets(
    '''

GIVEN a routed app
├─ THAT starts with the counter path
WHEN the app starts
THEN the counter screen should be shown
''',
    (tester) async {
      await tester.pumpRouteAppWithInitialRoute('/counter');
      final counterScreenFinder = find.byType(CounterScreen);
      expect(counterScreenFinder, findsOneWidget);
    },
  );

  testWidgets(
    '''

GIVEN a counter screen
├─ THAT starts with a counter value of 0
WHEN the increment button is tapped
THEN the counter value should be 1
''',
    (tester) async {
      await tester.pumpRouteAppWithInitialRoute('/counter');
      expect(find.text('0'), findsOneWidget);
      expect(find.text('1'), findsNothing);
      final incrementButtonFinder = find.byType(FloatingActionButton);
      await tester.tap(incrementButtonFinder);
      await tester.pump();
      expect(find.text('0'), findsNothing);
      expect(find.text('1'), findsOneWidget);
    },
  );
}
