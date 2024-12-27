import 'package:meta/meta.dart';

/// {@template common.optional}
/// A representation of an optional value.
/// {@endtemplate}
@immutable
sealed class Optional<T extends Object?> {
  /// {@macro common.optional}
  const Optional();

  /// Creates an [Optional] with a present value.
  const factory Optional.some(T value) = Some<T>;

  /// Creates an [Optional] with an absent value.
  const factory Optional.none() = None<T>;
}

/// {@template common.some}
/// A representation of a present value.
/// {@endtemplate}
@immutable
class Some<T extends Object?> extends Optional<T> {
  /// {@macro common.some}
  const Some(
    this.value,
  );

  /// The underlying value.
  final T value;

  @override
  String toString() => 'Some<$T>(value: $value)';

  @override
  bool operator ==(covariant Optional<T> other) {
    if (other is! Some<T>) return false;
    if (identical(this, other)) return true;
    return other.value == value;
  }

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}

/// {@template common.none}
/// A representation of an absent value.
/// {@endtemplate}
@immutable
class None<T extends Object?> extends Optional<T> {
  /// {@macro common.none}
  const None();

  @override
  String toString() => 'None<$T>()';

  @override
  bool operator ==(covariant Optional<T> other) {
    if (other is! None<T>) return false;
    return identical(this, other);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}
