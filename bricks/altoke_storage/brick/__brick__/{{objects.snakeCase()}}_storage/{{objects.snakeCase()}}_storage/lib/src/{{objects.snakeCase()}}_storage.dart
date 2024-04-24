import 'package:{{objects.snakeCase()}}_storage/{{objects.snakeCase()}}_storage.dart';
import 'package:{{object.snakeCase()}}/{{object.snakeCase()}}.dart';

/// {@template {{objects.snakeCase()}}_storage}
/// An interface for a persistent storage of {{objects.titleCase()}}.
/// {@endtemplate}
abstract interface class {{objects.pascalCase()}}Storage {
  /// Creates a new {{object.lowerCase()}}.
  ///
  /// Throws a [Create{{object.pascalCase()}}Failure] if the {{object.lowerCase()}} fails to be
  /// created.
  Future<void> create({
    required New{{object.pascalCase()}} new{{object.pascalCase()}},
  });

  /// Inserts an {{object.lowerCase()}}.
  Future<void> insert({
    required {{object.pascalCase()}} {{object.camelCase()}},
  });

  /// Retrieves an {{object.lowerCase()}} by its ID.
  Future<{{object.pascalCase()}}?> getById(
    int {{object.camelCase()}}Id,
  );

  /// Returns a stream of the {{objects.lowerCase()}} that match the given [searchTerm].
  Stream<Iterable<{{object.pascalCase()}}>> watch({
    String? searchTerm,
  });

  /// Returns the number of {{objects.lowerCase()}} that match the given
  /// [searchTerm].
  Stream<int> watchCount({
    String? searchTerm,
  });

  /// Updates an {{object.lowerCase()}} identified by its [{{object.camelCase()}}Id] with the given
  /// [partial{{object.pascalCase()}}].
  ///
  /// Throws an [Update{{object.pascalCase()}}Failure] if the {{object.lowerCase()}} fails to be
  /// updated.
  Future<void> update({
    required int {{object.camelCase()}}Id,
    required Partial{{object.pascalCase()}} partial{{object.pascalCase()}},
  });

  /// Deletes an {{object.lowerCase()}} identified by its [{{object.camelCase()}}Id].
  Future<{{object.pascalCase()}}?> deleteById(
    int {{object.camelCase()}}Id,
  );

  /// Deletes all {{objects.lowerCase()}} that match the given [reference{{object.pascalCase()}}].
  Future<void> deleteAll({
    Partial{{object.pascalCase()}}? reference{{object.pascalCase()}},
  });
}
