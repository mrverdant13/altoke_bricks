import 'package:mason/mason.dart';
import 'package:router_package/router_package.dart';
import 'package:state_management_package/state_management_package.dart';

import 'lib/src/android_application_identifier.dart';
import 'lib/src/apple_bundle_identifier.dart';

void run(HookContext context) {
  context.vars.addAll(context.routerPackageSelectionMap);
  context.vars.addAll(context.stateManagementPackageSelectionMap);
  switch (context.vars['android_application_identifier']) {
    case null:
      context.vars.addAll({'include_android_platform': false});
    case final String rawAndroidApplicationIdentifier:
      final androidApplicationIdentifier = AndroidApplicationIdentifier(
        rawAndroidApplicationIdentifier,
      );
      context.vars.addAll({
        'include_android_platform': true,
        'android_application_identifier_as_path': androidApplicationIdentifier
            .rawSegments
            .join('/'),
      });
  }
  switch (context.vars['ios_bundle_identifier']) {
    case null:
      context.vars.addAll({'include_ios_platform': false});
    case final String rawIosBundleIdentifier:
      AppleBundleIdentifier(rawIosBundleIdentifier);
      context.vars.addAll({'include_ios_platform': true});
  }
  switch (context.vars['macos_bundle_identifier']) {
    case null:
      context.vars.addAll({'include_macos_platform': false});
    case final String rawMacosBundleIdentifier:
      AppleBundleIdentifier(rawMacosBundleIdentifier);
      context.vars.addAll({'include_macos_platform': true});
  }
  context.vars.addAll({'requirements_met': true});
}
