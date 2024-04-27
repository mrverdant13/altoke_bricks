import 'package:altoke_app/routing/routing.dart';
/*{{#use_auto_route}}*/
import 'package:auto_route/auto_route.dart';
/*{{/use_auto_route}}*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
/*{{#use_go_router}}*/
import 'package:go_router/go_router.dart';
/*{{/use_go_router}}*/

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

/*w 1v w*/
/*{{#use_auto_route}}*/
  test(
    '''

GIVEN a router config pod
WHEN the pod is built
THEN the config is injected
''',
    () {
      final container = ProviderContainer(
        /*remove-start*/
        overrides: [
          routerPackagePod.overrideWithValue(
            RouterPackage.autoRoute,
          ),
        ],
        /*remove-end*/
      );
      addTearDown(container.dispose);
      final routerConfig = container.read(routerConfigPod);
      expect(routerConfig, isA<RouterConfig<UrlState>>());
    },
  );

  test(
    '''

GIVEN a router
WHEN the router is built
THEN the router uses an adaptive route type
''',
    () {
      final router = AppRouter();
      expect(router.defaultRouteType, isA<AdaptiveRouteType>());
    },
  );
/*{{/use_auto_route}}*/
/*{{#use_go_router}}*/
  test(
    '''

GIVEN a router config pod
WHEN the pod is built
THEN the config is injected
''',
    () {
      final container = ProviderContainer(
        /*remove-start*/
        overrides: [
          routerPackagePod.overrideWithValue(
            RouterPackage.goRouter,
          ),
        ],
        /*remove-end*/
      );
      addTearDown(container.dispose);
      final routerConfig = container.read(routerConfigPod);
      expect(routerConfig, isA<GoRouter>());
    },
  );
/*{{/use_go_router}}*/
/*w 1v w*/
}
