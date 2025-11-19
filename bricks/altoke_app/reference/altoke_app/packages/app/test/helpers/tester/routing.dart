/*{{#use_auto_route}}x*/
import 'package:auto_route/auto_route.dart';
/*x{{/use_auto_route}}*/
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
/*x{{#use_go_router}}x*/
import 'package:go_router/go_router.dart';
/*x{{/use_go_router}}*/

final Finder _routerFinder = find.bySubtype<Router<Object>>();

extension RoutedTester on WidgetTester {
  Router<Object> get routerWidget {
    return widget<Router<Object>>(_routerFinder);
  }

  /*{{#use_auto_route}}x*/
  AutoRouterDelegate get autoRouterDelegate {
    return routerWidget.routerDelegate as AutoRouterDelegate;
  }
  /*x{{/use_auto_route}}x*/

  /*x{{#use_go_router}}x*/
  GoRouterDelegate get goRouterDelegate {
    return routerWidget.routerDelegate as GoRouterDelegate;
  }
  /*x{{/use_go_router}}*/

  NavigatorState navigator({
    required Finder reference,
    bool useRootNavigator = false,
  }) {
    final referenceContext = element(reference);
    return Navigator.of(
      referenceContext,
      rootNavigator: useRootNavigator,
    );
  }

  Future<void> goBackNative() async {
    await routerWidget.backButtonDispatcher?.invokeCallback(Future.value(true));
  }
}
