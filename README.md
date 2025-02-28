# Altoke Bricks

<!-- EDITABLE -->
<!-- BANNERS HEADER -->
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
<!-- BANNERS HEADER -->

---

Create different Dart and Flutter projects, **_al toque_** (_quickly_), with out-of-the-box features.

## Bricks

<!-- DO NOT EDIT - THIS IS AUTOMATICALLY GENERATED -->
<!-- FEATURES -->
### 🧱 Altoke App

Create a [Flutter][link_docs_flutter] app, **_al toque_** (_quickly_).

#### Features

- **Multi-platform support:**\
  Support for the following platforms:
  - Android
  - iOS

- **Mono-repo setup:**\
  Supported with [Dart Workspaces][link_docs_dart_workspaces] and [Melos][link_docs_melos], with pre-configured scripts for common tasks.

- **Deep linking:**\
  Supported with one the following packages:
  - [`auto_route`][link_pub_package_auto_route]
  - [`go_router`][link_pub_package_go_router]

- **Spell checking:**\
  Supported with [CSpell][link_docs_cspell].\
  VSCode integration with the [Code Spell Checker extension][link_docs_vsc_spell_checker].

- **Flavoring:**\
  Support for the following environments (Android & iOS only):
  - 🔴 Development
  - 🟡 Staging
  - 🟢 Production

- **Internationalization:**\
  Supported by following the [official internationalization guide for Flutter][link_docs_flutter_internationalization].\
  VSCode integration with the [ARB Editor extension][link_docs_vsc_arb_editor].

- **State management:**\
  Supported with [`flutter_riverpod`][link_pub_package_flutter_riverpod].

- **Strict lint rules:**\
  Enforced by:
  - [`very_good_analysis`][link_pub_package_very_good_analysis] for [native Dart & Flutter rules][link_docs_dart_and_flutter_linter_rules].
  - [`custom_lint`][link_pub_package_custom_lint] for the following specialized rules:
    - [`riverpod_lint`][link_pub_package_riverpod_lint].

- **Testing:**\
  Tests with 100% coverage.

### 🧱 Altoke Common

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

### 🧱 Altoke Dart Package

Create a Dart package, **_al toque_** (_quickly_).

#### Features

- **Optional Code Generation Setup**

- **Strict lint rules:**\
  Enforced by [`very_good_analysis`][pub_package_very_good_analysis] for [native Dart & Flutter rules][docs_dart_and_flutter_linter_rules_link].

- **Testing:**\
  Tests with 100% coverage.

### 🧱 Altoke Entity

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

### 🧱 Altoke Local Database

Create a local database, **_al toque_** (_quickly_).

#### Features

- **Data persistence:**\
  Supported with one of the following alternatives:
    - [`drift` (SQLite)][pub_package_drift]
    - [`hive`][pub_package_hive]
    - [`sembast`][pub_package_sembast]

- **Strict lint rules:**\
  Enforced by [`very_good_analysis`][pub_package_very_good_analysis] for [native Dart & Flutter rules][docs_dart_and_flutter_linter_rules_link].

- **Testing:**\
  Tests with 100% coverage.

### 🧱 Altoke Reactive Caches

Create a package that provides general-purpose caches, **_al toque_** (_quickly_).

#### Features

- **Flexibility:**\
  The package contains a single-element cache and a list cache, including methods that are often used in the context of caching.

- **Strict lint rules:**\
  Enforced by [`very_good_analysis`][pub_package_very_good_analysis] for [native Dart & Flutter rules][docs_dart_and_flutter_linter_rules_link].

- **Testing:**\
  Tests with 100% coverage.
<!-- FEATURES -->

<!-- DO NOT EDIT - THIS IS AUTOMATICALLY GENERATED -->
<!-- BRICK LINKS -->
[link_docs_cspell]: https://cspell.org/
[link_docs_dart_and_flutter_linter_rules]: https://dart.dev/tools/linter-rules
[link_docs_dart_workspaces]: https://dart.dev/tools/pub/workspaces
[link_docs_flutter_internationalization]: https://docs.flutter.dev/ui/accessibility-and-localization/internationalization
[link_docs_flutter]: https://flutter.dev/
[link_docs_melos]: https://melos.invertase.dev/
[link_docs_vsc_arb_editor]: https://marketplace.visualstudio.com/items?itemName=Google.arb-editor
[link_docs_vsc_spell_checker]: https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker
[link_pub_package_auto_route]: https://pub.dev/packages/auto_route
[link_pub_package_custom_lint]: https://pub.dev/packages/custom_lint
[link_pub_package_flutter_riverpod]: https://pub.dev/packages/flutter_riverpod
[link_pub_package_go_router]: https://pub.dev/packages/go_router
[link_pub_package_riverpod_lint]: https://pub.dev/packages/riverpod_lint
[link_pub_package_very_good_analysis]: https://pub.dev/packages/very_good_analysis
[docs_dart_and_flutter_linter_rules_link]: https://dart.dev/tools/linter-rules
[pub_package_dart_mappable]: https://pub.dev/packages/dart_mappable
[pub_package_equatable]: https://pub.dev/packages/equatable
[pub_package_freezed]: https://pub.dev/packages/freezed
[pub_package_very_good_analysis]: https://pub.dev/packages/very_good_analysis
[pub_package_drift]: https://pub.dev/packages/drift
[pub_package_hive]: https://pub.dev/packages/hive
[pub_package_sembast]: https://pub.dev/packages/sembast
<!-- BRICK LINKS -->

<!-- EDITABLE -->
<!-- ROOT LINKS -->
<!-- ROOT LINKS -->
