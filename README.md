# Altoke Bricks

<p align="center">
  <p align="center">
    <a href="https://github.com/mrverdant13/altoke_bricks/actions/workflows/ci.yaml">
      <img
        src="https://github.com/mrverdant13/altoke_bricks/actions/workflows/ci.yaml/badge.svg?branch=main"
        alt="GH Actions - CI workflow"
      />
    </a>
    <a href="https://github.com/mrverdant13/altoke_bricks/actions/workflows/e2e.yaml">
      <img
        src="https://github.com/mrverdant13/altoke_bricks/actions/workflows/e2e.yaml/badge.svg?branch=main"
        alt="GH Actions - E2E workflow"
      />
    </a>
  </p>
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
    <a href="https://docs.brickhub.dev/">
      <img
        src="https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge"
        alt="Mason documentation"
      />
    </a>
  </p>
</p>

---

Create different Dart and Flutter projects, **_al toque_** (_quickly_), with out-of-the-box features.

## Bricks

### Altoke App

Create a [Flutter][flutter_web_link] app, **_al toque_** (_quickly_).

#### Features

- **Mono-repo setup:**\
  Supported with [Melos][docs_melos_link], with pre-configured scripts for common tasks.

- **Deep linking:**\
  Supported with one the following packages:
  - [`auto_route`][pub_package_auto_route]
  - [`go_router`][pub_package_go_router]

- **Internationalization:**\
  Supported by following the [official internationalization guide for Flutter][flutter_docs_internationalization_link].

- **Spell checking:**\
  Supported with [CSpell][docs_cspell_link].\
  VSCode integration with the [Code Spell Checker extension][docs_vsc_spell_checker_link].

- **State management:**\
  Supported with [`flutter_riverpod`][pub_package_flutter_riverpod].

- **Strict lint rules:**\
  Enforced by:
  - [`very_good_analysis`][pub_package_very_good_analysis] for [native Dart & Flutter rules][dart_and_flutter_linter_rules_link].
  - [`custom_lint`][pub_package_custom_lint] for the following specialized rules:
    - [`riverpod_lint`][pub_package_riverpod_lint].

- **Testing:**\
  Tests with 100% coverage.

<!-- LINKS -->

[dart_and_flutter_linter_rules_link]: https://dart.dev/tools/linter-rules
[docs_cspell_link]: https://cspell.org/
[docs_melos_link]: https://melos.invertase.dev/
[docs_vsc_spell_checker_link]: https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker
[flutter_docs_internationalization_link]: https://docs.flutter.dev/ui/accessibility-and-localization/internationalization
[flutter_web_link]: https://flutter.dev/
[pub_package_auto_route]: https://pub.dev/packages/auto_route
[pub_package_custom_lint]: https://pub.dev/packages/custom_lint
[pub_package_flutter_riverpod]: https://pub.dev/packages/flutter_riverpod
[pub_package_go_router]: https://pub.dev/packages/go_router
[pub_package_riverpod_lint]: https://pub.dev/packages/riverpod_lint
[pub_package_very_good_analysis]: https://pub.dev/packages/very_good_analysis

### Altoke Common

Create a package with a set of common elements used across projects, **_al toque_** (_quickly_).

#### Features

- **Value equality:**\
  Supported with one of the following approaches:
    - [`dart_mappable`][pub_package_dart_mappable] with code generation.
    - [`equatable`][pub_package_equatable] without code generation.
    - [`freezed`][pub_package_freezed] with code generation.
    - Manual `==` operator and `hashCode` overrides.

- **Strict lint rules:**\
  Enforced by [`very_good_analysis`][pub_package_very_good_analysis] for [native Dart & Flutter rules][docs_dart_and_flutter_linter_rules_link].

- **Testing:**\
  Tests with 100% coverage.

<!-- LINKS -->

[docs_dart_and_flutter_linter_rules_link]: https://dart.dev/tools/linter-rules
[pub_package_dart_mappable]: https://pub.dev/packages/dart_mappable
[pub_package_equatable]: https://pub.dev/packages/equatable
[pub_package_freezed]: https://pub.dev/packages/freezed
[pub_package_very_good_analysis]: https://pub.dev/packages/very_good_analysis

### Altoke Entity

Create an entity, **_al toque_** (_quickly_).

#### Features

- **Value equality:**\
  Supported with one of the following approaches:
    - [`dart_mappable`][pub_package_dart_mappable] with code generation.
    - [`equatable`][pub_package_equatable] without code generation.
    - [`freezed`][pub_package_freezed] with code generation.
    - Manual `==` operator and `hashCode` overrides.

- **Strict lint rules:**\
  Enforced by [`very_good_analysis`][pub_package_very_good_analysis] for [native Dart & Flutter rules][docs_dart_and_flutter_linter_rules_link].

- **Testing:**\
  Tests with 100% coverage.

<!-- LINKS -->

[docs_dart_and_flutter_linter_rules_link]: https://dart.dev/tools/linter-rules
[pub_package_dart_mappable]: https://pub.dev/packages/dart_mappable
[pub_package_equatable]: https://pub.dev/packages/equatable
[pub_package_freezed]: https://pub.dev/packages/freezed
[pub_package_very_good_analysis]: https://pub.dev/packages/very_good_analysis

### Altoke Reactive Caches

Create a package that provides general-purpose caches, **_al toque_** (_quickly_).

#### Features

- **Flexibility:**\
  The package contains a single-element cache and a list cache, including methods that are often used in the context of caching.

- **Strict lint rules:**\
  Enforced by [`very_good_analysis`][pub_package_very_good_analysis] for [native Dart & Flutter rules][docs_dart_and_flutter_linter_rules_link].

- **Testing:**\
  Tests with 100% coverage.

<!-- LINKS -->

[docs_dart_and_flutter_linter_rules_link]: https://dart.dev/tools/linter-rules
[pub_package_very_good_analysis]: https://pub.dev/packages/very_good_analysis

### Altoke Storage

Create a storage, **_al toque_** (_quickly_).

#### Features

- **Data persistence:**\
  Supported with one of the following packages:
    - [`hive`][pub_package_hive]
    - [`isar`][pub_package_isar]
    - [`realm`][pub_package_realm]
    - [`sembast`][pub_package_sembast]
    - [`drift`][pub_package_drift]

- **Strict lint rules:**\
  Enforced by [`very_good_analysis`][pub_package_very_good_analysis] for [native Dart & Flutter rules][docs_dart_and_flutter_linter_rules_link].

- **Testing:**\
  Tests with 100% coverage.

<!-- LINKS -->

[docs_dart_and_flutter_linter_rules_link]: https://dart.dev/tools/linter-rules
[pub_package_hive]: https://pub.dev/packages/hive
[pub_package_isar]: https://pub.dev/packages/isar
[pub_package_realm]: https://pub.dev/packages/realm
[pub_package_sembast]: https://pub.dev/packages/sembast
[pub_package_drift]: https://pub.dev/packages/drift
[pub_package_very_good_analysis]: https://pub.dev/packages/very_good_analysis
