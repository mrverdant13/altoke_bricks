import 'package:altoke_common/common.dart';
import 'package:{{object.snakeCase()}}/{{object.snakeCase()}}.dart';
import 'package:collection/collection.dart';

/// A set of filters to apply on [{{object.pascalCase()}}]s
abstract class {{objects.pascalCase()}}Filter {
  /// A filter to match the given [partial{{object.pascalCase()}}].
  static String? matchesPartial(
    Partial{{object.pascalCase()}}? partial{{object.pascalCase()}},
  ) {
    if (partial{{object.pascalCase()}} == null) return null;
    final Partial{{object.pascalCase()}}(:name, :description) = partial{{object.pascalCase()}};
    final nameMatches = switch (name) {
      None() => null,
      Some(value: final nameFragment) => nameContains(nameFragment),
    };
    final descriptionMatches = switch (description) {
      None() => null,
      Some(value: final descriptionFragment) => switch (
            descriptionFragment?.trim()) {
          null => descriptionIsNull(),
          final descriptionFragment => descriptionContains(descriptionFragment),
        },
    };
    return andAll([nameMatches, descriptionMatches]);
  }

  /// A filter to match the given [name] against the [{{object.pascalCase()}}.name].
  static String? nameContains(String name) {
    return switch (name.trim()) {
      String(:final isEmpty) when isEmpty => null,
      final searchTerm => 'name CONTAINS "$searchTerm"',
    };
  }

  /// A filter to match `null` [{{object.pascalCase()}}.description]s.
  static String descriptionIsNull() {
    return 'description == null';
  }

  /// A filter to match non-`null` [{{object.pascalCase()}}.description]s.
  static String descriptionIsNotNull() {
    return 'description != null';
  }

  /// A filter to match the given [description] against the
  /// [{{object.pascalCase()}}.description].
  static String? descriptionContains(String description) {
    return switch (description.trim()) {
      String(:final isEmpty) when isEmpty => descriptionIsNotNull(),final descriptionFragment =>
        'description CONTAINS "$descriptionFragment"',
    };
  }

  /// A filter to match the given [content] against the [{{object.pascalCase()}}.name] and
  /// [{{object.pascalCase()}}.description].
  static String? matchesContent(String? content) {
    return switch (content?.trim()) {
      null => null,
      String(:final isEmpty) when isEmpty => null,
      final content => orAll([
          nameContains(content),
          descriptionContains(content),
        ]),
    };
  }

  /// A filter that combines the given [filters] to match all of them.
  static String? andAll(Iterable<String?> filters) {
    final validFilters = filters.whereNotNull();
    if (validFilters.isEmpty) return null;
    return validFilters.join(' AND ');
  }

  /// A filter that combines the given [filters] to match any of them.
  static String? orAll(Iterable<String?> filters) {
    final validFilters = filters.whereNotNull();
    if (validFilters.isEmpty) return null;
    return validFilters.join(' OR ');
  }
}
