/*remove-start*/
import 'package:altoke_app/app/app.dart';
/*remove-end*/
import 'package:altoke_app/counter/counter.dart';
import 'package:altoke_app/routing/routing.dart';
/*x{{#use_auto_route}}*/
import 'package:auto_route/auto_route.dart';
/*x{{/use_auto_route}}*/
import 'package:flutter/material.dart';
/*{{#use_riverpod}}*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
/*{{/use_riverpod}}*/
import 'package:flutter_test/flutter_test.dart';
/*x{{#use_go_router}}*/
import 'package:go_router/go_router.dart';
/*x{{/use_go_router}}*/
import 'package:mocktail/mocktail.dart';
/*{{#use_riverpod}}*/
import 'package:riverpod_annotation/experimental/scope.dart';

/*{{/use_riverpod}}*/

import '../../helpers/helpers.dart';

@Dependencies([
  /*remove-start*/
  SelectedRouterPackage,
  SelectedStateManagementPackage,
  /*remove-end-x*/
  Counter,
])
void main() {
  setUpAll(registerFallbackValues);

  group('$CounterExampleListTile', () {
    /*{{#use_auto_route}}*/
    /*remove-start*/
    group('(using auto_route)', () {
      /*remove-end*/
      late StackRouter stackRouter;

      setUp(() {
        stackRouter = MockStackRouter();
      });

      @Dependencies([
        Counter,
        /*remove-start*/
        SelectedRouterPackage,
        SelectedStateManagementPackage,
        /*remove-end*/
      ])
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
            /*remove-start*/
            ProviderScope(
              overrides: [
                selectedRouterPackagePod.overrideWith(
                  () => FakeSelectedRouterPackage(
                    initialValue: RouterPackage.autoRoute,
                  ),
                ),
              ],
              child:
                  /*remove-end-x*/
                  buildAutoRouteSubjectWidget(),
              /*remove-start*/
            ),
            /*remove-end*/
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

      /*remove-start*/
    });
    /*remove-end*/
    /*{{/use_auto_route}}*/

    /*{{#use_go_router}}*/
    /*remove-start*/
    group('(using go_router)', () {
      /*remove-end*/
      late GoRouter goRouter;

      setUp(() {
        goRouter = MockGoRouter();
      });

      @Dependencies([
        Counter,
        /*remove-start*/
        SelectedRouterPackage,
        SelectedStateManagementPackage,
        /*remove-end*/
      ])
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
            /*remove-start*/
            ProviderScope(
              overrides: [
                selectedRouterPackagePod.overrideWith(
                  () => FakeSelectedRouterPackage(
                    initialValue: RouterPackage.goRouter,
                  ),
                ),
              ],
              child: /*remove-end-x*/ buildGoRouterSubjectWidget(),
              /*remove-start*/
            ),
            /*remove-end*/
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

      /*remove-start*/
    });
    /*remove-end*/
    /*{{/use_go_router}}*/
  });
}
