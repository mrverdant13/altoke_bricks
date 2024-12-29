import 'package:mason/mason.dart';

void run(HookContext context) {
  context.vars = {
    ...context.vars,
    'requirements_met': true,
  };
}
