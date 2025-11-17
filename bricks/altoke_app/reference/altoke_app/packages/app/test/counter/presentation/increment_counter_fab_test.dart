/*remove-start*/
import 'package:altoke_app/app/app.dart';
/*remove-end-x*/
import 'package:altoke_app/counter/counter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

import '../../helpers/helpers.dart';

@Dependencies([
  Counter,
  /*x-remove-start*/
  SelectedStateManagementPackage,
  /*remove-end-x*/
])
void main() {
  testWidgets(
    '''

GIVEN a increment counter fab
WHEN it is displayed
THEN the fab should include the localized tooltip
''',
    (tester) async {
      await tester.pumpAppWithScreen(const IncrementCounterFab());
      expect(
        find.l10n.byTooltip((l10n) => l10n.counterIncrementButtonTooltip),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    '''

GIVEN a increment counter fab
WHEN it is tapped
THEN the counter should be incremented
''',
    (tester) async {
      final counterNotifier = MockCounter(() => 5);
      final container = ProviderContainer(
        overrides: [counterPod.overrideWith(() => counterNotifier)],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(counterPod.notifier, (_, _) {});
      addTearDown(subscription.close);
      await tester.pumpAppWithScreen(
        UncontrolledProviderScope(
          container: container,
          child: const IncrementCounterFab(),
        ),
      );
      expect(container.read(counterPod), isNonZero);
      await tester.pumpAndSettle();
      final incrementButtonFinder = find.byType(IncrementCounterFab);
      await tester.tap(incrementButtonFinder);
      await tester.pumpAndSettle();
      verify(counterNotifier.increment).called(1);
    },
  );
}
