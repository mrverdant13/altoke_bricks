import 'package:dart_mappable/dart_mappable.dart';

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
class DmSome<T extends Object?> extends DmOptional<T> with DmSomeMappable<T> {
  /// {@macro common.some}
  const DmSome(this.value);

  /// The underlying value.
  final T value;
}

/// {@template common.none}
/// A representation of an absent value.
/// {@endtemplate}
@MappableClass()
class DmNone<T extends Object?> extends DmOptional<T> with DmNoneMappable<T> {
  /// {@macro common.none}
  const DmNone();
}
