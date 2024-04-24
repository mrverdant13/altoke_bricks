import 'package:altoke_common/common.dart';
import 'package:{{object.snakeCase()}}/{{object.snakeCase()}}.dart';
import 'package:realm/realm.dart';

part 'realm_{{object.snakeCase()}}.realm.dart';

/// Realm schema for {{objects.titleCase()}}.
// ignore: non_constant_identifier_names
final Realm{{object.pascalCase()}}Schema = Realm{{object.pascalCase()}}.schema;

/// A Realm representation of an {{object.titleCase()}}.
@RealmModel()
class _Realm{{object.pascalCase()}} {
  /// The ID of this {{object.lowerCase()}}.
  @PrimaryKey()
  late int id;

  /// The name of this {{object.lowerCase()}}.
  late String name;

  /// The description of this {{object.lowerCase()}}.
  late String? description;

  /// Converts this [Realm{{object.pascalCase()}}] to an [{{object.pascalCase()}}].
  {{object.pascalCase()}} to{{object.pascalCase()}}() {
    return {{object.pascalCase()}}(
      id: id,
      name: name,
      description: description,
    );
  }

  /// Applies the [partial{{object.pascalCase()}}] to this [Realm{{object.pascalCase()}}].
  Realm{{object.pascalCase()}} copyWithAppliedPartial(
    Partial{{object.pascalCase()}} partial{{object.pascalCase()}},
  ) {
    final realm{{object.pascalCase()}} = Realm{{object.pascalCase()}}(
      id,
      name,
      description: description,
    );
    if (partial{{object.pascalCase()}}.name case Some(value: final name)) {
      realm{{object.pascalCase()}}.name = name.trim();
    }
    if (partial{{object.pascalCase()}}.description case Some(value: final description)) {
      realm{{object.pascalCase()}}.description = switch (description?.trim()) {
        null => null,
        String(:final isEmpty) when isEmpty => null,
        final description => description.trim(),
      };
    }
    return realm{{object.pascalCase()}};
  }
}

/// An extension on [{{object.pascalCase()}}] to add mapping capabilities.
extension Mappable{{object.pascalCase()}} on {{object.pascalCase()}} {
  /// Converts this [{{object.pascalCase()}}] to a [Realm{{object.pascalCase()}}].
  Realm{{object.pascalCase()}} toRealm() {
    return Realm{{object.pascalCase()}}(
      id,
      name,
      description: description,
    );
  }
}

/// An extension on [New{{object.pascalCase()}}] to add mapping capabilities.
extension MappableNew{{object.pascalCase()}} on New{{object.pascalCase()}} {
  /// Converts this [New{{object.pascalCase()}}] to a [Realm{{object.pascalCase()}}].
  Realm{{object.pascalCase()}} toRealmWithId(int id) {
    return Realm{{object.pascalCase()}}(
      id,
      name,
      description: description,
    );
  }
}

/// An [Iterable] of [Realm{{object.pascalCase()}}]s.
typedef Realm{{objects.pascalCase()}}Iterable = Iterable<Realm{{object.pascalCase()}}>;

/// Converts a list of [Realm{{object.pascalCase()}}]s to a list of [{{object.pascalCase()}}]s.
List<{{object.pascalCase()}}> {{objects.camelCase()}}FromRealm{{objects.pascalCase()}}(
  Realm{{objects.pascalCase()}}Iterable realm{{objects.pascalCase()}},
) {
  return [
    for (final realm{{object.pascalCase()}} in realm{{objects.pascalCase()}})
      realm{{object.pascalCase()}}.to{{object.pascalCase()}}(),
  ];
}
