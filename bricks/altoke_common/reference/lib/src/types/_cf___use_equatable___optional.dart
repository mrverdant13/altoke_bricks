import 'package:dart_mappable/dart_mappable.dart';
import 'package:equatable/equatable.dart';

/// {@template common.optional}
/// A representation of an optional value.
/// {@endtemplate}
sealed class EOptional<T extends Object?> extends Equatable {
  /// {@macro common.optional}
  const EOptional();

  /// Creates an [EOptional] with a present value.
  const factory EOptional.some(T value) = ESome<T>;

  /// Creates an [EOptional] with an absent value.
  const factory EOptional.none() = ENone<T>;
}

/// {@template common.some}
/// A representation of a present value.
/// {@endtemplate}
@MappableClass()
class ESome<T extends Object?> extends EOptional<T> {
  /// {@macro common.some}
  const ESome(this.value);

  /// The underlying value.
  final T value;

  @override
  List<Object?> get props => [value];
}

/// {@template common.none}
/// A representation of an absent value.
/// {@endtemplate}
@MappableClass()
class ENone<T extends Object?> extends EOptional<T> {
  /// {@macro common.none}
  const ENone();

  @override
  List<Object?> get props => [];
}
