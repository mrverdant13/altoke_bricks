import 'package:common/common.dart';
import 'package:{{objects.snakeCase()}}_sembast_storage/{{objects.snakeCase()}}_sembast_storage.dart';
import 'package:{{objects.snakeCase()}}_storage/{{objects.snakeCase()}}_storage.dart';
import 'package:{{object.snakeCase()}}/{{object.snakeCase()}}.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:sembast/sembast.dart';

/// {@template {{objects.snakeCase()}}_sembast_storage}
/// A persistent [{{objects.pascalCase()}}Storage] implementation using Sembast.
/// {@endtemplate}
class {{objects.pascalCase()}}SembastStorage implements {{objects.pascalCase()}}Storage {
  /// {@macro {{objects.snakeCase()}}_sembast_storage}
  {{objects.pascalCase()}}SembastStorage({
    required this.database,
  });

  /// Store name for the {{objects.lowerCase()}}.
  @visibleForTesting
  static const storeName = '<altoke-entities-sembast-storage>';

  /// Store reference for the {{objects.lowerCase()}}.
  @visibleForTesting
  late final {{objects.pascalCase()}}StoreRef store = StoreRef(storeName);

  /// The Sembast database.
  @visibleForTesting
  final Database database;

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
    await store.addNew{{object.pascalCase()}}(database, new{{object.pascalCase()}});
  }

  @override
  Future<void> insert({
    required {{object.pascalCase()}} {{object.camelCase()}},
  }) async {
    await store.put{{object.pascalCase()}}(database, {{object.camelCase()}});
  }

  @override
  Future<{{object.pascalCase()}}?> getById(
    int {{object.camelCase()}}Id,
  ) async {
    return store.get{{object.pascalCase()}}ById(database, {{object.camelCase()}}Id);
  }

  @override
  Stream<Iterable<{{object.pascalCase()}}>> watch({
    String? searchTerm,
  }) {
    final dbFilter = {{objects.pascalCase()}}Filter.matchesContent(searchTerm);
    return store
        .watch{{objects.pascalCase()}}(database, where: dbFilter)
        .distinct({{objects.camelCase()}}EqualityChecker.equals);
  }

  @override
  Stream<int> watchCount({
    String? searchTerm,
  }) {
    final dbFilter = {{objects.pascalCase()}}Filter.matchesContent(searchTerm);
    return store.watchCount(database, where: dbFilter);
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
    await store.updateWithPartial{{object.pascalCase()}}(
      database,
      id: {{object.camelCase()}}Id,
      partial{{object.pascalCase()}}: partial{{object.pascalCase()}},
    );
  }

  @override
  Future<{{object.pascalCase()}}?> deleteById(
    int {{object.camelCase()}}Id,
  ) async {
    return store.delete{{object.pascalCase()}}ById(database, {{object.camelCase()}}Id);
  }

  @override
  Future<void> deleteAll({
    Partial{{object.pascalCase()}}? reference{{object.pascalCase()}},
  }) async {
    final dbFilter = {{objects.pascalCase()}}Filter.matchesPartial(reference{{object.pascalCase()}});
    await store.deleteAll{{objects.pascalCase()}}(database, where: dbFilter);
  }
}
