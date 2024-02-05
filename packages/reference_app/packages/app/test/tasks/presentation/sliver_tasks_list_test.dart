import 'dart:async';

import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tasks/tasks.dart';

import '../../helpers/helpers.dart';

void main() {
  group(
    '''
GIVEN a sliver tasks list''',
    () {
      Widget buildTestableWidget({
        required ProviderContainer container,
      }) {
        return Scaffold(
          body: UncontrolledProviderScope(
            container: container,
            child: const CustomScrollView(
              slivers: [
                SliverTasksList(),
              ],
            ),
          ),
        );
      }

      testWidgets(
        '''

AND no tasks
WHEN the widget is displayed
THEN an empty tasks message is displayed
''',
        (tester) async {
          final container = ProviderContainer(
            overrides: [
              asyncFilteredTasksCountPod.overrideWith(
                (ref) => Stream.value(0).asBroadcastStream(),
              ),
            ],
          );
          addTearDown(container.dispose);
          final testableWidget = buildTestableWidget(container: container);
          await tester.pumpTestableWidget(testableWidget);
          final count = await container.read(asyncFilteredTasksCountPod.future);
          expect(count, isZero);
          await tester.pumpAndSettle();
          expect(
            find.byType(SliverFillRemainingNoTasksMessage),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        '''

AND at least one task
WHEN the widget is displayed
THEN a non-empty tasks list is displayed
''',
        (tester) async {
          final container = ProviderContainer(
            overrides: [
              asyncFilteredTasksCountPod.overrideWith(
                (ref) => Stream.value(8).asBroadcastStream(),
              ),
            ],
          );
          addTearDown(container.dispose);
          final testableWidget = buildTestableWidget(container: container);
          await tester.pumpTestableWidget(testableWidget);
          final count = await container.read(asyncFilteredTasksCountPod.future);
          expect(count, isPositive);
          await tester.pumpAndSettle();
          expect(find.byType(SliverNonEmptyTasksList), findsOneWidget);
        },
      );

      testWidgets(
        '''

AND an error when trying to count tasks
WHEN the widget is displayed
THEN an error message should be displayed
''',
        (tester) async {
          final container = ProviderContainer(
            overrides: [
              asyncFilteredTasksCountPod.overrideWith(
                (ref) =>
                    Stream<int>.error(Exception('oops')).asBroadcastStream(),
              ),
            ],
          );
          addTearDown(container.dispose);
          final testableWidget = buildTestableWidget(container: container);
          await tester.pumpTestableWidget(testableWidget);
          await expectLater(
            container.read(asyncFilteredTasksCountPod.future),
            throwsA(isA<Exception>()),
          );
          await tester.pumpAndSettle();
          expect(
            find.byType(SliverFillRemainingWithErrorOnTasksLoad),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        '''

AND an unfinished tasks counting process
WHEN the widget is displayed
THEN a loading indicator should be displayed
''',
        (tester) async {
          final container = ProviderContainer(
            overrides: [
              asyncFilteredTasksCountPod.overrideWith(
                (ref) => const Stream<int>.empty().asBroadcastStream(),
              ),
            ],
          );
          addTearDown(container.dispose);
          final testableWidget = buildTestableWidget(container: container);
          await tester.pumpTestableWidget(testableWidget);
          expect(find.byType(SliverSkeletonTasksList), findsOneWidget);
        },
      );
    },
  );

  testWidgets(
    '''

GIVEN a sliver skeleton tasks list
WHEN it is displayed
THEN a set of skeleton task tiles should be displayed
''',
    (tester) async {
      await tester.pumpTestableWidget(
        const Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverSkeletonTasksList(),
            ],
          ),
        ),
      );

      expect(find.byType(SkeletonTaskTile), findsWidgets);
    },
  );

  group(
    '''

GIVEN a localization variant for the error message of the task error item''',
    () {
      final localizationVariant = LocalizationVariant.withCommonSelector(
        localizedTextSelector: (l10n) =>
            l10n.tasksUnexpectedTasksLoadErrorMessage,
        partialCases: {
          const (
            Locale('en'),
            'Uh oh! Something went wrong while loading the tasks.'
          ),
          const (
            Locale('es'),
            // cspell:disable-next-line
            'Oh no! Algo salió mal al cargar las tareas',
          ),
        },
      );

      testExhaustiveLocalizationVariant(
        '''

WHEN testing the task error item
THEN all supported locales should be considered
''',
        localizationVariant,
      );

      testLocalizedWidget(
        '''

AND a task error item
WHEN it is displayed
THEN the item should include the localized error message
''',
        const TaskErrorItem(),
        ancestorFinder: find.byKey(
          const Key('<tasks:task-error-item:message>'),
        ),
        variant: localizationVariant,
      );
    },
  );

  group(
    '''

GIVEN a localization variant for the label of the retry button''',
    () {
      final localizationVariant = LocalizationVariant.withCommonSelector(
        localizedTextSelector: (l10n) => l10n.genericRetryButtonLabel,
        partialCases: {
          const (
            Locale('en'),
            'Retry',
          ),
          const (
            Locale('es'),
            // cspell:disable-next-line
            'Reintentar',
          ),
        },
      );

      testExhaustiveLocalizationVariant(
        '''

WHEN testing the task error item
THEN all supported locales should be considered
''',
        localizationVariant,
      );

      testLocalizedWidget(
        '''

AND a task error item
├─ THAT has a retry callback
WHEN it is displayed
THEN the item should include the localized retry button label
''',
        TaskErrorItem(
          onRetry: () {},
        ),
        ancestorFinder: find.byKey(
          const Key('<tasks:task-error-item:retry-button>'),
        ),
        variant: localizationVariant,
      );
    },
  );

  testWidgets(
    '''

GIVEN a task error item
├─ THAT has a retry callback
WHEN the retry button is tapped
THEN the callback should be invoked
''',
    (tester) async {
      var invoked = false;
      void onRetry() => invoked = true;
      await tester.pumpTestableWidget(
        TaskErrorItem(
          onRetry: onRetry,
        ),
      );
      expect(invoked, isFalse);
      await tester.tap(find.byType(ElevatedButton));
      expect(invoked, isTrue);
    },
  );

  group(
    '''

GIVEN a sliver non-empty tasks list
AND an injected tasks count''',
    () {
      Widget buildTestableWidget({
        required int tasksCount,
        required ValueGetter<Stream<List<Task>>>
            paginatedFilteredTasksStreamConstructor,
      }) {
        return Scaffold(
          body: ProviderScope(
            overrides: [
              asyncFilteredTasksCountPod.overrideWith(
                (ref) => Stream.value(tasksCount).asBroadcastStream(),
              ),
              asyncPaginatedFilteredTasksPod(
                offset: 0,
                limit: 15,
              ).overrideWith(
                (_) => paginatedFilteredTasksStreamConstructor(),
              ),
            ],
            child: const Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverNonEmptyTasksList(),
                ],
              ),
            ),
          ),
        );
      }

      testWidgets(
        '''

AND an injected tasks collection
├─ THAT has its size equal to the injected tasks count
WHEN the widget is displayed
THEN a list of task tiles should be displayed
''',
        (tester) async {
          const tasksCount = 5;
          final testableWidget = buildTestableWidget(
            tasksCount: tasksCount,
            paginatedFilteredTasksStreamConstructor: () => Stream.value(
              List.generate(
                tasksCount,
                (index) => Task(
                  id: index,
                  title: 'Task $index',
                  isCompleted: index.isEven,
                  createdAt: DateTime(2000).add(Duration(days: index)),
                ),
              ),
            ).asBroadcastStream(),
          );
          await tester.pumpTestableWidget(testableWidget);
          await tester.pumpAndSettle();
          expect(
            find.descendant(
              of: find.byType(SliverList),
              matching: find.byType(TaskTile),
            ),
            findsNWidgets(tasksCount),
          );
        },
      );

      testWidgets(
        '''

AND an injected tasks collection
├─ THAT has a size smaller than the injected tasks count
WHEN the widget is displayed
THEN a list of task tiles should be displayed
├─ THAT has a size equal to the actually available tasks (the injected tasks collection length)
├─ AND has has dummy placeholders for the remaining items
''',
        (tester) async {
          const tasksCount = 5;
          const actualTasksCount = 3;
          final testableWidget = buildTestableWidget(
            tasksCount: tasksCount,
            paginatedFilteredTasksStreamConstructor: () => Stream.value(
              List.generate(
                actualTasksCount,
                (index) => Task(
                  id: index,
                  title: 'Task $index',
                  isCompleted: index.isEven,
                  createdAt: DateTime(2000).add(Duration(days: index)),
                ),
              ),
            ).asBroadcastStream(),
          );
          await tester.pumpTestableWidget(testableWidget);
          await tester.pumpAndSettle();
          expect(
            find.descendant(
              of: find.byType(SliverList),
              matching: find.byType(TaskTile),
            ),
            findsNWidgets(actualTasksCount),
          );
          expect(
            find.descendant(
              of: find.byType(SliverList),
              matching: find.byWidgetPredicate(
                (widget) =>
                    widget is SizedBox &&
                    widget.height == 0 &&
                    widget.width == 0,
              ),
            ),
            findsNWidgets(tasksCount - actualTasksCount),
          );
        },
      );

      testWidgets(
        '''

AND an failing injected tasks collection
WHEN the widget is displayed
THEN the error item should be displayed
WHEN the retry button is tapped
THEN the injected tasks collection should be re-fetched
''',
        (tester) async {
          var podBuilds = 0;
          final testableWidget = buildTestableWidget(
            tasksCount: 5,
            paginatedFilteredTasksStreamConstructor: () =>
                Stream<List<Task>>.error(Exception('oops'))
                    .asBroadcastStream(onListen: (_) => podBuilds++),
          );
          await tester.pumpTestableWidget(testableWidget);
          await tester.pumpAndSettle();
          expect(
            find.descendant(
              of: find.byType(SliverList),
              matching: find.byType(TaskErrorItem),
            ),
            findsOneWidget,
          );
          expect(podBuilds, 1);
          await tester.tap(
            find.descendant(
              of: find.byType(TaskErrorItem),
              matching: find.byType(ElevatedButton),
            ),
          );
          await tester.pump();
          expect(podBuilds, 2);
        },
      );

      testWidgets(
        '''

AND an loading injected tasks collection
WHEN the widget is displayed
THEN the skeleton tasks list should be displayed
''',
        (tester) async {
          final testableWidget = buildTestableWidget(
            tasksCount: 5,
            paginatedFilteredTasksStreamConstructor: () =>
                const Stream<List<Task>>.empty().asBroadcastStream(),
          );
          await tester.pumpTestableWidget(testableWidget);
          expect(
            find.descendant(
              of: find.byType(SliverList),
              matching: find.byType(SkeletonTaskTile),
            ),
            findsWidgets,
          );
        },
      );
    },
  );
}
