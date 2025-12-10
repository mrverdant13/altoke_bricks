// @Tags(['e2e'])
// library;

import 'dart:async';
import 'dart:io';

import 'package:checked_yaml/checked_yaml.dart';
import 'package:mason/mason.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import 'package:router_package/router_package.dart';
import 'package:shell/melos.dart';
import 'package:state_management_package/state_management_package.dart';
import 'package:test/test.dart';

typedef GenerationCase = ({
  bool runHooks,
  RouterPackage routerPackage,
  StateManagementPackage stateManagementPackage,
  bool supportAndroid,
  bool supportIos,
  bool supportWeb,
});

Future<void> main() async {
  final brickDirPath = p.joinAll([
    '..',
    'brick',
  ]);
  final brick = Brick.path(brickDirPath);
  final generator = await MasonGenerator.fromBrick(brick);
  final brickManifestFilePath = p.joinAll([
    brickDirPath,
    'brick.yaml',
  ]);
  final brickManifestFile = File(brickManifestFilePath);
  final brickManifestContent = brickManifestFile.readAsStringSync();
  final brickManifest = checkedYamlDecode(
    brickManifestContent,
    (m) => BrickYaml.fromJson(m!),
  );
  final vars = brickManifest.vars;
  final rawRouterPackages = vars[RouterPackage.varKey]!.values!;
  final routerPackages = rawRouterPackages.map(
    RouterPackage.fromReadableName,
  );
  final rawStateManagementPackages =
      vars[StateManagementPackage.varKey]!.values!;
  final stateManagementPackages = rawStateManagementPackages.map(
    StateManagementPackage.fromReadableName,
  );
  final testCases = <GenerationCase>{
    for (final runHooks in [false, true])
      for (final routerPackage in routerPackages)
        for (final stateManagementPackage in stateManagementPackages)
          for (final supportAndroid in [false, true])
            for (final supportIos in [false, true])
              for (final supportWeb in [false, true])
                (
                  runHooks: runHooks,
                  routerPackage: routerPackage,
                  stateManagementPackage: stateManagementPackage,
                  supportAndroid: supportAndroid,
                  supportIos: supportIos,
                  supportWeb: supportWeb,
                ),
  };

  await testGenerationCases(
    'E2E test',
    testCases: testCases,
    generator: generator,
  );
}

@isTest
Future<void> testGenerationCases(
  String description, {
  required Set<GenerationCase> testCases,
  required MasonGenerator generator,
}) async {
  for (final testCase in testCases) {
    await testGenerationCase(
      description: description,
      generator: generator,
      testCase: testCase,
    );
  }
}

@isTest
Future<void> testGenerationCase({
  required String description,
  required MasonGenerator generator,
  required GenerationCase testCase,
}) async {
  final GenerationCase(
    :runHooks,
    :routerPackage,
    :stateManagementPackage,
    :supportAndroid,
    :supportIos,
    :supportWeb,
  ) = testCase;
  final testContext = Iterable.iterableToFullString([
    'runHooks: $runHooks',
    'routerPackage: ${routerPackage.readableName}',
    'stateManagementPackage: ${stateManagementPackage.readableName}',
    'supportAndroid: $supportAndroid',
    'supportIos: $supportIos',
    'supportWeb: $supportWeb',
  ]);
  test(
    '$description $testContext',
    () async {
      final tempDir = Directory.systemTemp.createTempSync(
        'altoke-app-e2e-test'
        '${testCase.runHooks ? '+' : '-'}hooks'
        '-${testCase.routerPackage.varIdentifier}'
        '-${testCase.stateManagementPackage.varIdentifier}'
        '${testCase.supportAndroid ? '+' : '-'}android'
        '${testCase.supportIos ? '+' : '-'}ios'
        '${testCase.supportWeb ? '+' : '-'}web',
      );
      addTearDown(() => tempDir.deleteSync(recursive: true));
      final directoryGeneratorTarget = DirectoryGeneratorTarget(tempDir);
      final altokeAppVars = <String, dynamic>{
        'project_name': 'test_project',
        'project_description': 'This is a test project.',
        RouterPackage.varKey: routerPackage.readableName,
        StateManagementPackage.varKey: stateManagementPackage.readableName,
        if (supportAndroid)
          'android_application_identifier': 'some_android.App_ID',
        if (supportIos) 'ios_bundle_identifier': 'some-iOS.Bundle-ID',
        'include_web_platform': supportWeb,
      };
      await generator.runGeneration(
        target: directoryGeneratorTarget,
        vars: altokeAppVars,
        runHooks: runHooks,
      );
      final outputDir = directoryGeneratorTarget.outputDir;
      final requirementsFile = directoryGeneratorTarget.requirementsFile;
      expect(
        outputDir.existsSync(),
        runHooks,
        reason:
            'Output directory ${runHooks ? 'exists' : 'does not exist'} '
            '$testContext',
      );
      expect(
        requirementsFile.existsSync(),
        !runHooks,
        reason:
            'Requirements file ${runHooks ? 'does not exist' : 'exists'} '
            '$testContext',
      );
      final androidDir = directoryGeneratorTarget.androidDir;
      expect(
        androidDir.existsSync(),
        runHooks && supportAndroid,
        reason:
            'Android dir ${supportAndroid ? 'exists' : 'does not exist'} '
            '$testContext',
      );
      final iosDir = directoryGeneratorTarget.iosDir;
      expect(
        iosDir.existsSync(),
        runHooks && supportIos,
        reason:
            'iOS dir ${supportIos ? 'exists' : 'does not exist'} '
            '$testContext',
      );
      final webDir = directoryGeneratorTarget.webDir;
      expect(
        webDir.existsSync(),
        runHooks && supportWeb,
        reason:
            'Web dir ${supportWeb ? 'exists' : 'does not exist'} '
            '$testContext',
      );
      if (!runHooks) return;
      await expectLater(
        Melos.runScript(outputDir, 'format.ci'),
        completes,
      );
      await expectLater(
        Melos.runScript(outputDir, 'analyze.ci'),
        completes,
      );
      await expectLater(
        Melos.runScript(outputDir, 'test.ci'),
        completes,
      );
      await expectLater(
        Melos.runScript(outputDir, 'coverage.merge'),
        completes,
      );
      await expectLater(
        Melos.runScript(outputDir, 'coverage.check'),
        completes,
      );
    },
    timeout: const Timeout(Duration(minutes: 5)),
  );
}

extension on MasonGenerator {
  Future<void> runGeneration({
    required DirectoryGeneratorTarget target,
    required Map<String, dynamic> vars,
    required bool runHooks,
  }) async {
    if (runHooks) {
      await hooks.preGen(
        workingDirectory: target.dir.path,
        vars: vars,
        onVarsChanged: (updatedVars) {
          vars
            ..clear()
            ..addAll(updatedVars);
        },
      );
    }
    await generate(target, vars: vars);
    if (runHooks) {
      await hooks.postGen(
        workingDirectory: target.dir.path,
        vars: vars,
        onVarsChanged: (updatedVars) {
          vars
            ..clear()
            ..addAll(updatedVars);
        },
      );
    }
  }
}

extension on DirectoryGeneratorTarget {
  Directory get outputDir => Directory(
    p.joinAll([
      dir.path,
      'test_project',
    ]),
  );
  Directory get appDir => Directory(
    p.joinAll([
      outputDir.path,
      'packages',
      'app',
    ]),
  );
  Directory get androidDir => Directory(
    p.joinAll([
      appDir.path,
      'android',
    ]),
  );
  Directory get iosDir => Directory(
    p.joinAll([
      appDir.path,
      'ios',
    ]),
  );
  Directory get webDir => Directory(
    p.joinAll([
      appDir.path,
      'web',
    ]),
  );
  File get requirementsFile => File(
    p.joinAll([
      dir.path,
      'REQUIREMENTS.md',
    ]),
  );
}
