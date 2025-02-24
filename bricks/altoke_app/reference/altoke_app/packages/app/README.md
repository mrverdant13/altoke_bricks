# Altoke App

<p align="center">
  <a href="https://pub.dev/packages/very_good_analysis">
    <img
      src="https://img.shields.io/badge/style-very_good_analysis-B22C89.svg"
      alt="Very Good Analysis"
    />
  </a>
  <a href="https://melos.invertase.dev/">
    <img
      src="https://img.shields.io/badge/maintained%20with-melos-f700ff.svg"
      alt="Melos monorepo management tool"
    />
  </a>
</p>

## Altoke App

An Altoke App.

## Mono-repo management

This project uses [Melos][docs_melos_link] to manage the mono-repo.

You can check the available scripts in the `melos.yaml` file, located in the root directory of the project.

**Note:** Don't forget to run `melos bootstrap` first.

<!--{{#use_auto_route}}x-->
## Deep linking <!--x-remove-start-->(`auto_route`)<!--remove-end-->

This project uses the [`auto_route` package][pub_package_auto_route] to support deep linking.

### Adding new routes

1. Create the widget implementation of the new route within the `lib/routing/routes/` directory, replicating the desired routing structure.
2. Register the new route in the `AppRouter` class, within the `lib/routing/router.dart` file, according to the desired routing structure.
3. Update the actual routing setup with code generation.

_For more information, see the [`auto_route` package][pub_package_auto_route] documentation._
<!--x{{/use_auto_route}}x-->
<!--x{{#use_go_router}}x-->
## Deep linking <!--x-remove-start-->(`go_router`)<!--remove-end-->

This project uses the [`go_router` package][pub_package_go_router] to support deep linking.

### Adding new routes

1. Create the widget implementation of the new route within the `lib/routing/routes/` directory, replicating the desired routing structure.
2. Register the new route in the `lib/routing/router.dart` file, according to the desired routing structure.
3. Update the actual routing setup with code generation.

_For more information, see the [`go_router` package][pub_package_go_router] documentation._
<!--x{{/use_go_router}}-->

## Internationalization

This project follows the [official internationalization guide for Flutter][flutter_docs_internationalization_link], and relies on the [flutter_localizations][pub_package_flutter_localizations] and [intl][pub_package_intl] packages.

### Adding new locales

1. Add a new ARB file in `lib/l10n/arb/` for the new locale:

```txt
├── lib
│   ├── l10n
│   │   ├── arb
│   │   │   ├── ...
│   │   │   └── app_<new_locale_code>.arb
```

2. Add the required localized messages to the new ARB file:

```jsonc
// lib/l10n/arb/app_<new_locale_code>
{
  "@@locale": "<new_locale_code>",

  ...

  "<localizedMessageA>": "<localized_message_a>",
  "@<localizedMessageA>": {
    ... // Additional metadata for <localizedMessageA>
  },

  ...

  "<localizedMessageZ>": "<localized_message_z>",
  "@<localizedMessageZ>": {
    ... // Additional metadata for <localizedMessageZ>
  }
}
```

### Adding and using new localized messages

1. Define the new localized messages in each ARB file:

```jsonc
// lib/l10n/arb/app_<locale_code>
{
  "@@locale": "<locale_code>",

  ...

  "<newLocalizedMessage>": "<new_localized_message>",
  "@<newLocalizedMessage>": {
    ... // Additional metadata for <newLocalizedMessage>
  }
}
```

2. Use the new localized messages in the app:

```dart
// Any Dart file where the `BuildContext` is available.

import 'package:altoke_app/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.<newLocalizedMessage>);
}
```

### Important considerations

- Every time an ARB file is created or modified, the generated Dart code must be updated by running `flutter gen-l10n`.\
  **Note:** This step is automatically performed when running `flutter pub get` or `flutter run`.
- The `@@locale` key is required in the every ARB file, and its value must match the locale code of the ARB file.
- The keys prefixed with `@` for each localized message may contain additional metadata, such as `description` and `placeholders`.\
  See the [official internationalization guide for Flutter][flutter_docs_internationalization_link] for more information.
- Every localized message must be defined in every ARB file, even if it is the same as in other ARB files.\
  If a localized message is not defined in a specific ARB file, the console will show a warning when trying to generate the Dart code for the localized messages, and the set of missing localized messages will be added to the `lib/l10n/arb/untranslated-messages.json` file.

<!-- LINKS -->

[docs_melos_link]: https://melos.invertase.dev/
[flutter_docs_internationalization_link]: https://docs.flutter.dev/ui/accessibility-and-localization/internationalization
<!--{{#use_auto_route}}x-->
[pub_package_auto_route]: https://pub.dev/packages/auto_route
<!--{{/use_auto_route}}x-->
[pub_package_flutter_localizations]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
<!--{{#use_go_router}}x-->
[pub_package_go_router]: https://pub.dev/packages/go_router
<!--{{/use_go_router}}x-->
[pub_package_intl]: https://pub.dev/packages/intl
