import 'dart:io';

import 'package:collection/collection.dart';
import 'package:mason/mason.dart';

enum Router {
  autoRoute('auto_route', 'auto_route'),
  goRouter('go_router', 'go_router'),
  ;

  const Router(this.label, this.varIdentifier);

  final String label;
  final String varIdentifier;

  static Router select({
    required HookContext context,
  }) {
    final logger = context.logger;
    final candidateVarIdentifier =
        Platform.environment['ALTOKE_PROJECT_ROUTER'];
    final candidate = Router.values.firstWhereOrNull(
      (router) => router.varIdentifier == candidateVarIdentifier?.trim(),
    );
    final selectedRouter = candidate ??
        logger.chooseOne<Router>(
          'Which router do you want to use?',
          choices: Router.values,
          display: (router) => router.label,
        );
    for (final router in Router.values) {
      context.vars['use_${router.varIdentifier}_router'] =
          router == selectedRouter;
    }
    return selectedRouter;
  }
}
