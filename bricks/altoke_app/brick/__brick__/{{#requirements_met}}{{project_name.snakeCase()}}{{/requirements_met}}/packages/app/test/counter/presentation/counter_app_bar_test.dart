
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/counter/counter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
{{#use_riverpod}}
import 'package:riverpod_annotation/experimental/scope.dart';

{{/use_riverpod}}

import '../../helpers/helpers.dart';

{{#use_riverpod}}@Dependencies([
  Counter,
  
]){{/use_riverpod}}
void main() {
  group('$CounterAppBar', () {
    {{#use_riverpod}}@Dependencies([
      Counter,
      
    ]){{/use_riverpod}}
    Widget buildSubjectWidget() {
      return CounterAppBar();
    }

    testWidgets(
      'displays the localized title',
      (tester) async {
        await tester.pumpAppWithScreen(
          buildSubjectWidget(),
        );
        expect(
          find.l10n.text((l10n) => l10n.counterAppBarTitle),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'includes a title and reset counter icon button',
      (tester) async {
        await tester.pumpAppWithScreen(
          buildSubjectWidget(),
        );
        expect(find.byType(CounterAppBarTitle), findsOneWidget);
        expect(find.byType(ResetCounterIconButton), findsOneWidget);
      },
    );
  });
}
