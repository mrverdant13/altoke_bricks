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
/*{{#use_bloc}}*/
import 'package:mocktail/mocktail.dart';
/*{{/use_bloc}}*/
/*{{#use_riverpod}}*/
import 'package:riverpod_annotation/experimental/scope.dart';

/*{{/use_riverpod}}*/

import '../../helpers/helpers.dart';

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
  /*{{#use_bloc}}*/
  /*remove-start*/
  group('(using bloc)', () {
    /*remove-end*/
    group('$CounterBody', () {
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
          child:
              /*remove-end*/
              BlocProvider.value(
                value: counterBloc,
                child: const CounterBody(),
              ) /*remove-start*/,
        ) /*remove-end*/;
      }

      testWidgets(
        'displays a $PushCountMessage and a $PushCountValue',
        (tester) async {
          when(() => counterBloc.state).thenReturn(5);
          await tester.pumpAppWithScreen(
            buildSubjectWidget(),
          );
          expect(find.byType(PushCountMessage), findsOneWidget);
          expect(find.byType(PushCountValue), findsOneWidget);
        },
      );
    });

    group('$PushCountMessage', () {
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
            child: const PushCountMessage(),
          ) /*remove-start*/,
        ) /*remove-end*/;
      }

      testWidgets(
        'displays the localized message',
        (tester) async {
          when(() => counterBloc.state).thenReturn(5);
          await tester.pumpAppWithScreen(
            buildSubjectWidget(),
          );
          expect(
            find.l10n.text(
              (l10n) => l10n.counterPushTimesMessage(5),
            ),
            findsOneWidget,
          );
        },
      );
    });

    group('$PushCountValue', () {
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
            child: const PushCountValue(),
          ) /*remove-start*/,
        ) /*remove-end*/;
      }

      testWidgets(
        'displays the count value',
        (tester) async {
          when(() => counterBloc.state).thenReturn(5);
          await tester.pumpAppWithScreen(
            buildSubjectWidget(),
          );
          expect(find.text('5'), findsOneWidget);
        },
      );
    });
    /*remove-start*/
  });
  /*remove-end*/
  /*{{/use_bloc}}*/

  /*{{#use_riverpod}}*/
  /*remove-start*/
  group('(using riverpod)', () {
    /*remove-end*/
    group('$CounterBody', () {
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
          child:
              /*remove-end*/
              const CounterBody() /*remove-start*/,
        ) /*remove-end*/;
      }

      testWidgets(
        'displays a $PushCountMessage and a $PushCountValue',
        (tester) async {
          await tester.pumpAppWithScreen(
            buildSubjectWidget(),
          );
          expect(find.byType(PushCountMessage), findsOneWidget);
          expect(find.byType(PushCountValue), findsOneWidget);
        },
      );
    });

    group('$PushCountMessage', () {
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
          child: /*remove-end*/ const PushCountMessage() /*remove-start*/,
        ) /*remove-end*/;
      }

      testWidgets(
        'displays the localized message',
        (tester) async {
          await tester.pumpAppWithScreen(
            ProviderScope(
              overrides: [
                counterPod.overrideWithValue(5),
              ],
              child: buildSubjectWidget(),
            ),
          );
          expect(
            find.l10n.text(
              (l10n) => l10n.counterPushTimesMessage(5),
            ),
            findsOneWidget,
          );
        },
      );
    });

    group('$PushCountValue', () {
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
          child: /*remove-end*/ const PushCountValue() /*remove-start*/,
        ) /*remove-end*/;
      }

      testWidgets(
        'displays the count value',
        (tester) async {
          await tester.pumpAppWithScreen(
            ProviderScope(
              overrides: [
                counterPod.overrideWithValue(5),
              ],
              child: buildSubjectWidget(),
            ),
          );
          expect(find.text('5'), findsOneWidget);
        },
      );
    });
    /*remove-start*/
  });
  /*remove-end*/
  /*{{/use_riverpod}}*/
}
