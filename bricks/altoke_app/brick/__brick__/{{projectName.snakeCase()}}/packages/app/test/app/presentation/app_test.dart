import 'package:{{projectName.snakeCase()}}/app/app.dart';
import 'package:{{projectName.snakeCase()}}/routing/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
{{#use_auto_route}}testWidgets(
    '''

GIVEN an app
WHEN the app is built
AND the initialization process is completed
THEN the initialized app should be shown
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
      expect(find.byType(AppInitializing), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byType(InitializedApp), findsOneWidget);
    },
  );

  testWidgets(
    '''

GIVEN an app
WHEN the app is built
AND the initialization process fails
THEN the uninitialized errored app should be shown
├─ THAT allows the user to retry the initialization process
''',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            asyncInitializationPod.overrideWith(
              (ref) async {
                final asyncValue = ref.state;
                if (!asyncValue.isRefreshing) {
                  throw Exception('error');
                }
              },
            ),
          ],
          child: const MyApp(),
        ),
      );
      expect(find.byType(AppInitializing), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byType(AppWithErroredInitialization), findsOneWidget);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(find.byType(AppInitializing), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byType(InitializedApp), findsOneWidget);
    },
  );

  testWidgets(
    '''

GIVEN an app
AND an app router
WHEN the app is built
THEN the counter screen should be shown
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
  );{{/use_auto_route}}{{#use_go_router}}testWidgets(
    '''

GIVEN an app
WHEN the app is built
AND the initialization process is completed
THEN the initialized app should be shown
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
      expect(find.byType(AppInitializing), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byType(InitializedApp), findsOneWidget);
    },
  );

  testWidgets(
    '''

GIVEN an app
WHEN the app is built
AND the initialization process fails
THEN the uninitialized errored app should be shown
├─ THAT allows the user to retry the initialization process
''',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            asyncInitializationPod.overrideWith(
              (ref) async {
                final asyncValue = ref.state;
                if (!asyncValue.isRefreshing) {
                  throw Exception('error');
                }
              },
            ),
          ],
          child: const MyApp(),
        ),
      );
      expect(find.byType(AppInitializing), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byType(AppWithErroredInitialization), findsOneWidget);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(find.byType(AppInitializing), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byType(InitializedApp), findsOneWidget);
    },
  );

  testWidgets(
    '''

GIVEN an app
AND an app router
WHEN the app is built
THEN the counter screen should be shown
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
  );{{/use_go_router}}
}
