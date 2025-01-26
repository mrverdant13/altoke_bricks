import 'package:mason/mason.dart';
import 'package:router_package/router_package.dart';

import 'lib/src/android_application_identifier.dart';
import 'lib/src/ios_bundle_identifier.dart';

void run(HookContext context) {
  context.vars.addAll(context.routerPackageSelectionMap);
  switch (context.vars['android_application_identifier']) {
    case null:
      context.vars.addAll({
        'include_android_platform': false,
      });
    case final String rawAndroidApplicationIdentifier:
      final androidApplicationIdentifier =
          AndroidApplicationIdentifier(rawAndroidApplicationIdentifier);
      context.vars.addAll({
        'include_android_platform': true,
        'android_application_identifier_as_path':
            androidApplicationIdentifier.rawSegments.join('/'),
      });
  }
  switch (context.vars['ios_bundle_identifier']) {
    case null:
      context.vars.addAll({
        'include_ios_platform': false,
      });
    case final String rawIosBundleIdentifier:
      IosBundleIdentifier(rawIosBundleIdentifier);
      context.vars.addAll({
        'include_ios_platform': true,
      });
  }
  context.vars.addAll({
    'requirements_met': true,
  });
}
