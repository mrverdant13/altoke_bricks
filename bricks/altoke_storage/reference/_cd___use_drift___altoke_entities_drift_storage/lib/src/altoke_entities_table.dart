import 'package:altoke_common/common.dart';
import 'package:altoke_entities_drift_storage/altoke_entities.drift.dart'
    as drift;
import 'package:altoke_entity/altoke_entity.dart';
import 'package:drift/drift.dart';

/// A Drift (SQLite) table for Altoke Entities.
typedef DriftAltokeEntitiesTable = drift.AltokeEntities;

/// An extension on [DriftAltokeEntitiesTable] to add filtering capabilities.
extension DriftAltokeEntitiesFilter on DriftAltokeEntitiesTable {
  /// A filter to match the given [content] against the
  /// [drift.AltokeEntity.name] and [drift.AltokeEntity.description].
  Expression<bool> contentMatches(String? content) {
    return switch (content?.trim()) {
      null => const Constant(true),
      String(:final isEmpty) when isEmpty => const Constant(true),
      final content => name.contains(content) | description.contains(content),
    };
  }

  /// A filter to match the given [partialAltokeEntity].
  Expression<bool> matchesPartial(PartialAltokeEntity partialAltokeEntity) {
    final PartialAltokeEntity(:name, :description) = partialAltokeEntity;
    return Expression.and({
      switch (name) {
        None() => const Constant(true),
        Some(value: final nameFragment) => switch (nameFragment.trim()) {
            String(:final isEmpty) when isEmpty => const Constant(true),
            final nameFragment => this.name.contains(nameFragment),
          },
      },
      switch (description) {
        None() => const Constant(true),
        Some(value: final descriptionFragment) => switch (
              descriptionFragment?.trim()) {
            null => this.description.isNull(),
            String(:final isEmpty) when isEmpty => this.description.isNotNull(),
            final descriptionFragment =>
              this.description.contains(descriptionFragment),
          },
      },
    });
  }
}
