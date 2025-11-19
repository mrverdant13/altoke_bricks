import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/l10n/l10n.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/routing/routing.dart';{{#use_auto_route}}import 'package:auto_route/auto_route.dart';{{/use_auto_route}}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';{{#use_go_router}}import 'package:go_router/go_router.dart';{{/use_go_router}}
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

{{#use_auto_route}}typedef AutoRouteOverrides = Map<String, AutoRoutePageBuilder>;

extension on Iterable<AutoRoute> {
  Iterable<AutoRoute> overrideRoutes(
    AutoRouteOverrides overrides,
  ) sync* {
    final routes = this;
    for (final route in routes) {
      final page = switch (overrides[route.name]) {
        null => route.page,
        final builder => PageInfo(
          route.name,
          builder: builder,
        ),
      };
      final children = route.children?.overrideRoutes(overrides);
      yield route.copyWith(
        page: page,
        children: children?.toList(),
      );
    }
  }
}

class TestableAppRouter extends AppRouter {
  TestableAppRouter({
    this.overrides = const {},
  });

  final AutoRouteOverrides overrides;

  @override
  List<AutoRoute> get routes => super.routes.overrideRoutes(overrides).toList();
}{{/use_auto_route}}@Dependencies([])
extension AppTester on WidgetTester {
  {{#use_auto_route}}Future<void> pumpAutoRouteAppWithInitialPath(
    String path, {
    AutoRouteOverrides routeOverrides = const {},
    Widget Function(Widget child)? wrapper,
  }) async {
    final appRouter = TestableAppRouter(overrides: routeOverrides);
    addTearDown(appRouter.dispose);
    final routerConfig = appRouter.config(
      deepLinkBuilder: (deepLink) {
        if (deepLink.initial) return DeepLink.path(path);
        return deepLink;
      },
    );
    final effectiveWrapper = wrapper ?? (child) => child;
    await pumpWidget(
      ProviderScope(
        child: effectiveWrapper(
          MaterialApp.router(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: routerConfig,
          ),
        ),
      ),
    );
  }

  Future<void> pumpAutoRouteAppWithInitialRoute(
    PageRouteInfo<dynamic> pageRoute, {
    AutoRouteOverrides overrides = const {},
    Widget Function(Widget child)? wrapper,
  }) async {
    final appRouter = TestableAppRouter(overrides: overrides);
    addTearDown(appRouter.dispose);
    final routerConfig = appRouter.config(
      deepLinkBuilder: (deepLink) {
        if (deepLink.initial) return DeepLink.single(pageRoute);
        return deepLink;
      },
    );
    final effectiveWrapper = wrapper ?? (child) => child;
    await pumpWidget(
      ProviderScope(
        child: effectiveWrapper(
          MaterialApp.router(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: routerConfig,
          ),
        ),
      ),
    );
  }

  Future<void> pumpAutoRouteAppWithInitialRoutes(
    List<PageRouteInfo<dynamic>> pageRoutes, {
    AutoRouteOverrides overrides = const {},
    Widget Function(Widget child)? wrapper,
  }) async {
    final appRouter = TestableAppRouter(overrides: overrides);
    addTearDown(appRouter.dispose);
    final routerConfig = appRouter.config(
      deepLinkBuilder: (deepLink) {
        if (deepLink.initial) return DeepLink(pageRoutes);
        return deepLink;
      },
    );
    final effectiveWrapper = wrapper ?? (child) => child;
    await pumpWidget(
      ProviderScope(
        child: effectiveWrapper(
          MaterialApp.router(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: routerConfig,
          ),
        ),
      ),
    );
  }{{/use_auto_route}}{{#use_go_router}}Future<void> pumpGoRouterAppWithInitialPath(
    String path, {
    Widget Function(Widget child)? wrapper,
  }) async {
    final goRouter = GoRouter(
      routes: $appRoutes,
      initialLocation: path,
    );
    addTearDown(goRouter.dispose);
    final effectiveWrapper = wrapper ?? (child) => child;
    await pumpWidget(
      ProviderScope(
        child: effectiveWrapper(
          MaterialApp.router(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: goRouter,
          ),
        ),
      ),
    );
  }

  Future<void> pumpGoRouterAppWithInitialRoute(
    GoRouteData route, {
    Widget Function(Widget child)? wrapper,
  }) async {
    final goRouter = GoRouter(
      routes: $appRoutes,
      initialLocation: route.location,
    );
    addTearDown(goRouter.dispose);
    final effectiveWrapper = wrapper ?? (child) => child;
    await pumpWidget(
      ProviderScope(
        child: effectiveWrapper(
          MaterialApp.router(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: goRouter,
          ),
        ),
      ),
    );
  }{{/use_go_router}}

  Future<void> pumpAppWithScreen(
    Widget screen, {
    List<Override> overrides = const [],
  }) async {
    await pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: screen,
        ),
      ),
    );
  }

  Future<void> pumpAppWithScaffold(
    Widget body, {
    List<Override> overrides = const [],
  }) async {
    await pumpAppWithScreen(
      Scaffold(body: body),
      overrides: overrides,
    );
  }

  Future<void> pumpAppWithSlivers(
    List<Widget> slivers, {
    ScrollPhysics? physics,
    ScrollController? scrollController,
    List<Override> overrides = const [],
  }) async {
    await pumpAppWithScaffold(
      CustomScrollView(
        physics: physics,
        controller: scrollController,
        slivers: slivers,
      ),
      overrides: overrides,
    );
  }

  Future<void> pumpAppWithNestedScrollViewBody(
    Widget body, {
    double fakeHeaderHeight = 0,
    ScrollPhysics? physics,
    ScrollController? scrollController,
    List<Override> overrides = const [],
  }) async {
    await pumpAppWithScaffold(
      NestedScrollView(
        physics: physics,
        controller: scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverToBoxAdapter(
              child: SizedBox(height: fakeHeaderHeight),
            ),
          ),
        ],
        body: body,
      ),
      overrides: overrides,
    );
  }

  /// Repeatedly pumps the widget tree until the widget matching [finder] is
  /// found.
  ///
  /// Throws a [TestFailure] if the widget is not found after [maxIteration]
  Future<void> pumpUntilFound(
    Finder finder, {
    int maxIteration = 50,
  }) async {
    var iteration = maxIteration;
    await TestAsyncUtils.guard(() async {
      while (iteration > 0 && finder.evaluate().isEmpty) {
        await pump();
        iteration -= 1;
      }
      final found = finder.tryEvaluate();
      if (found) return;
      fail('$finder after $maxIteration pumps');
    });
  }
}
