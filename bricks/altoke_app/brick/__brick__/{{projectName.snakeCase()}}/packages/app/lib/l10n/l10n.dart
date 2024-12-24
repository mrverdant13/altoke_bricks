import 'package:{{projectName.snakeCase()}}/l10n/gen/app_localizations.dart';
import 'package:flutter/widgets.dart';

export 'package:{{projectName.snakeCase()}}/l10n/gen/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
