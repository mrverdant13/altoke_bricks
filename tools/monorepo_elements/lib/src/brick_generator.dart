import 'package:mason/mason.dart';
import 'package:monorepo_elements/monorepo_elements.dart';
import 'package:path/path.dart' as path;

/// Brick generators available in the monorepo environment.
extension BrickGenerator on MasonGenerator {
  static Future<MasonGenerator> _buildAsyncGenerator({
    required String brickDir,
  }) async {
    final brickPath = path.joinAll([
      Vars.rootPath,
      'bricks',
      brickDir,
      'brick',
    ]);
    final brick = Brick.path(brickPath);
    return MasonGenerator.fromBrick(brick);
  }

  /// Altoke App brick generator.
  static Future<MasonGenerator> app = _buildAsyncGenerator(
    brickDir: 'altoke_app',
  );

  /// Altoke Common brick generator.
  static Future<MasonGenerator> common = _buildAsyncGenerator(
    brickDir: 'altoke_common',
  );

  /// Altoke Dart Package brick generator.
  static Future<MasonGenerator> dartPackage = _buildAsyncGenerator(
    brickDir: 'altoke_dart_package',
  );

  /// Altoke Entity brick generator.
  static Future<MasonGenerator> entity = _buildAsyncGenerator(
    brickDir: 'altoke_entity',
  );

  /// Altoke Local Database brick generator.
  static Future<MasonGenerator> localDatabase = _buildAsyncGenerator(
    brickDir: 'altoke_local_database',
  );

  /// Altoke Reactive Caches brick generator.
  static Future<MasonGenerator> reactiveCaches = _buildAsyncGenerator(
    brickDir: 'altoke_reactive_caches',
  );

  /// Run the full generation routine.
  Future<void> runFullGeneration({
    required DirectoryGeneratorTarget target,
    required Map<String, dynamic> vars,
  }) async {
    await hooks.preGen(
      workingDirectory: target.dir.path,
      vars: vars,
      onVarsChanged: (updatedVars) {
        vars
          ..clear()
          ..addAll(updatedVars);
      },
    );
    await generate(
      target,
      vars: vars,
    );
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

/// Async brick generators available in the monorepo environment.
extension AsyncBrickGenerator on Future<MasonGenerator> {
  /// Run the full generation routine.
  Future<void> runFullGeneration({
    required DirectoryGeneratorTarget target,
    required Map<String, dynamic> vars,
  }) async {
    final generator = await this;
    await generator.runFullGeneration(
      target: target,
      vars: vars,
    );
  }
}
