import 'package:common/common.dart';
import 'package:{{objects.snakeCase()}}_isar_storage/{{objects.snakeCase()}}_isar_storage.dart';
import 'package:{{objects.snakeCase()}}_storage/{{objects.snakeCase()}}_storage.dart';
import 'package:{{object.snakeCase()}}/{{object.snakeCase()}}.dart';
import 'package:collection/collection.dart';
import 'package:isar/isar.dart';
import 'package:meta/meta.dart';

/// {@template {{objects.snakeCase()}}_isar_storage}
/// A persistent [{{objects.pascalCase()}}Storage] implementation using Isar.
/// {@endtemplate}
class {{objects.pascalCase()}}IsarStorage implements {{objects.pascalCase()}}Storage {
  /// {@macro {{objects.snakeCase()}}_isar_storage}
  const {{objects.pascalCase()}}IsarStorage({
    required this.database,
  });

  /// Box for the {{objects.lowerCase()}}.
  @visibleForTesting
  final Isar database;

  /// The {{objects.lowerCase()}} collection.
  @visibleForTesting
  Isar{{objects.pascalCase()}}Collection get {{objects.camelCase()}}Collection =>
      database.isar{{objects.pascalCase()}};

  /// Equality checker for [{{object.pascalCase()}}]s.
  @visibleForTesting
  static const {{objects.camelCase()}}EqualityChecker = IterableEquality<{{object.pascalCase()}}>();

  @override
  Future<void> create({
    required New{{object.pascalCase()}} new{{object.pascalCase()}},
  }) async {
    if (new{{object.pascalCase()}}.name.isEmpty) {
      throw const Create{{object.pascalCase()}}FailureEmptyName();
    }
    await database.writeTxn(
      () async => {{objects.camelCase()}}Collection.put(
        new{{object.pascalCase()}}.toIsar(),
      ),
    );
  }

  @override
  Future<void> insert({
    required {{object.pascalCase()}} {{object.camelCase()}},
  }) async {
    await database.writeTxn(
      () async => {{objects.camelCase()}}Collection.put({{object.camelCase()}}.toIsar()),
    );
  }

  @override
  Future<{{object.pascalCase()}}?> getById(
    int {{object.camelCase()}}Id,
  ) async {
    final isar{{object.pascalCase()}} = await {{objects.camelCase()}}Collection.get({{object.camelCase()}}Id);
    return isar{{object.pascalCase()}}?.to{{object.pascalCase()}}();
  }

  @override
  Stream<Iterable<{{object.pascalCase()}}>> watch({
    String? searchTerm,
  }) {
    final query = {{objects.camelCase()}}Collection
        .filter()
        .contentMatches(searchTerm)
        .sortByName();
    return query
        .watch(fireImmediately: true)
        .map({{objects.camelCase()}}FromIsar{{objects.pascalCase()}})
        .distinct({{objects.camelCase()}}EqualityChecker.equals);
  }

  @override
  Stream<int> watchCount({
    String? searchTerm,
  }) {
    return {{objects.camelCase()}}Collection
        .filter()
        .contentMatches(searchTerm)
        .watch(fireImmediately: true)
        .map(({{objects.camelCase()}}) => {{objects.camelCase()}}.length);
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
    await database.writeTxn(
      () async {
        final isar{{object.pascalCase()}} =
            await {{objects.camelCase()}}Collection.get({{object.camelCase()}}Id);
        if (isar{{object.pascalCase()}} == null) return;
        await {{objects.camelCase()}}Collection.put(
          isar{{object.pascalCase()}}.copyWithAppliedPartial(partial{{object.pascalCase()}}),
        );
      },
    );
  }

  @override
  Future<{{object.pascalCase()}}?> deleteById(
    int {{object.camelCase()}}Id,
  ) async {
    final isar{{object.pascalCase()}} = await {{objects.camelCase()}}Collection.get({{object.camelCase()}}Id);
    if (isar{{object.pascalCase()}} == null) return null;
    await database.writeTxn(
      () async => {{objects.camelCase()}}Collection.delete({{object.camelCase()}}Id),
    );
    return isar{{object.pascalCase()}}.to{{object.pascalCase()}}();
  }

  @override
  Future<void> deleteAll({
    Partial{{object.pascalCase()}}? reference{{object.pascalCase()}},
  }) async {
    final query =
        {{objects.camelCase()}}Collection.filter().matchesPartial(reference{{object.pascalCase()}});
    await database.writeTxn(
      () async => query.deleteAll(),
    );
  }
}
