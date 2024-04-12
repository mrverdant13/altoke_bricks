import 'package:mason/mason.dart';

import 'src/router.dart';

void run(HookContext context) {
  context.vars = {
    ...context.vars,
    ...RouterPackage.getSelectionMap(context),
    'using_hooks': true,
  };
}
