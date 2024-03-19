# Altoke Common

<p align="center">
  <p align="center">
    <a href="https://github.com/mrverdant13/altoke_app/actions/workflows/ci.yaml">
      <img
        src="https://github.com/mrverdant13/altoke_app/actions/workflows/ci.yaml/badge.svg?branch=main"
        alt="GH Actions - CI workflow"
      />
    </a>
    <a href="https://github.com/mrverdant13/altoke_app/actions/workflows/e2e.yaml">
      <img
        src="https://github.com/mrverdant13/altoke_app/actions/workflows/e2e.yaml/badge.svg?branch=main"
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

## Altoke Common

Create a package with a set of common elements used across projects, **_al toque_** (_quickly_).

## Features

- **Value equality:**\
  Supported with one of the following packages:
    - [`dart_mappable`][pub_package_dart_mappable] with code generation.
    - [`equatable`][pub_package_equatable] without code generation.
    - [`freezed`][pub_package_freezed] with code generation.

- **Strict lint rules:**\
  Enforced by [`very_good_analysis`][pub_package_very_good_analysis] for [native Dart & Flutter rules][docs_dart_and_flutter_linter_rules_link].

<!-- LINKS -->

[docs_dart_and_flutter_linter_rules_link]: https://dart.dev/tools/linter-rules
[pub_package_dart_mappable]: https://pub.dev/packages/dart_mappable
[pub_package_equatable]: https://pub.dev/packages/equatable
[pub_package_freezed]: https://pub.dev/packages/freezed
[pub_package_very_good_analysis]: https://pub.dev/packages/very_good_analysis
