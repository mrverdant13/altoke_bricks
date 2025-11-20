
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/counter/counter.dart';
{{#use_bloc}}
import 'package:bloc_test/bloc_test.dart';
{{/use_bloc}}
import 'package:flutter/widgets.dart';
{{#use_bloc}}
import 'package:flutter_bloc/{{#use_bloc}}flutter_bloc.dart{{/use_bloc}}';
{{/use_bloc}}
{{#use_riverpod}}
import 'package:flutter_riverpod/flutter_riverpod.dart';
{{/use_riverpod}}
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
{{#use_riverpod}}
import 'package:riverpod_annotation/experimental/scope.dart';

{{/use_riverpod}}

import '../../helpers/helpers.dart';

{{#use_riverpod}}
class _MockCounter extends CounterBase with Mock implements Counter {}
{{/use_riverpod}}

{{#use_bloc}}
class _MockCounterBloc extends MockBloc<CounterEvent, int>
    implements CounterBloc {}
{{/use_bloc}}

{{#use_riverpod}}@Dependencies([
  Counter,
  
]){{/use_riverpod}}
void main() {
  group('$IncrementCounterFab', () {
    {{#use_bloc}}
    

      late CounterBloc counterBloc;

      setUp(() {
        counterBloc = _MockCounterBloc();
      });

      
      Widget buildSubjectWidget() {
        return  BlocProvider.value(
            value: counterBloc,
            child: const IncrementCounterFab(),
          ) ;
      }

      testWidgets(
        'includes a localized tooltip',
        (tester) async {
          await tester.pumpAppWithScaffold(
            buildSubjectWidget(),
          );
          expect(
            find.l10n.byTooltip((l10n) => l10n.counterIncrementButtonTooltip),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'increments the counter',
        (tester) async {
          when(() => counterBloc.state).thenReturn(5);
          await tester.pumpAppWithScaffold(
            buildSubjectWidget(),
          );
          await tester.pumpAndSettle();
          final incrementButtonFinder = find.byType(IncrementCounterFab);
          await tester.tap(incrementButtonFinder);
          verify(
            () => counterBloc.add(const CounterIncreaseRequested()),
          ).called(1);
        },
      );
      
    {{/use_bloc}}

    {{#use_riverpod}}
    
      {{#use_riverpod}}@Dependencies([
        Counter,
      ]){{/use_riverpod}}
      Widget buildSubjectWidget() {
        return  const IncrementCounterFab() ;
      }

      testWidgets(
        'includes a localized tooltip',
        (tester) async {
          await tester.pumpAppWithScaffold(
            buildSubjectWidget(),
          );
          expect(
            find.l10n.byTooltip((l10n) => l10n.counterIncrementButtonTooltip),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'increments the counter',
        (tester) async {
          final counterNotifier = _MockCounter();
          when(counterNotifier.build).thenReturn(5);
          await tester.pumpAppWithScaffold(
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
          final incrementButtonFinder = find.byType(IncrementCounterFab);
          await tester.tap(incrementButtonFinder);
          verify(counterNotifier.increment).called(1);
        },
      );
      
    {{/use_riverpod}}
  });
}
