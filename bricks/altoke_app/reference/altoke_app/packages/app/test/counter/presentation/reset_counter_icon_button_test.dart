/*remove-start*/
import 'package:altoke_app/app/app.dart';
/*remove-end*/
import 'package:altoke_app/counter/counter.dart';
/*{{#use_bloc}}*/
import 'package:bloc_test/bloc_test.dart';
/*{{/use_bloc}}*/
import 'package:flutter/widgets.dart';
/*{{#use_bloc}}*/
import 'package:flutter_bloc/flutter_bloc.dart';
/*{{/use_bloc}}*/
/*{{#use_riverpod}}*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
/*{{/use_riverpod}}*/
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
/*{{#use_riverpod}}*/
import 'package:riverpod_annotation/experimental/scope.dart';

/*{{/use_riverpod}}*/

import '../../helpers/helpers.dart';

/*{{#use_riverpod}}*/
class _MockCounter extends CounterBase with Mock implements Counter {}
/*{{/use_riverpod}}*/

/*{{#use_bloc}}*/
class _MockCounterBloc extends MockBloc<CounterEvent, int>
    implements CounterBloc {}
/*{{/use_bloc}}*/

@Dependencies([
  Counter,
  /*remove-start*/
  SelectedStateManagementPackage,
  /*remove-end*/
])
void main() {
  group('$ResetCounterIconButton', () {
    /*{{#use_bloc}}*/
    /*remove-start*/
    group('(using bloc)', () {
      /*remove-end*/
      late CounterBloc counterBloc;

      setUp(() {
        counterBloc = _MockCounterBloc();
      });

      /*remove-start*/
      @Dependencies([
        Counter,
      ])
      /*remove-end*/
      Widget buildSubjectWidget() {
        return /*remove-start*/ ProviderScope(
          overrides: [
            selectedStateManagementPackagePod.overrideWithValue(
              StateManagementPackage.bloc,
            ),
          ],
          child: /*remove-end*/ BlocProvider.value(
            value: counterBloc,
            child: const ResetCounterIconButton(),
          ) /*remove-start*/,
        ) /*remove-end*/;
      }

      testWidgets(
        'includes a localized tooltip',
        (tester) async {
          await tester.pumpAppWithScreen(
            buildSubjectWidget(),
          );
          expect(
            find.l10n.byTooltip((l10n) => l10n.counterResetButtonTooltip),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'resets the counter',
        (tester) async {
          when(() => counterBloc.state).thenReturn(5);
          await tester.pumpAppWithScreen(
            buildSubjectWidget(),
          );
          await tester.pumpAndSettle();
          final resetButtonFinder = find.byType(ResetCounterIconButton);
          await tester.tap(resetButtonFinder);
          verify(
            () => counterBloc.add(const CounterResetRequested()),
          ).called(1);
        },
      );
      /*remove-start*/
    });
    /*remove-end*/
    /*{{/use_bloc}}*/

    /*{{#use_riverpod}}*/
    /*remove-start*/
    group('(using riverpod)', () {
      /*remove-end*/

      @Dependencies([
        Counter,
      ])
      Widget buildSubjectWidget() {
        return /*remove-start*/ ProviderScope(
          overrides: [
            selectedStateManagementPackagePod.overrideWithValue(
              StateManagementPackage.riverpod,
            ),
          ],
          child: /*remove-end*/ const ResetCounterIconButton() /*remove-start*/,
        ) /*remove-end*/;
      }

      testWidgets(
        'includes a localized tooltip',
        (tester) async {
          await tester.pumpAppWithScreen(
            buildSubjectWidget(),
          );
          expect(
            find.l10n.byTooltip((l10n) => l10n.counterResetButtonTooltip),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'resets the counter',
        (tester) async {
          final counterNotifier = _MockCounter();
          when(counterNotifier.build).thenReturn(5);
          await tester.pumpAppWithScreen(
            ProviderScope(
              overrides: [
                counterPod.overrideWith(
                  () => counterNotifier,
                ),
              ],
              child: buildSubjectWidget(),
            ),
          );
          await tester.pumpAndSettle();
          final resetButtonFinder = find.byType(ResetCounterIconButton);
          await tester.tap(resetButtonFinder);
          verify(counterNotifier.reset).called(1);
        },
      );
      /*remove-start*/
    });
    /*remove-end*/
    /*{{/use_riverpod}}*/
  });
}
