import 'package:mason/mason.dart';

/// Value equality approach.
enum ValueEqualityApproach {
  /// Use `dart_mappable` for value equality.
  dartMappable('dart_mappable'),

  /// Use `equatable` for value equality.
  equatable('equatable'),

  /// Use `freezed` for value equality.
  freezed('freezed'),

  /// Use `overrides` for value equality.
  overrides('overrides'),
  ;

  const ValueEqualityApproach(this.varIdentifier);

  /// The variable identifier.
  final String varIdentifier;

  /// The variable key.
  static const varKey = 'value_equality_approach';

  /// Returns a [Map] of variables that represent the value equality approach
  /// selection.
  static Map<String, bool> getSelectionMap(HookContext context) {
    final selectedApproach = getSelectedApproach(context);
    return {
      for (final approach in ValueEqualityApproach.values)
        'use_${approach.varIdentifier}': approach == selectedApproach,
    };
  }

  /// Returns the selected value equality approach.
  static ValueEqualityApproach getSelectedApproach(HookContext context) {
    final selectedApproach = context.vars[varKey]! as String;
    return ValueEqualityApproach.values.firstWhere(
      (approach) => approach.varIdentifier == selectedApproach,
    );
  }

  /// Returns whether the value equality approach uses code generation.
  bool get usesCodeGeneration => [
        ValueEqualityApproach.dartMappable,
        ValueEqualityApproach.freezed,
      ].contains(this);
}
