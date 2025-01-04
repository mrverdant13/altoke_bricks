import 'package:mason/mason.dart';

import 'src/android_application_identifier.dart';
import 'src/android_identifier_segment.dart';
import 'src/android_organization.dart';
import 'src/ios_bundle_identifier.dart';

void run(HookContext context) {
  final projectName = context.vars['project_name'] as String;
  switch (context.vars['android_organization']) {
    case null:
      context.vars.addAll({
        'include_android_platform': false,
      });
    case final String rawAndroidOrganization:
      final androidOrganization = AndroidOrganization(rawAndroidOrganization);
      final androidProjectName = AndroidIdentifierSegment(projectName);
      final androidApplicationIdentifier =
          AndroidApplicationIdentifier.fromParts(
        organization: androidOrganization,
        name: androidProjectName,
      );
      context.vars.addAll({
        'include_android_platform': true,
        'android_application_identifier_as_path':
            androidApplicationIdentifier.segments.join('/'),
        'android_application_identifier': androidApplicationIdentifier,
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
