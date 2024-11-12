import 'package:dart_mappable/dart_mappable.dart';
import 'package:meta/meta.dart';

part '_cf___use_dart_mappable___optional.mapper.dart';

/// {@template common.optional}
/// A representation of an optional value.
/// {@endtemplate}
@MappableClass()
sealed class DmOptional<T extends Object?> with DmOptionalMappable<T> {
  /// {@macro common.optional}
  const DmOptional();

  /// Creates an [DmOptional] with a present value.
  const factory DmOptional.some(T value) = DmSome<T>;

  /// Creates an [DmOptional] with an absent value.
  const factory DmOptional.none() = DmNone<T>;
}

/// {@template common.some}
/// A representation of a present value.
/// {@endtemplate}
@MappableClass()
@immutable
class DmSome<T extends Object?> extends DmOptional<T> with DmSomeMappable<T> {
  /// {@macro common.some}
  const DmSome(this.value);

  /// The underlying value.
  final T value;

  // HACK: Manual override required to avoid edge cases.
  @override
  bool operator ==(Object other) {
    if (other is! DmSome<T>) return false;
    if (identical(this, other)) return true;
    return other.value == value;
  }

  // HACK: Manual override required to avoid edge cases.
  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}

/// {@template common.none}
/// A representation of an absent value.
/// {@endtemplate}
@MappableClass()
@immutable
class DmNone<T extends Object?> extends DmOptional<T> with DmNoneMappable<T> {
  /// {@macro common.none}
  const DmNone();

  // HACK: Manual override required to avoid edge cases.
  @override
  bool operator ==(Object other) {
    if (other is! DmNone<T>) return false;
    return identical(this, other);
  }

  // HACK: Manual override required to avoid edge cases.
  @override
  int get hashCode => runtimeType.hashCode;
}
