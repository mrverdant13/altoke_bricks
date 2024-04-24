import 'package:altoke_common/common.dart';
import 'package:{{objects.snakeCase()}}_hive_storage/{{objects.snakeCase()}}_hive_storage.dart';
import 'package:{{objects.snakeCase()}}_storage/{{objects.snakeCase()}}_storage.dart';
import 'package:{{object.snakeCase()}}/{{object.snakeCase()}}.dart';
import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

/// {@template {{objects.snakeCase()}}_hive_storage}
/// A persistent [{{objects.pascalCase()}}Storage] implementation using Hive.
/// {@endtemplate}
class {{objects.pascalCase()}}HiveStorage implements {{objects.pascalCase()}}Storage {
  /// {@macro {{objects.snakeCase()}}_hive_storage}
  {{objects.pascalCase()}}HiveStorage();

  /// Name for the {{objects.lowerCase()}} {{objects.camelCase()}}Box.
  static const {{objects.camelCase()}}BoxName = '.altoke-entities-hive-storage.';

  /// Box for the {{objects.lowerCase()}}.
  @visibleForTesting
  final Future<{{objects.pascalCase()}}Box> async{{objects.pascalCase()}}Box =
      Hive.openBox({{objects.camelCase()}}BoxName);

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
    final {{objects.camelCase()}}Box = await async{{objects.pascalCase()}}Box;
    await {{objects.camelCase()}}Box.addNew{{object.pascalCase()}}(new{{object.pascalCase()}});
  }

  @override
  Future<void> insert({
    required {{object.pascalCase()}} {{object.camelCase()}},
  }) async {
    final {{objects.camelCase()}}Box = await async{{objects.pascalCase()}}Box;
    await {{objects.camelCase()}}Box.put{{object.pascalCase()}}({{object.camelCase()}});
  }

  @override
  Future<{{object.pascalCase()}}?> getById(
    int {{object.camelCase()}}Id,
  ) async {
    final {{objects.camelCase()}}Box = await async{{objects.pascalCase()}}Box;
    return {{objects.camelCase()}}Box.get{{object.pascalCase()}}ById({{object.camelCase()}}Id);
  }

  @override
  Stream<Iterable<{{object.pascalCase()}}>> watch({
    String? searchTerm,
  }) async* {
    final dbFilter = {{objects.pascalCase()}}Filter.matchesContent(searchTerm);
    final {{objects.camelCase()}}Box = await async{{objects.pascalCase()}}Box;
    yield* () async* {
      yield {{objects.camelCase()}}Box.get{{objects.pascalCase()}}(where: dbFilter);
      yield* {{objects.camelCase()}}Box
          .watch()
          .map((_) => {{objects.camelCase()}}Box.get{{objects.pascalCase()}}(where: dbFilter));
    }()
        .distinct({{objects.camelCase()}}EqualityChecker.equals);
  }

  @override
  Stream<int> watchCount({
    String? searchTerm,
  }) async* {
    final dbFilter = {{objects.pascalCase()}}Filter.matchesContent(searchTerm);
    final {{objects.camelCase()}}Box = await async{{objects.pascalCase()}}Box;
    yield* () async* {
      yield {{objects.camelCase()}}Box.getCount(where: dbFilter);
      yield* {{objects.camelCase()}}Box
          .watch()
          .map((_) => {{objects.camelCase()}}Box.getCount(where: dbFilter));
    }()
        .distinct();
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
    final {{objects.camelCase()}}Box = await async{{objects.pascalCase()}}Box;
    return {{objects.camelCase()}}Box.updateWithPartial{{object.pascalCase()}}(
      id: {{object.camelCase()}}Id,
      partial{{object.pascalCase()}}: partial{{object.pascalCase()}},
    );
  }

  @override
  Future<{{object.pascalCase()}}?> deleteById(
    int {{object.camelCase()}}Id,
  ) async {
    final {{objects.camelCase()}}Box = await async{{objects.pascalCase()}}Box;
    return {{objects.camelCase()}}Box.delete{{object.pascalCase()}}ById({{object.camelCase()}}Id);
  }

  @override
  Future<void> deleteAll({
    Partial{{object.pascalCase()}}? reference{{object.pascalCase()}},
  }) async {
    final {{objects.camelCase()}}Box = await async{{objects.pascalCase()}}Box;
    final filter = {{objects.pascalCase()}}Filter.matchesPartial(reference{{object.pascalCase()}});
    if (filter == null) {
      await {{objects.camelCase()}}Box.clear();
      return;
    }
    await {{objects.camelCase()}}Box.deleteAll{{objects.pascalCase()}}(where: filter);
  }

  /// Frees up resources used by the storage.
  Future<void> dispose() async {
    final {{objects.camelCase()}}Box = await async{{objects.pascalCase()}}Box;
    await {{objects.camelCase()}}Box.close();
  }
}
