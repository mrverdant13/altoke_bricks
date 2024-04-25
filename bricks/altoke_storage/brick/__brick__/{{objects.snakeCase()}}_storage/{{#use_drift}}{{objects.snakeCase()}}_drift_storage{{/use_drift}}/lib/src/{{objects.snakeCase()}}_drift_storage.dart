import 'package:common/common.dart';
import 'package:{{objects.snakeCase()}}_drift_storage/{{objects.snakeCase()}}_drift_storage.dart';
import 'package:{{objects.snakeCase()}}_drift_storage/src/drift_{{object.snakeCase()}}.dart';
import 'package:{{objects.snakeCase()}}_storage/{{objects.snakeCase()}}_storage.dart';
import 'package:{{object.snakeCase()}}/{{object.snakeCase()}}.dart';
import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:meta/meta.dart';

/// {@template {{objects.snakeCase()}}_drift_storage}
/// A persistent [{{objects.pascalCase()}}Storage] implementation using Drift (SQLite).
/// {@endtemplate}
class {{objects.pascalCase()}}DriftStorage implements {{objects.pascalCase()}}Storage {
  /// {@macro {{objects.snakeCase()}}_drift_storage}
  {{objects.pascalCase()}}DriftStorage({
    required this.{{objects.camelCase()}}Dao,
  });

  /// The {{objects.lowerCase()}} DAO.
  @visibleForTesting
  late final Drift{{objects.pascalCase()}}Dao {{objects.camelCase()}}Dao;

  /// The {{objects.lowerCase()}} table.
  Drift{{objects.pascalCase()}}Table get {{objects.camelCase()}}Table =>
      {{objects.camelCase()}}Dao.{{objects.camelCase()}};

  /// Equality checker for [{{object.pascalCase()}}]s.
  @visibleForTesting
  static const {{objects.camelCase()}}EqualityChecker = IterableEquality<{{object.pascalCase()}}>();

  @override
  Future<void> create({
    required New{{object.pascalCase()}} new{{object.pascalCase()}},
  }) async {
    final New{{object.pascalCase()}}(
      name: name,
      description: description,
    ) = new{{object.pascalCase()}};
    if (name.isEmpty) throw const Create{{object.pascalCase()}}FailureEmptyName();
    await {{objects.camelCase()}}Dao.add(name, description);
  }

  @override
  Future<void> insert({
    required {{object.pascalCase()}} {{object.camelCase()}},
  }) async {
    final {{object.pascalCase()}}(
      id: id,
      name: name,
      description: description,
    ) = {{object.camelCase()}};
    await {{objects.camelCase()}}Dao.insert(id, name, description);
  }

  @override
  Future<{{object.pascalCase()}}?> getById(
    int {{object.camelCase()}}Id,
  ) async {
    final raw{{object.pascalCase()}} =
        await {{objects.camelCase()}}Dao.getById({{object.camelCase()}}Id).getSingleOrNull();
    return raw{{object.pascalCase()}}?.to{{object.pascalCase()}}();
  }

  @override
  Stream<List<{{object.pascalCase()}}>> watch({
    String? searchTerm,
  }) {
    final query = {{objects.camelCase()}}Table.select()
      ..where(
        (table) => table.contentMatches(searchTerm),
      )
      ..orderBy(
        [
          ({{objects.camelCase()}}) => OrderingTerm(
                expression: {{objects.camelCase()}}.name,
              ),
        ],
      );
    return query
        .watch()
        .map({{objects.camelCase()}}FromDrift{{objects.pascalCase()}})
        .distinct({{objects.camelCase()}}EqualityChecker.equals);
  }

  @override
  Stream<int> watchCount({
    String? searchTerm,
  }) {
    return {{objects.camelCase()}}Table
        .count(
          where: (table) => table.contentMatches(searchTerm),
        )
        .watchSingle();
  }

  @override
  Future<void> update({
    required int {{object.camelCase()}}Id,
    required Partial{{object.pascalCase()}} partial{{object.pascalCase()}},
  }) async {
    if (partial{{object.pascalCase()}}
        case Partial{{object.pascalCase()}}(name: Some(value: String(:final isEmpty)))
        when isEmpty) {
      throw const Update{{object.pascalCase()}}FailureEmptyName();
    }
    final Partial{{object.pascalCase()}}(
      name: partialName,
      description: partialDescription,
    ) = partial{{object.pascalCase()}};
    await ({{objects.camelCase()}}Table.update()
          ..where(({{objects.camelCase()}}) => {{objects.camelCase()}}.id.equals({{object.camelCase()}}Id)))
        .write(
      Drift{{objects.pascalCase()}}Companion(
        name: switch (partialName) {
          None() => const Value.absent(),
          Some(value: final name) => switch (name.trim()) {
              String(:final isEmpty) when isEmpty => const Value.absent(),
              final name => Value(name),
            }
        },
        description: switch (partialDescription) {
          None() => const Value.absent(),
          Some(value: final description) => switch (description?.trim()) {
              null => const Value.absent(),
              String(:final isEmpty) when isEmpty => const Value.absent(),
              final description => Value(description),
            }
        },
      ),
    );
  }

  @override
  Future<{{object.pascalCase()}}?> deleteById(
    int {{object.camelCase()}}Id,
  ) async {
    final raw{{object.pascalCase()}} =
        await {{objects.camelCase()}}Dao.getById({{object.camelCase()}}Id).getSingleOrNull();
    if (raw{{object.pascalCase()}} == null) return null;
    await {{objects.camelCase()}}Dao.deleteById({{object.camelCase()}}Id);
    return raw{{object.pascalCase()}}.to{{object.pascalCase()}}();
  }

  @override
  Future<void> deleteAll({
    Partial{{object.pascalCase()}}? reference{{object.pascalCase()}},
  }) async {
    if (reference{{object.pascalCase()}} == null) {
      await {{objects.camelCase()}}Table.deleteAll();
      return;
    }
    await {{objects.camelCase()}}Table.deleteWhere(
      ({{objects.camelCase()}}) => {{objects.camelCase()}}.matchesPartial(reference{{object.pascalCase()}}),
    );
  }
}
