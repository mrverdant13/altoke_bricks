import 'package:{{project_name.snakeCase()}}/l10n/l10n.dart';
import 'package:{{project_name.snakeCase()}}/routing/routing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension AppTester on WidgetTester {
  Future<void> pumpRouteAppWithInitialRoute(
    String initialPath,
  ) async {
    final router = AppRouter();
    await pumpWidget(
      MaterialApp.router(
        theme: ThemeData.light(
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(
          useMaterial3: true,
        ),
        onGenerateTitle: (BuildContext context) => context.l10n.appTitle,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router.config(
          deepLinkBuilder: (deepLink) => DeepLink.path(initialPath),
        ),
      ),
    );
    await pumpAndSettle();
  }

  Future<void> pumpRoutedAppWithTestableWidget({
    required Widget testableWidget,
    required RoutingController routingController,
  }) async {
    await pumpWidget(
      MaterialApp(
        theme: ThemeData.light(
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(
          useMaterial3: true,
        ),
        onGenerateTitle: (BuildContext context) => context.l10n.appTitle,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: RouterScope(
          controller: routingController,
          inheritableObserversBuilder: () => [],
          child: testableWidget,
          stateHash: 0,
        ),
      ),
    );
  }

  Future<void> pumpSimpleAppWithTestableWidget({
    required Widget testableWidget,
  }) async {
    await pumpWidget(
      MaterialApp(
        theme: ThemeData.light(
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(
          useMaterial3: true,
        ),
        onGenerateTitle: (BuildContext context) => context.l10n.appTitle,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: testableWidget,
      ),
    );
  }
}
