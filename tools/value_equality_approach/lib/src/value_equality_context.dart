import 'package:mason/mason.dart';
import 'package:value_equality_approach/value_equality_approach.dart';

/// A hook context with utilities related to value equality.
extension ValueEqualityContext on HookContext {
  /// Returns a [Map] of variables that represent the value equality approach
  /// selection.
  Map<String, bool> get valueEqualitySelectionMap {
    return ValueEqualityApproach.getSelectionMap(this);
  }

  /// Returns the selected value equality approach.
  ValueEqualityApproach get selectedApproach {
    return ValueEqualityApproach.getSelectedApproach(this);
  }

  /// Returns whether the value equality approach uses code generation.
  bool get valueEqualityUsesCodeGeneration {
    return selectedApproach.usesCodeGeneration;
  }
}
