@Tags(['e2e'])
library;

import 'dart:async';
import 'dart:io';

import 'package:checked_yaml/checked_yaml.dart';
import 'package:mason/mason.dart';
import 'package:meta/meta.dart';
import 'package:mocktail/mocktail.dart';
import 'package:monorepo_elements/monorepo_elements.dart';
import 'package:router_package/router_package.dart';
import 'package:shell/melos.dart';
import 'package:test/test.dart';

Future<void> main() async {
  final brickManifestFile = Files.brickManifest;
  final brickManifestContent = brickManifestFile.readAsStringSync();
  final brickManifest = checkedYamlDecode(
    brickManifestContent,
    (m) => BrickYaml.fromJson(m!),
  );
  final vars = brickManifest.vars;
  final rawRouterPackages = vars[RouterPackage.varKey]!;
  final routerPackages =
      rawRouterPackages.values!.map(RouterPackage.fromReadableName);

  await testSuccessfulGeneration(
    cases: {
      for (final routerPackage in routerPackages)
        (routerPackage: routerPackage),
    },
    supportAndroid: false,
    supportIos: false,
  );

  await testSuccessfulGeneration(
    cases: {
      for (final routerPackage in routerPackages)
        (routerPackage: routerPackage),
    },
    supportAndroid: false,
    supportIos: true,
  );

  await testSuccessfulGeneration(
    cases: {
      for (final routerPackage in routerPackages)
        (routerPackage: routerPackage),
    },
    supportAndroid: true,
    supportIos: false,
  );

  await testSuccessfulGeneration(
    cases: {
      for (final routerPackage in routerPackages)
        (routerPackage: routerPackage),
    },
    supportAndroid: true,
    supportIos: true,
  );

  await testGenerationWithoutHooks(
    cases: {
      for (final routerPackage in routerPackages)
        (routerPackage: routerPackage),
    },
  );
}

typedef GenerationCase = ({
  RouterPackage routerPackage,
});

@isTest
Future<void> testSuccessfulGeneration({
  required Set<GenerationCase> cases,
  required bool supportAndroid,
  required bool supportIos,
}) async {
  for (final generationCase in cases) {
    final (:routerPackage) = generationCase;
    final composedDescription = '''

GIVEN the Altoke App brick
AND hooks enabled
AND ${supportAndroid ? 'support' : 'no support'} for Android
AND ${supportIos ? 'support' : 'no support'} for iOS
WHEN the generation is run
THEN the generated outputs should be valid and testable
=> with ${routerPackage.readableName}
''';
    test(
      composedDescription,
      () async {
        registerFallbackValue(systemEncoding);
        final tempDir = Directory.systemTemp.createTempSync(
          'altoke-app-e2e-test-${routerPackage.varIdentifier}-',
        );
        addTearDown(() => tempDir.deleteSync(recursive: true));
        final directoryGeneratorTarget = DirectoryGeneratorTarget(tempDir);
        final altokeAppVars = <String, dynamic>{
          'project_name': 'test_project',
          'project_description': 'This is a test project.',
          RouterPackage.varKey: routerPackage.readableName,
          if (supportAndroid) 'android_organization': 'com.some_android_org',
          if (supportIos) 'ios_bundle_identifier': 'some-iOS.Bundle-ID',
        };
        await BrickGenerator.app.runGeneration(
          target: directoryGeneratorTarget,
          vars: altokeAppVars,
          runHooks: true,
        );
        final outputDir = directoryGeneratorTarget.outputDir;
        final androidDir = directoryGeneratorTarget.androidDir;
        final iosDir = directoryGeneratorTarget.iosDir;
        final requirementsFile = directoryGeneratorTarget.requirementsFile;
        expect(
          outputDir.existsSync(),
          isTrue,
          reason: 'Output directory exists',
        );
        expect(
          androidDir.existsSync(),
          supportAndroid,
          reason: 'Android dir ${supportAndroid ? 'exists' : 'does not exist'}',
        );
        expect(
          iosDir.existsSync(),
          supportIos,
          reason: 'iOS dir ${supportIos ? 'exists' : 'does not exist'}',
        );
        expect(
          requirementsFile.existsSync(),
          isFalse,
          reason: 'No requirements file',
        );
        await expectLater(
          Melos.runScript(
            outputDir,
            'format.ci',
          ),
          completes,
        );
        await expectLater(
          Melos.runScript(
            outputDir,
            'analyze.ci',
          ),
          completes,
        );
        await expectLater(
          Melos.runScript(
            outputDir,
            'test.ci',
          ),
          completes,
        );
        await expectLater(
          Melos.runScript(
            outputDir,
            'coverage.merge',
          ),
          completes,
        );
        await expectLater(
          Melos.runScript(
            outputDir,
            'coverage.check',
          ),
          completes,
        );
      },
      timeout: const Timeout(Duration(minutes: 5)),
    );
  }
}

@isTest
Future<void> testGenerationWithoutHooks({
  required Set<GenerationCase> cases,
}) async {
  for (final generationCase in cases) {
    final (:routerPackage) = generationCase;
    final composedDescription = '''

GIVEN the Altoke App brick
AND hooks disabled
WHEN the generation is run
THEN no outputs should be generated
=> with ${routerPackage.readableName}
''';
    test(
      composedDescription,
      () async {
        registerFallbackValue(systemEncoding);
        final tempDir = Directory.systemTemp.createTempSync(
          'altoke-app-e2e-test-${routerPackage.varIdentifier}-',
        );
        addTearDown(() => tempDir.deleteSync(recursive: true));
        final directoryGeneratorTarget = DirectoryGeneratorTarget(tempDir);
        final altokeAppVars = <String, dynamic>{
          'project_name': 'test_project',
          'project_description': 'This is a test project.',
          RouterPackage.varKey: routerPackage.readableName,
        };
        Future<void> action() async => BrickGenerator.app.runGeneration(
              target: directoryGeneratorTarget,
              vars: altokeAppVars,
              runHooks: false,
            );
        expect(
          action(),
          throwsA(isNotNull),
          reason: 'Generation fails',
        );
        final outputDir = directoryGeneratorTarget.outputDir;
        final requirementsFile = directoryGeneratorTarget.requirementsFile;
        expect(
          outputDir.existsSync(),
          isFalse,
          reason: 'Output dir does not exist',
        );
        expect(
          requirementsFile.existsSync(),
          isFalse,
          reason: 'No requirements file',
        );
      },
    );
  }
}

extension on DirectoryGeneratorTarget {
  Directory get outputDir => dir.descendantDir('test_project');
  Directory get appDir => outputDir.descendantDir('packages/app');
  Directory get androidDir => appDir.descendantDir('android');
  Directory get iosDir => appDir.descendantDir('ios');
  File get requirementsFile => dir.descendantFile('REQUIREMENTS.md');
}
