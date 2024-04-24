import 'package:{{objects.snakeCase()}}_drift_storage/{{objects.snakeCase()}}.drift.dart'
    as drift;
import 'package:{{object.snakeCase()}}/{{object.snakeCase()}}.dart';

/// A Drift (SQLite) data class for {{objects.titleCase()}}.
typedef Drift{{object.pascalCase()}} = drift.{{object.pascalCase()}};

/// An extension on [Drift{{object.pascalCase()}}] to add mapping capabilities.
extension MappableDrift{{object.pascalCase()}} on Drift{{object.pascalCase()}} {
  /// Converts this [Drift{{object.pascalCase()}}] to an [{{object.pascalCase()}}].
  {{object.pascalCase()}} to{{object.pascalCase()}}() {
    return {{object.pascalCase()}}(
      id: id,
      name: name,
      description: description,
    );
  }
}

/// An [Iterable] of [Drift{{object.pascalCase()}}]s.
typedef Drift{{objects.pascalCase()}}Iterable = Iterable<Drift{{object.pascalCase()}}>;

/// Converts an [Drift{{object.pascalCase()}}] to a [{{object.pascalCase()}}]s.
{{object.pascalCase()}} {{object.camelCase()}}FromDrift{{object.pascalCase()}}(
  Drift{{object.pascalCase()}} drift{{object.pascalCase()}},
) {
  return drift{{object.pascalCase()}}.to{{object.pascalCase()}}();
}

/// Converts an [Drift{{objects.pascalCase()}}Iterable] to a list of [{{object.pascalCase()}}]s.
List<{{object.pascalCase()}}> {{objects.camelCase()}}FromDrift{{objects.pascalCase()}}(
  Drift{{objects.pascalCase()}}Iterable drift{{objects.pascalCase()}},
) {
  return drift{{objects.pascalCase()}}.map({{object.camelCase()}}FromDrift{{object.pascalCase()}}).toList();
}
