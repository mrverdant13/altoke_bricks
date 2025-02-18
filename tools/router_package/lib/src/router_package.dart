import 'package:mason/mason.dart';

/// Router package.
enum RouterPackage {
  /// Use `auto_route` for router package.
  autoRoute('`auto_route`', 'auto_route'),

  /// Use `go_router` for router package.
  goRouter('`go_router`', 'go_router');

  const RouterPackage(this.readableName, this.varIdentifier);

  factory RouterPackage.fromReadableName(String readableName) {
    return RouterPackage.values.firstWhere(
      (package) => package.readableName == readableName,
      orElse:
          () =>
              throw ArgumentError('Invalid router package name: $readableName'),
    );
  }

  /// The variable readable name.
  final String readableName;

  /// The variable identifier.
  final String varIdentifier;

  /// The variable key.
  static const varKey = 'router_package';

  /// Returns a [Map] of variables that represent the router package selection.
  static Map<String, bool> getSelectionMap(HookContext context) {
    final selectedPackage = getSelectedPackage(context);
    return {
      for (final package in RouterPackage.values)
        'use_${package.varIdentifier}': package == selectedPackage,
    };
  }

  /// Returns the selected router package.
  static RouterPackage getSelectedPackage(HookContext context) {
    final selectedPackage = context.vars[varKey]! as String;
    return RouterPackage.fromReadableName(selectedPackage);
  }
}
