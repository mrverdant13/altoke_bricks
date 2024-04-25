import 'package:common/common.dart';
import 'package:{{objects.snakeCase()}}_isar_storage/{{objects.snakeCase()}}_isar_storage.dart';
import 'package:{{object.snakeCase()}}/{{object.snakeCase()}}.dart';
import 'package:isar/isar.dart';

/// An Isar collection of [Isar{{object.pascalCase()}}]s.
typedef Isar{{objects.pascalCase()}}Collection = IsarCollection<Isar{{object.pascalCase()}}>;

/// A query builder to be applied over [Isar{{objects.pascalCase()}}Collection].
typedef Isar{{objects.pascalCase()}}QueryBuilder
    = QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QFilterCondition>;

/// A conditioned query builder to be applied over
/// [Isar{{objects.pascalCase()}}Collection].
typedef Isar{{objects.pascalCase()}}ConditionedQueryBuilder
    = QueryBuilder<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}}, QAfterFilterCondition>;

/// An extension on [Isar{{objects.pascalCase()}}QueryBuilder] to add filtering
/// capabilities.
extension Isar{{objects.pascalCase()}}QueryFilter on Isar{{objects.pascalCase()}}QueryBuilder {
  /// A no-op query.
  Isar{{objects.pascalCase()}}ConditionedQueryBuilder noop() {
    // ignore: invalid_use_of_protected_member
    return QueryBuilder.apply<Isar{{object.pascalCase()}}, Isar{{object.pascalCase()}},
        QAfterFilterCondition>(
      this,
      (q) => q,
    );
  }

  /// A query to filter by [Isar{{object.pascalCase()}}.name] or
  /// [Isar{{object.pascalCase()}}.description] containing [content].
  Isar{{objects.pascalCase()}}ConditionedQueryBuilder contentMatches(String? content) {
    return switch (content?.trim()) {
      null => noop(),
      String(:final isEmpty) when isEmpty => noop(),
      final content => group(
          (q) => q
              .nameContains(content, caseSensitive: false)
              .or()
              .descriptionContains(content, caseSensitive: false),
        ),
    };
  }

  /// A query to filter by matching the given [partial{{object.pascalCase()}}].
  Isar{{objects.pascalCase()}}ConditionedQueryBuilder matchesPartial(
    Partial{{object.pascalCase()}}? partial{{object.pascalCase()}},
  ) {
    if (partial{{object.pascalCase()}} == null) return noop();
    final Partial{{object.pascalCase()}}(:name, :description) = partial{{object.pascalCase()}};
    var query = noop();
    switch (name) {
      case None():
        break;
      case Some(value: final nameFragment):
        switch (nameFragment.trim()) {
          case String(:final isEmpty) when isEmpty:
            break;
          case final nameFragment:
            query = query.and().nameContains(nameFragment);
        }
    }
    switch (description) {
      case None():
        break;
      case Some(value: final descriptionFragment):
        switch (descriptionFragment?.trim()) {
          case null:
            query = query.and().descriptionIsNull();
          case String(:final isEmpty) when isEmpty:
            query = query.and().descriptionIsNotNull();
          case final descriptionFragment:
            query = query
                .and()
                .descriptionIsNotNull()
                .and()
                .descriptionContains(descriptionFragment);
        }
    }
    return query;
  }
}
