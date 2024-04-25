import 'package:common/common.dart';
import 'package:{{object.snakeCase()}}/{{object.snakeCase()}}.dart';
import 'package:isar/isar.dart';

part 'isar_{{object.snakeCase()}}.g.dart';

/// An Isar representation of an {{object.titleCase()}}.
@Collection(accessor: 'isar{{objects.pascalCase()}}')
class Isar{{object.pascalCase()}} {
  /// The ID of this {{object.lowerCase()}}.
  late Id id = Isar.autoIncrement;

  /// The name of this {{object.lowerCase()}}.
  late String name;

  /// The description of this {{object.lowerCase()}}.
  late String? description;

  /// Converts this [Isar{{object.pascalCase()}}] to an [{{object.pascalCase()}}].
  {{object.pascalCase()}} to{{object.pascalCase()}}() {
    return {{object.pascalCase()}}(
      id: id,
      name: name,
      description: description,
    );
  }

  /// Applies the [partial{{object.pascalCase()}}] to this [Isar{{object.pascalCase()}}].
  Isar{{object.pascalCase()}} copyWithAppliedPartial(
    Partial{{object.pascalCase()}} partial{{object.pascalCase()}},
  ) {
    final isar{{object.pascalCase()}} = Isar{{object.pascalCase()}}()..id = id;
    if (partial{{object.pascalCase()}}.name case Some(value: final name)) {
      isar{{object.pascalCase()}}.name = name.trim();
    }
    if (partial{{object.pascalCase()}}.description case Some(value: final description)) {
      isar{{object.pascalCase()}}.description = switch (description?.trim()) {
        null => null,
        String(:final isEmpty) when isEmpty => null,
        final description => description.trim(),
      };
    }
    return isar{{object.pascalCase()}};
  }
}

/// An extension on [{{object.pascalCase()}}] to add mapping capabilities.
extension Mappable{{object.pascalCase()}} on {{object.pascalCase()}} {
  /// Converts this [{{object.pascalCase()}}] to a [Isar{{object.pascalCase()}}].
  Isar{{object.pascalCase()}} toIsar() {
    return Isar{{object.pascalCase()}}()
      ..id = id
      ..name = name
      ..description = description;
  }
}

/// An extension on [New{{object.pascalCase()}}] to add mapping capabilities.
extension MappableNew{{object.pascalCase()}} on New{{object.pascalCase()}} {
  /// Converts this [New{{object.pascalCase()}}] to a [Isar{{object.pascalCase()}}].
  Isar{{object.pascalCase()}} toIsar() {
    return Isar{{object.pascalCase()}}()
      ..name = name
      ..description = description;
  }
}

/// An [Iterable] of [Isar{{object.pascalCase()}}]s.
typedef Isar{{objects.pascalCase()}}Iterable = Iterable<Isar{{object.pascalCase()}}>;

/// Converts an [Isar{{object.pascalCase()}}] to a [{{object.pascalCase()}}]s.
{{object.pascalCase()}} {{object.camelCase()}}FromIsar{{object.pascalCase()}}(
  Isar{{object.pascalCase()}} isar{{object.pascalCase()}},
) {
  return isar{{object.pascalCase()}}.to{{object.pascalCase()}}();
}

/// Converts an [Isar{{objects.pascalCase()}}Iterable] to a list of [{{object.pascalCase()}}]s.
List<{{object.pascalCase()}}> {{objects.camelCase()}}FromIsar{{objects.pascalCase()}}(
  Isar{{objects.pascalCase()}}Iterable isar{{objects.pascalCase()}},
) {
  return isar{{objects.pascalCase()}}.map({{object.camelCase()}}FromIsar{{object.pascalCase()}}).toList();
}
