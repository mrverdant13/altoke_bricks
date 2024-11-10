import 'package:local_database_alternative/local_database_alternative.dart';
import 'package:mason/mason.dart';

void run(HookContext context) {
  context.vars = {
    ...context.vars,
    ...LocalDatabaseAlternative.getSelectionMap(context),
    'using_hooks': true,
  };
}
