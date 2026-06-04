import 'package:brick_generator/src/generate_brick.dart';
import 'package:brick_generator/src/preview_options.dart';
import 'package:brick_generator/src/preview_reference.dart';
import 'package:brick_generator/src/validate_references.dart';
import 'package:meta/meta.dart';

/// Brick generator CLI.
///
/// Subcommands:
/// - `validate` — check reference files for annotation errors
/// - `preview` — transform a single reference file with supplied variables
/// - default / `gen` — generate the brick template from references
Future<void> main(
  List<String> args, {
  @visibleForTesting String? scopePath,
}) async {
  final subcommand = args.firstOrNull ?? 'gen';
  final subcommandArgs = args.length > 1 ? args.sublist(1) : const <String>[];
  switch (subcommand) {
    case 'validate':
      await validateReferences(scopePath: scopePath);
    case 'preview':
      await previewReference(PreviewOptions.fromArgs(subcommandArgs));
    case 'gen':
      await generateBrick(scopePath: scopePath);
    default:
      throw ArgumentError(
        'Unknown subcommand "$subcommand". '
        'Supported subcommands: gen, validate, preview.',
      );
  }
}
