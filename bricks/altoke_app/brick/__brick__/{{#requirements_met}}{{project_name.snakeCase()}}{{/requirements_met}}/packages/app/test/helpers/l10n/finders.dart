import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/l10n/l10n.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

typedef L10nSelector = String Function(AppLocalizations l10n);

class _LocalizedTextFinder extends MatchFinder {
  _LocalizedTextFinder(
    this.selector, {
    required this.findRichText,
    required super.skipOffstage,
    String? description,
  }) : _description = description;

  final L10nSelector selector;
  final bool findRichText;

  final String? _description;

  @override
  String get description => _description ?? 'localized text ${#selector}';

  @override
  bool matches(Element candidate) {
    final l10n = Localizations.of<AppLocalizations>(
      candidate,
      AppLocalizations,
    );
    if (l10n == null) return false;
    final text = selector(l10n);
    final textFinder = find.text(
      text,
      findRichText: findRichText,
      skipOffstage: skipOffstage,
    );
    return textFinder.findInCandidates([candidate]).isNotEmpty;
  }
}

class _LocalizedTooltipFinder extends MatchFinder {
  _LocalizedTooltipFinder(
    this.selector, {
    required super.skipOffstage,
    String? description,
  }) : _description = description;

  final L10nSelector selector;

  final String? _description;

  @override
  String get description => _description ?? 'localized text ${#selector}';

  @override
  bool matches(Element candidate) {
    final l10n = Localizations.of<AppLocalizations>(
      candidate,
      AppLocalizations,
    );
    if (l10n == null) return false;
    final text = selector(l10n);
    final textFinder = find.byTooltip(
      text,
      skipOffstage: skipOffstage,
    );
    return textFinder.findInCandidates([candidate]).isNotEmpty;
  }
}

extension L10nCommonFinders on CommonFinders {
  L10nFinders get l10n => _l10nFinders;
}

const _l10nFinders = L10nFinders._();

class L10nFinders {
  const L10nFinders._();

  Finder text(
    L10nSelector selector, {
    bool findRichText = false,
    bool skipOffstage = true,
    String? description,
  }) {
    return _LocalizedTextFinder(
      selector,
      findRichText: findRichText,
      skipOffstage: skipOffstage,
      description: description,
    );
  }

  Finder widgetWithText(
    Type widgetType,
    L10nSelector selector, {
    bool findRichText = false,
    bool skipOffstage = true,
    String? description,
  }) {
    return find.ancestor(
      of: text(
        selector,
        findRichText: findRichText,
        skipOffstage: skipOffstage,
        description: description,
      ),
      matching: find.byType(
        widgetType,
        skipOffstage: skipOffstage,
      ),
    );
  }

  Finder byTooltip(
    L10nSelector selector, {
    bool skipOffstage = true,
    String? description,
  }) {
    return _LocalizedTooltipFinder(
      selector,
      skipOffstage: skipOffstage,
      description: description,
    );
  }
}
