import 'package:{{projectName.snakeCase()}}/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension AppTester on WidgetTester {
  Future<void> pumpTestableWidget(
    Widget testableWidget,
  ) async {
    await pumpWidget(
      MaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        onGenerateTitle: (BuildContext context) => context.l10n.appTitle,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: testableWidget,
      ),
    );
  }
}
