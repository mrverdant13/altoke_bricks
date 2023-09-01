import 'dart:io';

import 'package:mason/mason.dart';

import 'router/router.dart';

void run(HookContext context) {
  final logger = context.logger;
  var flutterProjectName =
      Platform.environment['ALTOKE_FLUTTER_PROJECT_NAME'] ?? '';
  while (flutterProjectName.isEmpty) {
    flutterProjectName = logger
        .prompt(
          'What is the name of your Flutter project?',
          defaultValue: 'my_altoke_app',
        )
        .trim();
    if (flutterProjectName.isEmpty) {
      logger.err('The Flutter project name cannot be empty');
    }
  }
  context.vars['project_name'] = flutterProjectName;
  var projectDescription =
      Platform.environment['ALTOKE_PROJECT_DESCRIPTION'] ?? '';
  while (projectDescription.isEmpty) {
    projectDescription = logger
        .prompt(
          'What is the project description?',
          defaultValue: 'My Altoke App.',
        )
        .trim();
    if (projectDescription.isEmpty) {
      logger.err('The project description cannot be empty');
    }
  }
  context.vars['project_description'] = projectDescription;
  Router.select(context: context);
}
