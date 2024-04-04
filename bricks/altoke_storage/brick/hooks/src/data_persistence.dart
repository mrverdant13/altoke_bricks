import 'package:mason/mason.dart';

enum DataPersistenceApproach {
  hive('hive'),
  isar('isar'),
  realm('realm'),
  sembast('sembast'),
  drift('drift'),
  ;

  const DataPersistenceApproach(this.varIdentifier);

  final String varIdentifier;

  static const varKey = 'data_persistence_approach';

  static Map<String, bool> getSelectionMap(HookContext context) {
    final selectedApproach = getSelectedApproach(context);
    return {
      for (final approach in DataPersistenceApproach.values)
        'use_${approach.varIdentifier}': approach == selectedApproach,
    };
  }

  static DataPersistenceApproach getSelectedApproach(HookContext context) {
    final selectedApproach = context.vars[varKey]! as String;
    return DataPersistenceApproach.values.firstWhere(
      (approach) => approach.varIdentifier == selectedApproach,
    );
  }

  String get codeGenerationCommand => switch (this) {
        DataPersistenceApproach.realm =>
          'dart run realm install && dart run realm generate',
        _ => 'dart run build_runner build --delete-conflicting-outputs',
      };
}
