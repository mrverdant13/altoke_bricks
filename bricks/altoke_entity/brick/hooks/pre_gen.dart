import 'dart:async';
import 'dart:io';

import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:value_equality_approach/value_equality_approach.dart';

Future<void> run(HookContext context) async {
  final parentDir = Directory.current;
  final logger = context.logger;

  var preconditionsCheckProgressMessage = 'Checking preconditions';
  final preconditionsCheckProgress =
      logger.progress(preconditionsCheckProgressMessage);
  final preconditionsCheckTimer = Timer.periodic(
    const Duration(milliseconds: 100),
    (timer) {
      preconditionsCheckProgress.update(preconditionsCheckProgressMessage);
    },
  );

  preconditionsCheckProgressMessage = 'Looking for the "common" package';
  final siblingDirs = parentDir.listSync().whereType<Directory>();
  final commonPackageExistsAsSibling = siblingDirs.any((dir) {
    final pubspecFile = File(path.join(dir.path, 'pubspec.yaml'));
    if (!pubspecFile.existsSync()) return false;
    final pubspec = Pubspec.parse(pubspecFile.readAsStringSync());
    return pubspec.name == 'common';
  });

  preconditionsCheckTimer.cancel();

  final preconditionsErrorMessages = [
    if (!commonPackageExistsAsSibling)
      '''"common" package not found as sibling. You can create it with the "altoke_common" brick.''',
  ];
  if (preconditionsErrorMessages.isNotEmpty) {
    final errorsBuf = StringBuffer()..writeln('Preconditions not met:');
    for (final errorMessage in preconditionsErrorMessages) {
      errorsBuf.writeln('  • $errorMessage');
    }
    preconditionsCheckProgress.fail(errorsBuf.toString());
  } else {
    preconditionsCheckProgress.complete('All preconditions are met');
  }

  context.vars = {
    ...context.vars,
    ...context.valueEqualitySelectionMap,
    'use_meta': context.valueEqualityUsesMeta,
    'use_code_generation': context.valueEqualityUsesCodeGeneration,
    'preconditions_met': preconditionsErrorMessages.isEmpty,
    'using_hooks': true,
  };
}
