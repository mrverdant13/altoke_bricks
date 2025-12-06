
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
{{#use_bloc}}
import 'package:mocktail/mocktail.dart';
{{/use_bloc}}
{{#use_riverpod}}
import 'package:riverpod_annotation/experimental/scope.dart';

{{/use_riverpod}}

import '../../helpers/helpers.dart';

{{#use_bloc}}
class _MockCounterBloc extends MockBloc<CounterEvent, int>
    implements CounterBloc {}
{{/use_bloc}}

{{#use_riverpod}}@Dependencies([
  Counter,
  
]){{/use_riverpod}}
void main() {
  {{#use_bloc}}
  
    group('$CounterBody', () {
      late CounterBloc counterBloc;

      setUp(() {
        counterBloc = _MockCounterBloc();
      });

      
      Widget buildSubjectWidget() {
        return 
              BlocProvider.value(
                value: counterBloc,
                child: const CounterBody(),
              ) ;
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

      
      Widget buildSubjectWidget() {
        return  BlocProvider.value(
            value: counterBloc,
            child: const PushCountMessage(),
          ) ;
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

      
      Widget buildSubjectWidget() {
        return  BlocProvider.value(
            value: counterBloc,
            child: const PushCountValue(),
          ) ;
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
    
  {{/use_bloc}}

  {{#use_riverpod}}
  
    group('$CounterBody', () {
      {{#use_riverpod}}@Dependencies([
        Counter,
      ]){{/use_riverpod}}
      Widget buildSubjectWidget() {
        return 
              const CounterBody() ;
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
      {{#use_riverpod}}@Dependencies([
        Counter,
      ]){{/use_riverpod}}
      Widget buildSubjectWidget() {
        return  const PushCountMessage() ;
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
      {{#use_riverpod}}@Dependencies([
        Counter,
      ]){{/use_riverpod}}
      Widget buildSubjectWidget() {
        return  const PushCountValue() ;
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
    
  {{/use_riverpod}}
}
