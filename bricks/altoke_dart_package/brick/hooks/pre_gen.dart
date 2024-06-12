import 'package:mason/mason.dart';

void run(HookContext context) {
  context.vars = {
    ...context.vars,
    'using_hooks': true,
  };
}
