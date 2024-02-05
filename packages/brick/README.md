# Altoke App

<!-- [github_actions_workflow_ci_badge]: https://github.com/mrverdant13/altoke_app/actions/workflows/ci.yaml/badge.svg -->
<!-- [github_actions_workflow_ci_link]: https://github.com/mrverdant13/altoke_app/actions/workflows/ci.yaml -->
<!-- [github_actions_workflow_e2e_badge]: https://github.com/mrverdant13/altoke_app/actions/workflows/e2e.yaml/badge.svg -->
<!-- [github_actions_workflow_e2e_link]: https://github.com/mrverdant13/altoke_app/actions/workflows/e2e.yaml -->


<p align="center">
  <p align="center">
    <a href="https://github.com/mrverdant13/altoke_app/actions/workflows/ci.yaml">
      <img
        src="https://github.com/mrverdant13/altoke_app/actions/workflows/ci.yaml/badge.svg"
        alt="GH Actions - CI workflow"
      />
    </a>
    <a href="https://github.com/mrverdant13/altoke_app/actions/workflows/e2e.yaml">
      <img
        src="https://github.com/mrverdant13/altoke_app/actions/workflows/e2e.yaml/badge.svg"
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

## Altoke App

Create a [Flutter][flutter_web_link] app, **_al toque_** (_quickly_).

## Features

- **Mono-repo setup:**\
  Supported with [Melos][docs_melos_link], with pre-configured scripts for common tasks.

- **Data persistence:**\
  Local data persistence example. Supported with one of the following packages:
    - [`hive`][pub_package_hive] ([Hive docs][docs_hive_link]).
    - [`isar`][pub_package_isar] ([Isar docs][docs_isar_link]).
    - [`realm`][pub_package_realm] ([Realm docs for Flutter][docs_realm_for_flutter_link]).
    - [`sembast`][pub_package_sembast] ([Sembast docs][docs_sembast_link]).
    - [`drift` (SQLite)][pub_package_drift] ([Drift docs][docs_drift_link]).

- **Deep linking:**\
  Supported with one the following packages:
  - [`auto_route`][pub_package_auto_route]
  - [`go_router`][pub_package_go_router]

- **Internationalization:**\
  Supported by following the [official internationalization guide for Flutter][flutter_docs_internationalization_link].

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
[docs_drift_link]:https://drift.simonbinder.eu/
[docs_hive_link]: https://docs.hivedb.dev/
[docs_isar_link]: https://isar.dev/
[docs_melos_link]: https://melos.invertase.dev/
[docs_sembast_link]: https://github.com/tekartik/sembast.dart/blob/master/sembast/doc/guide.md
[docs_realm_for_flutter_link]: https://www.mongodb.com/docs/realm/sdk/flutter/
[flutter_docs_internationalization_link]: https://docs.flutter.dev/ui/accessibility-and-localization/internationalization
[flutter_web_link]: https://flutter.dev/
[pub_package_auto_route]: https://pub.dev/packages/auto_route
[pub_package_custom_lint]: https://pub.dev/packages/custom_lint
[pub_package_flutter_riverpod]: https://pub.dev/packages/flutter_riverpod
[pub_package_go_router]: https://pub.dev/packages/go_router
[pub_package_drift]: https://pub.dev/packages/drift
[pub_package_hive]: https://pub.dev/packages/hive
[pub_package_isar]: https://pub.dev/packages/isar
[pub_package_realm]: https://pub.dev/packages/realm
[pub_package_riverpod_lint]: https://pub.dev/packages/riverpod_lint
[pub_package_sembast]: https://pub.dev/packages/sembast
[pub_package_very_good_analysis]: https://pub.dev/packages/very_good_analysis
