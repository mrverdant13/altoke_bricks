import 'package:freezed_annotation/freezed_annotation.dart';

part '_cf___use_freezed___optional.freezed.dart';

/// {@template common.optional}
/// A representation of an optional value.
/// {@endtemplate}
@Freezed(copyWith: false)
class FOptional<T extends Object?> with _$FOptional<T> {
  /// {@macro common.optional}
  const FOptional._();

  /// Creates an [FOptional] with a present value.
  const factory FOptional.some(
    /// The underlying value.
    T value,
  ) = FSome<T>;

  /// Creates an [FOptional] with an absent value.
  const factory FOptional.none() = FNone<T>;
}
