import 'package:mason/mason.dart';

import 'src/android_application_identifier.dart';
import 'src/android_identifier_segment.dart';
import 'src/android_organization.dart';
import 'src/router.dart';

void run(HookContext context) {
  final rawAndroidOrganization = context.vars['androidOrganization'] as String;
  final androidOrganization = AndroidOrganization(rawAndroidOrganization);
  final projectName = context.vars['projectName'] as String;
  final androidProjectName = AndroidIdentifierSegment(projectName);
  final androidApplicationIdentifier = AndroidApplicationIdentifier.fromParts(
    organization: androidOrganization,
    name: androidProjectName,
  );
  context.vars = {
    ...context.vars,
    'androidApplicationIdentifierAsPath':
        androidApplicationIdentifier.segments.join('/'),
    'androidApplicationIdentifier': androidApplicationIdentifier,
    ...RouterPackage.getSelectionMap(context),
  };
}
