import 'package:mason/mason.dart';

/// Data persistence approach.
enum DataPersistenceApproach {
  /// Use `drift` for data persistence.
  drift('drift'),

  /// Use `hive` for data persistence.
  hive('hive'),

  /// Use `isar` for data persistence.
  isar('isar'),

  /// Use `sembast` for data persistence.
  sembast('sembast'),
  ;

  const DataPersistenceApproach(this.varIdentifier);

  factory DataPersistenceApproach.fromVarIdentifier(String varIdentifier) {
    return DataPersistenceApproach.values.firstWhere(
      (approach) => approach.varIdentifier == varIdentifier,
      orElse: () => throw ArgumentError(
        'Invalid data persistence approach: $varIdentifier',
      ),
    );
  }

  /// The variable identifier.
  final String varIdentifier;

  /// The variable key.
  static const varKey = 'data_persistence_approach';

  /// Returns a [Map] of variables that represent the data persistence approach
  /// selection.
  static Map<String, bool> getSelectionMap(HookContext context) {
    final selectedApproach = getSelectedApproach(context);
    return {
      for (final approach in DataPersistenceApproach.values)
        'use_${approach.varIdentifier}': approach == selectedApproach,
    };
  }

  /// Returns the selected data persistence approach.
  static DataPersistenceApproach getSelectedApproach(HookContext context) {
    final selectedApproach = context.vars[varKey]! as String;
    return DataPersistenceApproach.fromVarIdentifier(selectedApproach);
  }
}
