import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/l10n/l10n.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

extension LocalizedTester on WidgetTester {
  AppLocalizations get l10n => AppLocalizations.of(
        element(
          find.descendant(
            of: find.byType(Localizations),
            matching: find.bySubtype(),
          ),
        ),
      );

  AppLocalizations scopedL10n<T extends Widget>() => AppLocalizations.of(
        element(
          find.byType(T),
        ),
      );
}
