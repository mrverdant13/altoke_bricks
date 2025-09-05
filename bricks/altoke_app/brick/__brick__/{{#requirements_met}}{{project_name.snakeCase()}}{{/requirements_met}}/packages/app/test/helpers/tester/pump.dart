import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/l10n/l10n.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/routing/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

extension AppTester on WidgetTester {
  Future<void> pumpRoutedApp({List<Override> overrides = const []}) async {
    return pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: Consumer(
          builder: (context, ref, child) {
            final routerConfig = ref.watch(routerConfigPod);
            return MaterialApp.router(
              routerConfig: routerConfig,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
            );
          },
        ),
      ),
    );
  }

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
    await pumpAppWithScreen(Scaffold(body: body), overrides: overrides);
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
}
