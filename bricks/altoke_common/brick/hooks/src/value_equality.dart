import 'package:mason/mason.dart';

enum ValueEqualityApproach {
  dartMappable('dart_mappable'),
  equatable('equatable'),
  freezed('freezed'),
  ;

  const ValueEqualityApproach(this.varIdentifier);

  final String varIdentifier;

  static const varKey = 'value_equality_approach';

  static Map<String, bool> getSelectionMap(HookContext context) {
    final selectedApproach = ValueEqualityApproach.getSelectedApproach(context);
    return {
      for (final approach in ValueEqualityApproach.values)
        'use_${approach.varIdentifier}': approach == selectedApproach,
    };
  }

  static ValueEqualityApproach getSelectedApproach(HookContext context) {
    final selectedApproach = context.vars[varKey]! as String;
    return ValueEqualityApproach.values.firstWhere(
      (approach) => approach.varIdentifier == selectedApproach,
    );
  }

  bool get usesCodeGeneration => [
        ValueEqualityApproach.dartMappable,
        ValueEqualityApproach.freezed,
      ].contains(this);
}
