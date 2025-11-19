import 'package:mason/mason.dart';
import 'package:state_management_package/state_management_package.dart';

/// A hook context with utilities related to state management package.
extension StateManagementPackageContext on HookContext {
  /// Returns a [Map] of variables that represent the state management package
  /// selection.
  Map<String, bool> get stateManagementPackageSelectionMap {
    return StateManagementPackage.getSelectionMap(this);
  }

  /// Returns the selected state management package.
  StateManagementPackage get selectedPackage {
    return StateManagementPackage.getSelectedPackage(this);
  }
}
