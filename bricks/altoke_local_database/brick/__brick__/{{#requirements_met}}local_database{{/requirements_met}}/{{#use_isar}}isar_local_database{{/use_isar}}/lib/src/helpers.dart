import 'package:isar/isar.dart';

/// A query builder for an unfiltered condition.
typedef UnfilteredQueryBuilderCondition<OBJ, R> =
    QueryBuilder<OBJ, R, QFilterCondition>;

/// A query builder for a filtered condition.
typedef FilteredQueryBuilderCondition<OBJ, R> =
    QueryBuilder<OBJ, R, QAfterFilterCondition>;

/// An extension to include additional behavior to an unfiltered query builder.
extension ExtendedUnfilteredQueryBuilderCondition<OBJ, R>
    on UnfilteredQueryBuilderCondition<OBJ, R> {
  /// A no-op query builder.
  FilteredQueryBuilderCondition<OBJ, R> noop() {
    // Using a query builder that returns the same query without any changes.
    // ignore: invalid_use_of_protected_member
    return QueryBuilder.apply<OBJ, R, QAfterFilterCondition>(this, (q) => q);
  }
}
