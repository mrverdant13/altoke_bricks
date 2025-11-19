import 'package:mason/mason.dart';

/// State management package.
enum StateManagementPackage {
  /// Use `bloc` for state management package.
  bloc('`bloc`', 'bloc'),

  /// Use `riverpod` for state management package.
  riverpod('`riverpod`', 'riverpod');

  const StateManagementPackage(this.readableName, this.varIdentifier);

  factory StateManagementPackage.fromReadableName(String readableName) {
    return StateManagementPackage.values.firstWhere(
      (package) => package.readableName == readableName,
      orElse: () => throw ArgumentError(
        'Invalid state management package name: $readableName',
      ),
    );
  }

  /// The variable readable name.
  final String readableName;

  /// The variable identifier.
  final String varIdentifier;

  /// The variable key.
  static const varKey = 'state_management_package';

  /// Returns a [Map] of variables that represent the state management package
  /// selection.
  static Map<String, bool> getSelectionMap(HookContext context) {
    final selectedPackage = getSelectedPackage(context);
    return {
      for (final package in StateManagementPackage.values)
        'use_${package.varIdentifier}': package == selectedPackage,
    };
  }

  /// Returns the selected state management package.
  static StateManagementPackage getSelectedPackage(HookContext context) {
    final selectedPackage = context.vars[varKey]! as String;
    return StateManagementPackage.fromReadableName(selectedPackage);
  }
}
