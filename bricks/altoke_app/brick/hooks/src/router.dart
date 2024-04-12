import 'package:mason/mason.dart';

enum RouterPackage {
  autoRoute('auto_route'),
  goRouter('go_router'),
  ;

  const RouterPackage(this.varIdentifier);

  final String varIdentifier;

  static const varKey = 'appRouter';

  static Map<String, bool> getSelectionMap(HookContext context) {
    final selectedApproach = RouterPackage.getSelectedApproach(context);
    return {
      for (final approach in RouterPackage.values)
        'use_${approach.varIdentifier}': approach == selectedApproach,
    };
  }

  static RouterPackage getSelectedApproach(HookContext context) {
    final selectedApproach = context.vars[varKey]! as String;
    return RouterPackage.values.firstWhere(
      (approach) => approach.varIdentifier == selectedApproach,
    );
  }
}
