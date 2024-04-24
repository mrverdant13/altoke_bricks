import 'package:altoke_common/common.dart';
import 'package:{{objects.snakeCase()}}_drift_storage/{{objects.snakeCase()}}.drift.dart'
    as drift;
import 'package:{{object.snakeCase()}}/{{object.snakeCase()}}.dart';
import 'package:drift/drift.dart';

/// A Drift (SQLite) table for {{objects.titleCase()}}.
typedef Drift{{objects.pascalCase()}}Table = drift.{{objects.pascalCase()}};

/// An extension on [Drift{{objects.pascalCase()}}Table] to add filtering capabilities.
extension Drift{{objects.pascalCase()}}Filter on Drift{{objects.pascalCase()}}Table {
  /// A filter to match the given [content] against the
  /// [drift.{{object.pascalCase()}}.name] and [drift.{{object.pascalCase()}}.description].
  Expression<bool> contentMatches(String? content) {
    return switch (content?.trim()) {
      null => const Constant(true),
      String(:final isEmpty) when isEmpty => const Constant(true),
      final content => name.contains(content) | description.contains(content),
    };
  }

  /// A filter to match the given [partial{{object.pascalCase()}}].
  Expression<bool> matchesPartial(Partial{{object.pascalCase()}} partial{{object.pascalCase()}}) {
    final Partial{{object.pascalCase()}}(:name, :description) = partial{{object.pascalCase()}};
    return Expression.and({
      switch (name) {
        None() => const Constant(true),
        Some(value: final nameFragment) => switch (nameFragment.trim()) {
            String(:final isEmpty) when isEmpty => const Constant(true),
            final nameFragment => this.name.contains(nameFragment),
          },
      },
      switch (description) {
        None() => const Constant(true),
        Some(value: final descriptionFragment) => switch (
              descriptionFragment?.trim()) {
            null => this.description.isNull(),
            String(:final isEmpty) when isEmpty => this.description.isNotNull(),
            final descriptionFragment =>
              this.description.contains(descriptionFragment),
          },
      },
    });
  }
}
