import 'package:mason/mason.dart';
import 'package:router_package/router_package.dart';

/// A hook context with utilities related to router package.
extension RouterPackageContext on HookContext {
  /// Returns a [Map] of variables that represent the router package selection.
  Map<String, bool> get routerPackageSelectionMap {
    return RouterPackage.getSelectionMap(this);
  }

  /// Returns the selected router package.
  RouterPackage get selectedPackage {
    return RouterPackage.getSelectedPackage(this);
  }
}
