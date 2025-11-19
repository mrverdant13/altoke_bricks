{{#use_auto_route}}import 'package:auto_route/auto_route.dart';{{/use_auto_route}}
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';{{#use_go_router}}import 'package:go_router/go_router.dart';{{/use_go_router}}

final Finder _routerFinder = find.bySubtype<Router<Object>>();

extension RoutedTester on WidgetTester {
  Router<Object> get routerWidget {
    return widget<Router<Object>>(_routerFinder);
  }

  {{#use_auto_route}}AutoRouterDelegate get autoRouterDelegate {
    return routerWidget.routerDelegate as AutoRouterDelegate;
  }{{/use_auto_route}}{{#use_go_router}}GoRouterDelegate get goRouterDelegate {
    return routerWidget.routerDelegate as GoRouterDelegate;
  }{{/use_go_router}}

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
