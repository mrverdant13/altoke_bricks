import 'package:mason/mason.dart';
import 'package:value_equality_approach/value_equality_approach.dart';

void run(HookContext context) {
  context.vars = {
    ...context.vars,
    ...context.valueEqualitySelectionMap,
    'use_code_generation': context.valueEqualityUsesCodeGeneration,
    'using_hooks': true,
  };
}
