import 'package:data_persistence_approach/data_persistence_approach.dart';
import 'package:mason/mason.dart';

void run(HookContext context) {
  context.vars = {
    ...context.vars,
    ...DataPersistenceApproach.getSelectionMap(context),
    'using_hooks': true,
  };
}
