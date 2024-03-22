// ignore_for_file: public_member_api_docs

part of 'altoke_objects_storage.dart';

class NewAltokeObject {
  const NewAltokeObject({
    required this.name,
    this.description,
  });

  final String name;
  final String? description;
}

class AltokeObject {
  const AltokeObject({
    required this.id,
    required this.name,
    this.description,
  });

  final int id;
  final String name;
  final String? description;
}

class PartialAltokeObject {
  const PartialAltokeObject({
    this.name = const Optional.none(),
    this.description = const Optional.none(),
  });

  final Optional<String> name;
  final Optional<String?> description;
}

sealed class Optional<T extends Object?> {
  const Optional();
  const factory Optional.some(T value) = DmSome<T>;
  const factory Optional.none() = DmNone<T>;
}

class DmSome<T extends Object?> extends Optional<T> {
  const DmSome(this.value);
  final T value;
}

class DmNone<T extends Object?> extends Optional<T> {
  const DmNone();
}
