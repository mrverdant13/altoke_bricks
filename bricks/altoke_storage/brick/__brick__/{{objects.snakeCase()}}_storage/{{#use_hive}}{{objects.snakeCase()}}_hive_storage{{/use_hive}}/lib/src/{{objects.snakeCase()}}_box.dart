import 'package:common/common.dart';
import 'package:{{objects.snakeCase()}}_hive_storage/{{objects.snakeCase()}}_hive_storage.dart';
import 'package:{{object.snakeCase()}}/{{object.snakeCase()}}.dart';
import 'package:collection/collection.dart';
import 'package:hive/hive.dart';

/// The box for {{objects.titleCase()}}.
typedef {{objects.pascalCase()}}Box = Box<Map<dynamic, dynamic>>;

/// An extension on [{{objects.pascalCase()}}Box] to add functionality.
extension Extended{{objects.pascalCase()}}Box on {{objects.pascalCase()}}Box {
  /// Returns all the persisted {{objects.lowerCase()}}.
  Iterable<{{object.pascalCase()}}> get {{objects.camelCase()}} {
    return toMap().entries.map((entry) => entry.to{{object.pascalCase()}}());
  }

  /// Saves the [new{{object.pascalCase()}}] to the box with an auto-generated ID.
  Future<int> addNew{{object.pascalCase()}}(New{{object.pascalCase()}} new{{object.pascalCase()}}) async {
    return add(new{{object.pascalCase()}}.toHiveJson());
  }

  /// Saves the [{{object.camelCase()}}] to the box.
  Future<void> put{{object.pascalCase()}}({{object.pascalCase()}} {{object.camelCase()}}) async {
    return put({{object.camelCase()}}.id, {{object.camelCase()}}.toHiveJson());
  }

  /// Retrieves the {{object.lowerCase()}} with the given [id].
  {{object.pascalCase()}}? get{{object.pascalCase()}}ById(int id) {
    final raw{{object.pascalCase()}} = get(id);
    if (raw{{object.pascalCase()}} == null) return null;
    return Hive{{object.pascalCase()}}.fromJson(raw{{object.pascalCase()}}).to{{object.pascalCase()}}WithId(id);
  }

  /// Returns the {{objects.lowerCase()}} that match the given [where] filter.
  ///
  /// The results are sorted by name.
  Iterable<{{object.pascalCase()}}> get{{objects.pascalCase()}}({
    required WhereCallback<{{object.pascalCase()}}> where,
  }) {
    return {{objects.camelCase()}}
        .where(where)
        .sortedBy(({{object.camelCase()}}) => {{object.camelCase()}}.name);
  }

  /// Returns the count of {{objects.lowerCase()}} that match the given [where] filter.
  int getCount({
    required WhereCallback<{{object.pascalCase()}}> where,
  }) {
    return {{objects.camelCase()}}.where(where).length;
  }

  /// Updates the {{object.lowerCase()}} with the given [id] with the new
  /// [partial{{object.pascalCase()}}].
  Future<void> updateWithPartial{{object.pascalCase()}}({
    required int id,
    required Partial{{object.pascalCase()}} partial{{object.pascalCase()}},
  }) async {
    final raw{{object.pascalCase()}} = get(id);
    if (raw{{object.pascalCase()}} == null) return;
    final {{object.camelCase()}} = Hive{{object.pascalCase()}}.fromJson(raw{{object.pascalCase()}})
        .copyWithAppliedPartial(partial{{object.pascalCase()}});
    await put(
      id,
      {{object.camelCase()}}.toJson(),
    );
  }

  /// Deletes the {{object.lowerCase()}} with the given [id].
  Future<{{object.pascalCase()}}?> delete{{object.pascalCase()}}ById(int id) async {
    final raw{{object.pascalCase()}} = get(id);
    if (raw{{object.pascalCase()}} == null) return null;
    await delete(id);
    return Hive{{object.pascalCase()}}.fromJson(raw{{object.pascalCase()}}).to{{object.pascalCase()}}WithId(id);
  }

  /// Deletes all the {{objects.lowerCase()}} that match the given [where] filter.
  Future<void> deleteAll{{objects.pascalCase()}}({
    required WhereCallback<{{object.pascalCase()}}> where,
  }) async {
    final keysToDelete =
        {{objects.camelCase()}}.where(where).map(({{object.camelCase()}}) => {{object.camelCase()}}.id);
    await deleteAll(keysToDelete);
  }
}

/// A set of filters to apply on [{{object.pascalCase()}}]s
abstract class {{objects.pascalCase()}}Filter {
  /// A filter to match the given [partial{{object.pascalCase()}}].
  static WhereCallback<{{object.pascalCase()}}>? matchesPartial(
    Partial{{object.pascalCase()}}? partial{{object.pascalCase()}},
  ) {
    if (partial{{object.pascalCase()}} == null) return null;
    final Partial{{object.pascalCase()}}(:name, :description) = partial{{object.pascalCase()}};
    final nameMatches = switch (name) {
      None() => noFilter,
      Some(value: final nameFragment) => nameContains(nameFragment),
    };
    final descriptionMatches = switch (description) {
      None() => noFilter,
      Some(value: final descriptionFragment) => switch (
            descriptionFragment?.trim()) {
          null => descriptionIsNull(),
          final descriptionFragment => descriptionContains(descriptionFragment),
        },
    };
    return andAll([nameMatches, descriptionMatches]);
  }

  /// A filter to match the given [name] against the [{{object.pascalCase()}}.name].
  static WhereCallback<{{object.pascalCase()}}> nameContains(String name) {
    return switch (name.trim()) {
      String(:final isEmpty) when isEmpty => noFilter,
      final searchTerm => ({{object.camelCase()}}) =>
          {{object.camelCase()}}.name.contains(searchTerm),
    };
  }

  /// A filter to match `null` [{{object.pascalCase()}}.description]s.
  static WhereCallback<{{object.pascalCase()}}> descriptionIsNull() {
    return ({{object.camelCase()}}) => {{object.camelCase()}}.description == null;
  }

  /// A filter to match non-`null` [{{object.pascalCase()}}.description]s.
  static WhereCallback<{{object.pascalCase()}}> descriptionIsNotNull() {
    return ({{object.camelCase()}}) => {{object.camelCase()}}.description != null;
  }

  /// A filter to match the given [description] against the
  /// [{{object.pascalCase()}}.description].
  static WhereCallback<{{object.pascalCase()}}> descriptionContains(String description) {
    return switch (description.trim()) {
      String(:final isEmpty) when isEmpty => descriptionIsNotNull(),
      final descriptionFragment => ({{object.camelCase()}}) =>
          {{object.camelCase()}}.description?.contains(descriptionFragment) ?? false,
    };
  }

  /// A filter to match the given [content] against the [{{object.pascalCase()}}.name] and
  /// [{{object.pascalCase()}}.description].
  static WhereCallback<{{object.pascalCase()}}> matchesContent(
    String? content,
  ) {
    return switch (content?.trim()) {
      null => noFilter,
      String(:final isEmpty) when isEmpty => noFilter,
      final searchTerm => orAll([
          nameContains(searchTerm),
          descriptionContains(searchTerm),
        ])
    };
  }

  /// A filter that combines the given [filters] to match all of them.
  static WhereCallback<{{object.pascalCase()}}> andAll(
    Iterable<WhereCallback<{{object.pascalCase()}}>?> filters,
  ) {
    final validFilters = filters.whereNotNull();
    if (validFilters.isEmpty) return noFilter;
    return ({{object.camelCase()}}) =>
        validFilters.every((filter) => filter({{object.camelCase()}}));
  }

  /// A filter that combines the given [filters] to match any of them.
  static WhereCallback<{{object.pascalCase()}}> orAll(
    Iterable<WhereCallback<{{object.pascalCase()}}>?> filters,
  ) {
    final validFilters = filters.whereNotNull();
    if (validFilters.isEmpty) return noFilter;
    return ({{object.camelCase()}}) => validFilters.any((filter) => filter({{object.camelCase()}}));
  }
}
