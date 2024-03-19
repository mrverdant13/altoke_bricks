import 'package:common/common.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '_cf___use_freezed___altoke_entity.freezed.dart';

/// {@template altoke_entity.altoke_entity}
/// Altoke entity.
/// {@endtemplate}
@freezed
class FAltokeEntity with _$FAltokeEntity {
  /// {@macro altoke_entity.altoke_entity}
  const factory FAltokeEntity({
    /// The ID of this altoke entity.
    required int id,

    /// The name of this altoke entity.
    required String name,

    /// The description of this altoke entity.
    required String description,
  }) = _FAltokeEntity;
}

/// {@template altoke_entity.new_altoke_entity}
/// A new altoke entity.
/// {@endtemplate}
@freezed
class FNewAltokeEntity with _$FNewAltokeEntity {
  /// {@macro altoke_entity.new_altoke_entity}
  const factory FNewAltokeEntity({
    /// The name of the new altoke entity.
    required String title,

    /// The description of the new altoke entity.
    required String description,
  }) = _FNewAltokeEntity;
}

/// {@template altoke_entity.partial_altoke_entity}
/// A partial altoke entity.
/// {@endtemplate}
@freezed
class FPartialAltokeEntity with _$FPartialAltokeEntity {
  /// {@macro altoke_entity.partial_altoke_entity}
  const factory FPartialAltokeEntity({
    /// The optional name for the altoke entity.
    @Default(FOptional<String>.none()) FOptional<String> name,

    /// The optional description for the altoke entity.
    @Default(FOptional<String>.none()) FOptional<String> description,
  }) = _FPartialAltokeEntity;
}
