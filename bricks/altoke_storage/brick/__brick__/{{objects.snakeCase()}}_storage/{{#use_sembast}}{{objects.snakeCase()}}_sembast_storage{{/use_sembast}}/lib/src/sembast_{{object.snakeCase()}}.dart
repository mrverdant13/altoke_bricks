import 'package:altoke_common/common.dart';
import 'package:{{object.snakeCase()}}/{{object.snakeCase()}}.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sembast/sembast.dart';

part 'sembast_{{object.snakeCase()}}.g.dart';

/// {@template {{objects.snakeCase()}}_sembast_storage.sembast_{{object.snakeCase()}}}
/// A Sembast representation of an {{object.titleCase()}}.
/// {@endtemplate}
@JsonSerializable()
class Sembast{{object.pascalCase()}} {
  /// {@macro {{objects.snakeCase()}}_sembast_storage.sembast_{{object.snakeCase()}}}
  const Sembast{{object.pascalCase()}}({
    required this.name,
    this.description,
  });

  /// Creates a [Sembast{{object.pascalCase()}}] from its JSON representation.
  factory Sembast{{object.pascalCase()}}.fromJson(Map<dynamic, dynamic> json) =>
      _$Sembast{{object.pascalCase()}}FromJson(json);

  /// JSON key for the name of a Sembast {{object.titleCase()}}.
  static const nameJsonKey = 'name';

  /// JSON key for the description of a Sembast {{object.titleCase()}}.
  static const descriptionJsonKey = 'description';

  /// The name of this {{object.lowerCase()}}.
  @JsonKey(name: Sembast{{object.pascalCase()}}.nameJsonKey)
  final String name;

  /// The description of this {{object.lowerCase()}}.
  @JsonKey(name: Sembast{{object.pascalCase()}}.descriptionJsonKey)
  final String? description;

  /// Converts this [Sembast{{object.pascalCase()}}] to its JSON representation.
  Json toJson() => _$Sembast{{object.pascalCase()}}ToJson(this);

  /// Converts this [Sembast{{object.pascalCase()}}] to a [{{object.pascalCase()}}].
  {{object.pascalCase()}} to{{object.pascalCase()}}WithId(int id) {
    return {{object.pascalCase()}}(
      id: id,
      name: name,
      description: description,
    );
  }
}

/// An extension on [{{object.pascalCase()}}] to add mapping capabilities.
extension Mappable{{object.pascalCase()}} on {{object.pascalCase()}} {
  /// Converts this [{{object.pascalCase()}}] to a [Sembast{{object.pascalCase()}}].
  ///
  /// **NOTE:** The [id] is ignored in the conversion.
  Sembast{{object.pascalCase()}} toSembast() {
    return Sembast{{object.pascalCase()}}(
      name: name,
      description: description,
    );
  }

  /// Converts this [{{object.pascalCase()}}] to its Sembast JSON representation.
  ///
  /// **NOTE:** The [id] is ignored in the conversion.
  Json toSembastJson() {
    return toSembast().toJson();
  }
}

/// An extension on [New{{object.pascalCase()}}] to add mapping capabilities.
extension MappableNew{{object.pascalCase()}} on New{{object.pascalCase()}} {
  /// Converts this [New{{object.pascalCase()}}] to a [Sembast{{object.pascalCase()}}].
  Sembast{{object.pascalCase()}} toSembast() {
    return Sembast{{object.pascalCase()}}(
      name: name,
      description: description,
    );
  }

  /// Converts this [New{{object.pascalCase()}}] to its Sembast JSON representation.
  Json toSembastJson() {
    return toSembast().toJson();
  }
}

/// An extension on [Partial{{object.pascalCase()}}] to add mapping capabilities.
extension MappablePartial{{object.pascalCase()}} on Partial{{object.pascalCase()}} {
  /// Converts this [Partial{{object.pascalCase()}}] to a [SembastPartial{{object.pascalCase()}}].
  SembastPartial{{object.pascalCase()}} toSembast() =>
      SembastPartial{{object.pascalCase()}}.fromEntity(this);

  /// Converts this [Partial{{object.pascalCase()}}] to its Sembast JSON representation.
  Json toSembastJson() => toSembast().toJson();
}

/// {@template {{objects.snakeCase()}}_sembast_storage.sembast_partial_{{object.snakeCase()}}}
/// A Sembast representation of a partial {{object.titleCase()}}.
/// {@endtemplate}
class SembastPartial{{object.pascalCase()}} {
  /// {@macro {{objects.snakeCase()}}_sembast_storage.sembast_partial_{{object.snakeCase()}}}
  const SembastPartial{{object.pascalCase()}}({
    this.name = const Optional.none(),
    this.description = const Optional.none(),
  });

  /// Creates a [SembastPartial{{object.pascalCase()}}] from a [Partial{{object.pascalCase()}}].
  factory SembastPartial{{object.pascalCase()}}.fromEntity(
    Partial{{object.pascalCase()}} partial{{object.pascalCase()}},
  ) {
    return SembastPartial{{object.pascalCase()}}(
      name: partial{{object.pascalCase()}}.name,
      description: partial{{object.pascalCase()}}.description,
    );
  }

  /// The name for the {{object.lowerCase()}}.
  final Optional<String> name;

  /// The description for the {{object.lowerCase()}}.
  final Optional<String?> description;

  /// Converts this [SembastPartial{{object.pascalCase()}}] to its JSON representation.
  Json toJson() {
    return {
      if (name case Some(:final value)) Sembast{{object.pascalCase()}}.nameJsonKey: value,
      if (description case Some(:final value))
        Sembast{{object.pascalCase()}}.descriptionJsonKey: value,
    };
  }
}

/// A snapshot that represents an {{object.lowerCase()}}.
typedef {{object.pascalCase()}}Snapshot = RecordSnapshot<int, Json>;

/// An extension on [{{object.pascalCase()}}Snapshot] to add mapping capabilities.
extension Extended{{object.pascalCase()}}Snapshot on {{object.pascalCase()}}Snapshot {
  /// Converts this [{{object.pascalCase()}}Snapshot] to a [{{object.pascalCase()}}].
  {{object.pascalCase()}} to{{object.pascalCase()}}() {
    return Sembast{{object.pascalCase()}}.fromJson(value).to{{object.pascalCase()}}WithId(key);
  }
}

/// An [Iterable] of [{{object.pascalCase()}}Snapshot]s.
typedef Sembast{{object.pascalCase()}}SnapshotsIterable = Iterable<{{object.pascalCase()}}Snapshot>;

/// Converts an [{{object.pascalCase()}}Snapshot] to a [{{object.pascalCase()}}]s.
{{object.pascalCase()}} {{object.camelCase()}}FromSembast{{object.pascalCase()}}(
  {{object.pascalCase()}}Snapshot {{object.camelCase()}}Snapshot,
) {
  return {{object.camelCase()}}Snapshot.to{{object.pascalCase()}}();
}

/// Converts an [Sembast{{object.pascalCase()}}SnapshotsIterable] to a list of
/// [{{object.pascalCase()}}]s.
List<{{object.pascalCase()}}> {{objects.camelCase()}}From{{objects.pascalCase()}}Snapshots(
  Sembast{{object.pascalCase()}}SnapshotsIterable sembast{{objects.pascalCase()}},
) {
  return sembast{{objects.pascalCase()}}
      .map({{object.camelCase()}}FromSembast{{object.pascalCase()}})
      .toList();
}
