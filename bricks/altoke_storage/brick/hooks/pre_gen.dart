import 'package:data_persistence_approach/data_persistence_approach.dart';
import 'package:mason/mason.dart';

void run(HookContext context) {
  final selectedDataPersistenceApproach =
      DataPersistenceApproach.getSelectedApproach(context);
  if (selectedDataPersistenceApproach == DataPersistenceApproach.realm) {
    throw UnsupportedError('Realm is not supported anymore');
  }
  context.vars = {
    ...context.vars,
    ...DataPersistenceApproach.getSelectionMap(context),
    'using_hooks': true,
  };
}
