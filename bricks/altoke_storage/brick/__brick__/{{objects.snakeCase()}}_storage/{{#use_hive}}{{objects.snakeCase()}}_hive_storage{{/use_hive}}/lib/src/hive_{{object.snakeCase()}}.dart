import 'package:altoke_common/common.dart';
import 'package:{{object.snakeCase()}}/{{object.snakeCase()}}.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hive_{{object.snakeCase()}}.g.dart';

/// {@template {{objects.snakeCase()}}_hive_storage.hive_{{object.snakeCase()}}}
/// A Hive representation of an {{object.titleCase()}}.
/// {@endtemplate}
@JsonSerializable()
class Hive{{object.pascalCase()}} {
  /// {@macro {{objects.snakeCase()}}_hive_storage.hive_{{object.snakeCase()}}}
  const Hive{{object.pascalCase()}}({
    required this.name,
    this.description,
  });

  /// Creates a [Hive{{object.pascalCase()}}] from its JSON representation.
  factory Hive{{object.pascalCase()}}.fromJson(Map<dynamic, dynamic> json) =>
      _$Hive{{object.pascalCase()}}FromJson(json);

  /// JSON key for the name of a Hive {{object.titleCase()}}.
  static const nameJsonKey = 'name';

  /// JSON key for the description of a Hive {{object.titleCase()}}.
  static const descriptionJsonKey = 'description';

  /// The name of this {{object.lowerCase()}}.
  @JsonKey(name: Hive{{object.pascalCase()}}.nameJsonKey)
  final String name;

  /// The description of this {{object.lowerCase()}}.
  @JsonKey(name: Hive{{object.pascalCase()}}.descriptionJsonKey)
  final String? description;

  /// Converts this [Hive{{object.pascalCase()}}] to its JSON representation.
  Json toJson() => _$Hive{{object.pascalCase()}}ToJson(this);

  /// Converts this [Hive{{object.pascalCase()}}] to a [{{object.pascalCase()}}].
  {{object.pascalCase()}} to{{object.pascalCase()}}WithId(int id) {
    return {{object.pascalCase()}}(
      id: id,
      name: name,
      description: description,
    );
  }

  /// Applies the [partial{{object.pascalCase()}}] to this [Hive{{object.pascalCase()}}].
  Hive{{object.pascalCase()}} copyWithAppliedPartial(
    Partial{{object.pascalCase()}} partial{{object.pascalCase()}},
  ) {
    var hive{{object.pascalCase()}} = this;
    if (partial{{object.pascalCase()}}.name case Some(value: final name)) {
      hive{{object.pascalCase()}} = Hive{{object.pascalCase()}}(
        name: name.trim(),
        description: hive{{object.pascalCase()}}.description,
      );
    }
    if (partial{{object.pascalCase()}}.description case Some(value: final description)) {
      hive{{object.pascalCase()}} = Hive{{object.pascalCase()}}(
        name: hive{{object.pascalCase()}}.name,
        description: switch (description?.trim()) {
          null => null,
          String(:final isEmpty) when isEmpty => null,
          final description => description.trim(),
        },
      );
    }
    return hive{{object.pascalCase()}};
  }
}

/// An extension on [{{object.pascalCase()}}] to add mapping capabilities.
extension Mappable{{object.pascalCase()}} on {{object.pascalCase()}} {
  /// Converts this [{{object.pascalCase()}}] to a [Hive{{object.pascalCase()}}].
  ///
  /// **NOTE:** The [id] is ignored in the conversion.
  Hive{{object.pascalCase()}} toHive() {
    return Hive{{object.pascalCase()}}(
      name: name,
      description: description,
    );
  }

  /// Converts this [{{object.pascalCase()}}] to its Hive JSON representation.
  ///
  /// **NOTE:** The [id] is ignored in the conversion.
  Json toHiveJson() {
    return toHive().toJson();
  }
}

/// An extension on [New{{object.pascalCase()}}] to add mapping capabilities.
extension MappableNew{{object.pascalCase()}} on New{{object.pascalCase()}} {
  /// Converts this [New{{object.pascalCase()}}] to a [Hive{{object.pascalCase()}}].
  Hive{{object.pascalCase()}} toHive() {
    return Hive{{object.pascalCase()}}(
      name: name,
      description: description,
    );
  }

  /// Converts this [New{{object.pascalCase()}}] to its Hive JSON representation.
  Json toHiveJson() {
    return toHive().toJson();
  }
}

/// An {{object.lowerCase()}} entry.
typedef {{object.pascalCase()}}Entry = MapEntry<dynamic, Map<dynamic, dynamic>>;

/// An extension on [{{object.pascalCase()}}Entry] to add mapping capabilities.
extension Extended{{object.pascalCase()}}Entry on {{object.pascalCase()}}Entry {
  /// Converts this [{{object.pascalCase()}}Entry] to a [{{object.pascalCase()}}].
  {{object.pascalCase()}} to{{object.pascalCase()}}() {
    return Hive{{object.pascalCase()}}.fromJson(value).to{{object.pascalCase()}}WithId(key as int);
  }
}
