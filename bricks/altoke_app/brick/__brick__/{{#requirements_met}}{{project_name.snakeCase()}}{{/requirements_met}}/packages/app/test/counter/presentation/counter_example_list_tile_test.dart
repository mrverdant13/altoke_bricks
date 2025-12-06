
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/counter/counter.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/routing/routing.dart';{{#use_auto_route}}
import 'package:auto_route/auto_route.dart';{{/use_auto_route}}
import 'package:flutter/material.dart';
{{#use_riverpod}}
import 'package:flutter_riverpod/flutter_riverpod.dart';
{{/use_riverpod}}
import 'package:flutter_test/flutter_test.dart';{{#use_go_router}}
import 'package:go_router/go_router.dart';{{/use_go_router}}
import 'package:mocktail/mocktail.dart';
{{#use_riverpod}}
import 'package:riverpod_annotation/experimental/scope.dart';

{{/use_riverpod}}

import '../../helpers/helpers.dart';

{{#use_riverpod}}@Dependencies([
  Counter,
]){{/use_riverpod}}
void main() {
  setUpAll(registerFallbackValues);

  group('$CounterExampleListTile', () {
    {{#use_auto_route}}
    
      late StackRouter stackRouter;

      setUp(() {
        stackRouter = MockStackRouter();
      });

      {{#use_riverpod}}@Dependencies([
        Counter,
        
      ]){{/use_riverpod}}
      Widget buildAutoRouteSubjectWidget() {
        return StackRouterScope(
          controller: stackRouter,
          stateHash: 0,
          child: const CounterExampleListTile(),
        );
      }

      testWidgets(
        'displays the localized title',
        (tester) async {
          await tester.pumpAppWithScaffold(
            buildAutoRouteSubjectWidget(),
          );
          expect(
            find.l10n.widgetWithText(
              ListTile,
              (l10n) => l10n.counterExampleListTileTitle,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'navigates to the $CounterRoute',
        (tester) async {
          when(() => stackRouter.navigate(any())).thenAnswer((_) async {
            return null;
          });
          await tester.pumpAppWithScaffold(
            buildAutoRouteSubjectWidget(),
              
          );
          await tester.pumpAndSettle();
          await tester.tap(find.byType(CounterExampleListTile));
          verify(
            () => stackRouter.navigate(
              const CounterRoute(),
            ),
          ).called(1);
        },
      );

      
    {{/use_auto_route}}

    {{#use_go_router}}
    
      late GoRouter goRouter;

      setUp(() {
        goRouter = MockGoRouter();
      });

      {{#use_riverpod}}@Dependencies([
        Counter,
        
      ]){{/use_riverpod}}
      Widget buildGoRouterSubjectWidget() {
        return InheritedGoRouter(
          goRouter: goRouter,
          child: const CounterExampleListTile(),
        );
      }

      testWidgets(
        'displays the localized title',
        (tester) async {
          await tester.pumpAppWithScaffold(
            buildGoRouterSubjectWidget(),
          );
          expect(
            find.l10n.widgetWithText(
              ListTile,
              (l10n) => l10n.counterExampleListTileTitle,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'navigates to the $CounterRouteData',
        (tester) async {
          when(() => goRouter.go(any())).thenAnswer((_) async {});
          await tester.pumpAppWithScaffold(
            buildGoRouterSubjectWidget(),
              
          );
          await tester.pumpAndSettle();
          await tester.tap(find.byType(CounterExampleListTile));
          verify(
            () => goRouter.go(
              const CounterRouteData().location,
            ),
          ).called(1);
        },
      );

      
    {{/use_go_router}}
  });
}
