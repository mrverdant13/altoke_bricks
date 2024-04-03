import 'package:mason/mason.dart';

import 'src/data_persistence.dart';

void run(HookContext context) {
  context.vars = {
    ...context.vars,
    ...DataPersistenceApproach.getSelectionMap(context),
    'using_hooks': true,
  };
}
