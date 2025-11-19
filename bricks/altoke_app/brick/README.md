# Altoke App

<!-- DO NOT EDIT - THIS IS AUTOMATICALLY GENERATED -->
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

<!-- EDITABLE -->
<!-- FEATURES -->
## Altoke App

Create a [Flutter][link_docs_flutter] app, **_al toque_** (_quickly_).

### Features

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
  Supported with one of the following packages:
  - [`flutter_bloc`][link_pub_package_flutter_bloc]
  - [`flutter_riverpod`][link_pub_package_flutter_riverpod]

- **Strict lint rules:**\
  Enforced by:
  - [`very_good_analysis`][link_pub_package_very_good_analysis] for [native Dart & Flutter rules][link_docs_dart_and_flutter_linter_rules].
  - [`custom_lint`][link_pub_package_custom_lint] for the following specialized rules:
    - [`riverpod_lint`][link_pub_package_riverpod_lint].

- **Testing:**\
  Tests with 100% coverage.
<!-- FEATURES -->

<!-- DO NOT EDIT - THIS IS AUTOMATICALLY GENERATED -->
<!-- VARIABLES -->
### Variables

| Variable | Description | Default | Type |
| -------- | ----------- | ------- | ---- |
| `project_name` | The name of the project. | _None_ | String |
| `project_description` | A description of the project. | _None_ | String |
| `android_organization` | The organization of the Android project. | _None_ | String |
| `ios_bundle_identifier` | The bundle identifier of the iOS project. | _None_ | String |
| `router_package` | The package to use for routing. | auto_route | Enumeration |
<!-- VARIABLES -->

<!-- EDITABLE -->
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
[link_pub_package_flutter_bloc]: https://pub.dev/packages/flutter_bloc
[link_pub_package_flutter_riverpod]: https://pub.dev/packages/flutter_riverpod
[link_pub_package_go_router]: https://pub.dev/packages/go_router
[link_pub_package_riverpod_lint]: https://pub.dev/packages/riverpod_lint
[link_pub_package_very_good_analysis]: https://pub.dev/packages/very_good_analysis
<!-- BRICK LINKS -->
