import 'dart:io';

import 'package:brick_generator/src/annotation_validator.dart';
import 'package:meta/meta.dart';
import 'package:monorepo_elements/monorepo_elements.dart';

/// Validates annotation markers in the current scope's reference directory.
///
/// Prints each issue to stderr and exits with code 1 when any are found.
///
/// When [scopePath] is provided (tests only), it is used instead of
/// [Dirs.scope].
Future<void> validateReferences({@protected String? scopePath}) async {
  final scopeDir = scopePath == null ? Dirs.scope : Directory(scopePath);
  final referenceDir = scopeDir.descendantDir('reference');
  if (!referenceDir.existsSync()) {
    throw Exception('Reference directory not found (${referenceDir.path}).');
  }
  stdout.writeln('Validating annotations in: ${referenceDir.path}');

  final validator = AnnotationValidator();
  final issues = validator.validateDirectory(referenceDir);

  if (issues.isEmpty) {
    stdout.writeln('No annotation issues found.');
    return;
  }

  issues.forEach(stderr.writeln);
  stderr.writeln('Found ${issues.length} annotation issue(s).');
  exitCode = 1;
}
