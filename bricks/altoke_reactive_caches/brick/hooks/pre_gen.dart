import 'dart:async';
import 'dart:io';

import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;
import 'package:pubspec_parse/pubspec_parse.dart';

Future<void> run(HookContext context) async {
  final parentDir = Directory.current;
  final logger = context.logger;

  var requirementsCheckProgressMessage = 'Checking requirements';
  final requirementsCheckProgress = logger.progress(
    requirementsCheckProgressMessage,
  );
  final requirementsCheckTimer = Timer.periodic(
    const Duration(milliseconds: 100),
    (timer) {
      requirementsCheckProgress.update(requirementsCheckProgressMessage);
    },
  );

  requirementsCheckProgressMessage = 'Looking for the "common" package';
  final siblingDirs = parentDir.listSync().whereType<Directory>();
  final commonPackageExistsAsSibling = siblingDirs.any((dir) {
    final pubspecFile = File(path.join(dir.path, 'pubspec.yaml'));
    if (!pubspecFile.existsSync()) return false;
    final pubspec = Pubspec.parse(pubspecFile.readAsStringSync());
    return pubspec.name == 'common';
  });

  requirementsCheckTimer.cancel();

  final requirementsErrorMessages = [
    if (!commonPackageExistsAsSibling)
      '''"common" package not found as sibling. You can create it with the "altoke_common" brick.''',
  ];
  if (requirementsErrorMessages.isNotEmpty) {
    final errorsBuf = StringBuffer()..writeln('Requirements not met:');
    for (final errorMessage in requirementsErrorMessages) {
      errorsBuf.writeln('  • $errorMessage');
    }
    requirementsCheckProgress.fail(errorsBuf.toString());
  } else {
    requirementsCheckProgress.complete('All requirements are met');
  }

  context.vars = {
    ...context.vars,
    'requirements_met': requirementsErrorMessages.isEmpty,
  };
}
