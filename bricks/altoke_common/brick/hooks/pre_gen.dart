import 'package:mason/mason.dart';
import 'package:value_equality_approach/value_equality_approach.dart';

void run(HookContext context) {
  context.vars = {
    ...context.vars,
    ...ValueEqualityApproach.getSelectionMap(context),
    'use_code_generation':
        ValueEqualityApproach.getSelectedApproach(context).usesCodeGeneration,
    'using_hooks': true,
  };
}
