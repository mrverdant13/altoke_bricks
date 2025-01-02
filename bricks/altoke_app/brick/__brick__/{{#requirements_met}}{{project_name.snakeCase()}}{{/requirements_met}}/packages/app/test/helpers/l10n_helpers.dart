import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/l10n/l10n.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';

import 'helpers.dart';

typedef LocalizedTextSelector = String Function(AppLocalizations l10n);
typedef LocalizedTextCase = (Locale, LocalizedTextSelector, String);
typedef LocalizedTextPartialCase = (Locale, String);

class LocalizationVariant extends ValueVariant<LocalizedTextCase> {
  LocalizationVariant(super.values);

  LocalizationVariant.withCommonSelector({
    required LocalizedTextSelector localizedTextSelector,
    required Set<LocalizedTextPartialCase> partialCases,
  }) : this({
          for (final partialCase in partialCases)
            (
              partialCase.$1,
              localizedTextSelector,
              partialCase.$2,
            ),
        });

  @override
  String describeValue(LocalizedTextCase value) {
    return '${value.$1}';
  }
}

@isTest
void testExhaustiveLocalizationVariant(
  String description,
  LocalizationVariant variant,
) {
  test(
    description,
    () async {
      const supportedLocales = AppLocalizations.supportedLocales;
      final locales = variant.values.map((e) => e.$1);
      expect(
        locales,
        containsAll(supportedLocales),
        reason: 'All supported locales should be tested',
      );
    },
  );
}

@isTest
void testLocalizedWidget(
  String description,
  Widget widget, {
  required Finder ancestorFinder,
  required LocalizationVariant variant,
  WidgetTesterCallback? postPumpAction,
}) {
  testWidgets(
    description,
    (tester) async {
      final l10nCase = variant.currentValue!;
      final (
        locale,
        localizedTextSelector,
        literalText,
      ) = l10nCase;
      await tester.pumpAppWithScreen(
        Builder(
          builder: (context) => Localizations.override(
            context: context,
            locale: locale,
            child: widget,
          ),
        ),
      );
      await postPumpAction?.call(tester);
      final widgetFinder = find.byWidget(widget);
      final context = tester.element(widgetFinder);
      final localizedTextFinder = find.descendant(
        of: ancestorFinder,
        matching: find.text(
          localizedTextSelector(context.l10n),
          findRichText: true,
        ),
        matchRoot: true,
      );
      final literalTextFinder = find.descendant(
        of: ancestorFinder,
        matching: find.text(
          literalText,
          findRichText: true,
        ),
        matchRoot: true,
      );
      expect(
        localizedTextFinder,
        findsOneWidget,
        reason: 'The injected localized text should be found',
      );
      expect(
        literalTextFinder,
        findsOneWidget,
        reason: 'The literal localized text should be found',
      );
      final localizedWidget = tester.widget(localizedTextFinder);
      final literalWidget = tester.widget(literalTextFinder);
      expect(
        localizedWidget,
        literalWidget,
        reason: 'The localized text should be the same as the literal text',
      );
    },
    variant: variant,
  );
}
