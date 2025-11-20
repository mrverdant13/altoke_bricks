import 'package:mason/mason.dart';

/// Local database alternative.
enum LocalDatabaseAlternative {
  /// Drift (SQLite).
  ///
  /// SQL database.
  drift('drift'),

  /// Hive.
  ///
  /// NoSQL database.
  hive('hive'),

  /// Sembast.
  ///
  /// NoSQL database.
  sembast('sembast')
  ;

  const LocalDatabaseAlternative(this.varIdentifier);

  factory LocalDatabaseAlternative.fromVarIdentifier(String varIdentifier) {
    return LocalDatabaseAlternative.values.firstWhere(
      (alternative) => alternative.varIdentifier == varIdentifier,
      orElse: () => throw ArgumentError(
        'Invalid local database alternative: $varIdentifier',
      ),
    );
  }

  /// The variable identifier.
  final String varIdentifier;

  /// The variable key.
  static const varKey = 'local_database_alternative';

  /// Returns a [Map] of variables that represent the local database alternative
  /// selection.
  static Map<String, bool> getSelectionMap(HookContext context) {
    final selectedAlternative = getSelectedAlternative(context);
    return {
      for (final alternative in LocalDatabaseAlternative.values)
        'use_${alternative.varIdentifier}': alternative == selectedAlternative,
    };
  }

  /// Returns the selected local database alternative.
  static LocalDatabaseAlternative getSelectedAlternative(HookContext context) {
    final selectedAlternative = context.vars[varKey]! as String;
    return LocalDatabaseAlternative.fromVarIdentifier(selectedAlternative);
  }
}
