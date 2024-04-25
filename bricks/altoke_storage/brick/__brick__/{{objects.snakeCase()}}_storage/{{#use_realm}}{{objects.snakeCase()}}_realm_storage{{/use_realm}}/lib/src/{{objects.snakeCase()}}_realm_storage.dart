import 'package:common/common.dart';
import 'package:{{objects.snakeCase()}}_realm_storage/src/{{objects.snakeCase()}}_filter.dart';
import 'package:{{objects.snakeCase()}}_realm_storage/src/realm_{{object.snakeCase()}}.dart';
import 'package:{{objects.snakeCase()}}_storage/{{objects.snakeCase()}}_storage.dart';
import 'package:{{object.snakeCase()}}/{{object.snakeCase()}}.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:realm/realm.dart';

/// {@template {{objects.snakeCase()}}_realm_storage}
/// A persistent [{{objects.pascalCase()}}Storage] implementation using Realm.
/// {@endtemplate}
class {{objects.pascalCase()}}RealmStorage implements {{objects.pascalCase()}}Storage {
  /// {@macro {{objects.snakeCase()}}_realm_storage}
  {{objects.pascalCase()}}RealmStorage({
    required this.database,
  });

  /// The Realm database.
  @visibleForTesting
  final Realm database;

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
    await database.write(() async {
      final latest{{object.pascalCase()}}Id = database
              .query<Realm{{object.pascalCase()}}>('id != 0 SORT(id DESC) LIMIT(1)')
              .firstOrNull
              ?.id ??
          0;
      final newId = latest{{object.pascalCase()}}Id + 1;
      database.add<Realm{{object.pascalCase()}}>(new{{object.pascalCase()}}.toRealmWithId(newId));
    });
  }

  @override
  Future<void> insert({
    required {{object.pascalCase()}} {{object.camelCase()}},
  }) async {
    await database.write(() async {
      database.add<Realm{{object.pascalCase()}}>(
        {{object.camelCase()}}.toRealm(),
        update: true,
      );
    });
  }

  @override
  Future<{{object.pascalCase()}}?> getById(
    int {{object.camelCase()}}Id,
  ) async {
    final realm{{object.pascalCase()}} = database.find<Realm{{object.pascalCase()}}>({{object.camelCase()}}Id);
    return realm{{object.pascalCase()}}?.to{{object.pascalCase()}}();
  }

  @override
  Stream<List<{{object.pascalCase()}}>> watch({
    String? searchTerm,
  }) {
    final queryExpression = {{objects.pascalCase()}}Filter.matchesContent(searchTerm);
    final filtered{{objects.pascalCase()}}Query = switch (queryExpression) {
      String() => database.query<Realm{{object.pascalCase()}}>(
          '$queryExpression SORT(name ASC)',
        ),
      null => database.query<Realm{{object.pascalCase()}}>(
          // cspell:disable-next-line
          'TRUEPREDICATE SORT(name ASC)',
        ),
    };
    return filtered{{objects.pascalCase()}}Query.changes
        .asBroadcastStream()
        .map((changes) => changes.results)
        .map({{objects.camelCase()}}FromRealm{{objects.pascalCase()}})
        .distinct({{objects.camelCase()}}EqualityChecker.equals);
  }

  @override
  Stream<int> watchCount({
    String? searchTerm,
  }) {
    final queryExpression = {{objects.pascalCase()}}Filter.matchesContent(searchTerm);
    final all{{objects.pascalCase()}}Query = database.all<Realm{{object.pascalCase()}}>();
    final filtered{{objects.pascalCase()}}Query = queryExpression == null
        ? all{{objects.pascalCase()}}Query
        : all{{objects.pascalCase()}}Query.query(queryExpression);
    return filtered{{objects.pascalCase()}}Query.changes
        .map((changes) => changes.results.length)
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
    final existing{{object.pascalCase()}} =
        database.find<Realm{{object.pascalCase()}}>({{object.camelCase()}}Id);
    if (existing{{object.pascalCase()}} == null) return;
    await database.write(() async {
      database.add(
        existing{{object.pascalCase()}}.copyWithAppliedPartial(partial{{object.pascalCase()}}),
        update: true,
      );
    });
  }

  @override
  Future<{{object.pascalCase()}}?> deleteById(
    int {{object.camelCase()}}Id,
  ) async {
    final existingRealm{{object.pascalCase()}} =
        database.find<Realm{{object.pascalCase()}}>({{object.camelCase()}}Id);
    if (existingRealm{{object.pascalCase()}} == null) return null;
    final existing{{object.pascalCase()}} = existingRealm{{object.pascalCase()}}.to{{object.pascalCase()}}();
    await database.write(() async {
      database.delete<Realm{{object.pascalCase()}}>(existingRealm{{object.pascalCase()}});
    });
    return existing{{object.pascalCase()}};
  }

  @override
  Future<void> deleteAll({
    Partial{{object.pascalCase()}}? reference{{object.pascalCase()}},
  }) async {
    final queryExpression =
        {{objects.pascalCase()}}Filter.matchesPartial(reference{{object.pascalCase()}});
    if (queryExpression == null) {
      await database.write(() async {
        database.deleteAll<Realm{{object.pascalCase()}}>();
      });
      return;
    }
    await database.write(() async {
      final matching{{objects.pascalCase()}} =
          database.all<Realm{{object.pascalCase()}}>().query(queryExpression);
      database.deleteMany<Realm{{object.pascalCase()}}>(matching{{objects.pascalCase()}});
    });
  }
}
