import 'package:mason/mason.dart';
import 'package:router_package/router_package.dart';

import 'src/android_application_identifier.dart';
import 'src/android_identifier_segment.dart';
import 'src/android_organization.dart';

void run(HookContext context) {
  final rawAndroidOrganization = context.vars['android_organization'] as String;
  final androidOrganization = AndroidOrganization(rawAndroidOrganization);
  final projectName = context.vars['project_name'] as String;
  final androidProjectName = AndroidIdentifierSegment(projectName);
  final androidApplicationIdentifier = AndroidApplicationIdentifier.fromParts(
    organization: androidOrganization,
    name: androidProjectName,
  );
  context.vars = {
    ...context.vars,
    'android_application_identifier_as_path':
        androidApplicationIdentifier.segments.join('/'),
    'android_application_identifier': androidApplicationIdentifier,
    ...context.routerPackageSelectionMap,
  };
}
