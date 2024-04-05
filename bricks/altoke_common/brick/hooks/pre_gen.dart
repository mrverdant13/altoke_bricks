import 'package:mason/mason.dart';

import 'src/value_equality.dart';

void run(HookContext context) {
  context.vars = {
    ...context.vars,
    ...ValueEqualityApproach.getSelectionMap(context),
    'use_code_generation':
        ValueEqualityApproach.getSelectedApproach(context).usesCodeGeneration,
    'using_hooks': true,
  };
}
