import 'package:altoke_common/common.dart';
import 'package:altoke_entities_isar_storage/altoke_entities_isar_storage.dart';
import 'package:altoke_entity/altoke_entity.dart';
import 'package:isar/isar.dart';

/// An Isar collection of [IsarAltokeEntity]s.
typedef IsarAltokeEntitiesCollection = IsarCollection<IsarAltokeEntity>;

/// A query builder to be applied over [IsarAltokeEntitiesCollection].
typedef IsarAltokeEntitiesQueryBuilder
    = QueryBuilder<IsarAltokeEntity, IsarAltokeEntity, QFilterCondition>;

/// A conditioned query builder to be applied over
/// [IsarAltokeEntitiesCollection].
typedef IsarAltokeEntitiesConditionedQueryBuilder
    = QueryBuilder<IsarAltokeEntity, IsarAltokeEntity, QAfterFilterCondition>;

/// An extension on [IsarAltokeEntitiesQueryBuilder] to add filtering
/// capabilities.
extension IsarAltokeEntitiesQueryFilter on IsarAltokeEntitiesQueryBuilder {
  /// A no-op query.
  IsarAltokeEntitiesConditionedQueryBuilder noop() {
    // ignore: invalid_use_of_protected_member
    return QueryBuilder.apply<IsarAltokeEntity, IsarAltokeEntity,
        QAfterFilterCondition>(
      this,
      (q) => q,
    );
  }

  /// A query to filter by [IsarAltokeEntity.name] or
  /// [IsarAltokeEntity.description] containing [content].
  IsarAltokeEntitiesConditionedQueryBuilder contentMatches(String? content) {
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

  /// A query to filter by matching the given [partialAltokeEntity].
  IsarAltokeEntitiesConditionedQueryBuilder matchesPartial(
    PartialAltokeEntity? partialAltokeEntity,
  ) {
    if (partialAltokeEntity == null) return noop();
    final PartialAltokeEntity(:name, :description) = partialAltokeEntity;
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
