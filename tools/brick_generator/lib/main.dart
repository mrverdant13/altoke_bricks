import 'package:brick_generator/src/generate_brick.dart';
import 'package:brick_generator/src/validate_references.dart';

/// Brick generator CLI.
///
/// Subcommands:
/// - `validate` — check reference files for annotation errors
/// - default / `gen` — generate the brick template from references
Future<void> main(List<String> args) async {
  final subcommand = args.firstOrNull ?? 'gen';
  switch (subcommand) {
    case 'validate':
      await validateReferences();
    case 'gen':
      await generateBrick();
    default:
      throw ArgumentError(
        'Unknown subcommand "$subcommand". '
        'Supported subcommands: gen, validate.',
      );
  }
}
