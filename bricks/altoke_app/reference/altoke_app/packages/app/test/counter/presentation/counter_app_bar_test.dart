/*remove-start*/
import 'package:altoke_app/app/app.dart';
/*remove-end*/
import 'package:altoke_app/counter/counter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
/*{{#use_riverpod}}*/
import 'package:riverpod_annotation/experimental/scope.dart';

/*{{/use_riverpod}}*/

import '../../helpers/helpers.dart';

@Dependencies([
  Counter,
  /*remove-start*/
  SelectedStateManagementPackage,
  /*remove-end*/
])
void main() {
  group('$CounterAppBar', () {
    @Dependencies([
      Counter,
      /*remove-start*/
      SelectedStateManagementPackage,
      /*remove-end*/
    ])
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
