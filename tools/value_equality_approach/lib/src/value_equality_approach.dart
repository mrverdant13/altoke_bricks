import 'package:mason/mason.dart';

/// Value equality approach.
enum ValueEqualityApproach {
  /// Use `dart_mappable` for value equality.
  dartMappable('`dart_mappable`', 'dart_mappable'),

  /// Use `equatable` for value equality.
  equatable('`equatable`', 'equatable'),

  /// Use `freezed` for value equality.
  freezed('`freezed`', 'freezed'),

  /// Use `overrides` for value equality.
  overrides('Overrides', 'overrides'),

  /// No value equality approach.
  none('None', 'none')
  ;

  const ValueEqualityApproach(this.readableName, this.varIdentifier);

  factory ValueEqualityApproach.fromReadableName(String readableName) {
    return ValueEqualityApproach.values.firstWhere(
      (approach) => approach.readableName == readableName,
      orElse: () =>
          throw ArgumentError('Invalid value equality approach: $readableName'),
    );
  }

  /// The variable readable name.
  final String readableName;

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
    return ValueEqualityApproach.fromReadableName(selectedApproach);
  }

  /// Returns whether the value equality approach uses code generation.
  bool get usesCodeGeneration => [
    ValueEqualityApproach.dartMappable,
    ValueEqualityApproach.freezed,
  ].contains(this);

  /// Returns whether the value equality approach uses the `meta` package.
  bool get usesMeta => [
    ValueEqualityApproach.dartMappable,
    ValueEqualityApproach.overrides,
  ].contains(this);
}
