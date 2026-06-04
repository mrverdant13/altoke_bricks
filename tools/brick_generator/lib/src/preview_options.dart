import 'dart:io';

import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;

/// Parsed CLI options for the `preview` subcommand.
class PreviewOptions {
  /// Creates [PreviewOptions].
  const PreviewOptions({
    required this.filePath,
    required this.brickScope,
    required this.vars,
    required this.rootPath,
  });

  /// Parses [args] after the `preview` subcommand name.
  factory PreviewOptions.fromArgs(List<String> args) {
    String? filePath;
    String? brickScope;
    String? varsRaw;
    String? rootPath;

    for (var index = 0; index < args.length; index++) {
      final arg = args[index];
      switch (arg) {
        case '--file':
          filePath = _readValue(args, index, arg);
          index++;
        case '--brick':
          brickScope = _readValue(args, index, arg);
          index++;
        case '--vars':
          varsRaw = _readValue(args, index, arg);
          index++;
        case '--root':
          rootPath = _readValue(args, index, arg);
          index++;
        default:
          throw ArgumentError('Unknown preview argument: $arg');
      }
    }

    if (filePath == null || filePath.isEmpty) {
      throw ArgumentError('Missing required --file <path>.');
    }
    if (brickScope == null || brickScope.isEmpty) {
      throw ArgumentError('Missing required --brick <brick-scope>.');
    }

    return PreviewOptions(
      filePath: p.normalize(p.absolute(filePath)),
      brickScope: brickScope,
      vars: PreviewVars.parse(varsRaw),
      rootPath: resolveMonorepoRoot(rootPath),
    );
  }

  /// Absolute path to the reference file to preview.
  final String filePath;

  /// Brick scope identifier (e.g. `altoke_common` or
  /// `altoke_common_brick_scope`).
  final String brickScope;

  /// Mason variable values supplied by the caller.
  final Map<String, dynamic> vars;

  /// Absolute path to the monorepo root.
  final String rootPath;
}

/// Utilities for resolving monorepo and brick-scope paths.
abstract final class BrickScopePaths {
  /// Resolves a brick scope directory under [rootPath] from [brickScope].
  static String scopeDirectory({
    required String rootPath,
    required String brickScope,
  }) {
    final normalizedScope = brickScope.endsWith('_brick_scope')
        ? brickScope.substring(0, brickScope.length - '_brick_scope'.length)
        : brickScope;

    if (p.isWithin(rootPath, normalizedScope) ||
        p.equals(rootPath, normalizedScope)) {
      final dir = Directory(normalizedScope);
      if (dir.existsSync()) return p.normalize(dir.path);
    }

    final scopeDir = Directory(p.join(rootPath, 'bricks', normalizedScope));
    if (scopeDir.existsSync()) return p.normalize(scopeDir.path);

    throw ArgumentError(
      'Brick scope not found for "$brickScope" '
      '(looked under ${scopeDir.path}).',
    );
  }
}

/// Resolves the monorepo root from [rootArg], `MELOS_ROOT_PATH`, or
/// [Directory.current].
String resolveMonorepoRoot(
  String? rootArg, {
  @visibleForTesting Map<String, String>? environment,
}) {
  if (rootArg != null && rootArg.isNotEmpty) {
    return p.normalize(p.absolute(rootArg));
  }

  final env = environment ?? Platform.environment;
  final melosRoot = env['MELOS_ROOT_PATH'];
  if (melosRoot != null && melosRoot.isNotEmpty) {
    return p.normalize(melosRoot);
  }

  var dir = Directory.current;
  while (true) {
    final bricksDir = Directory(p.join(dir.path, 'bricks'));
    final pubspec = File(p.join(dir.path, 'pubspec.yaml'));
    if (bricksDir.existsSync() && pubspec.existsSync()) {
      return p.normalize(dir.path);
    }
    final parent = dir.parent;
    if (p.equals(parent.path, dir.path)) break;
    dir = parent;
  }

  throw ArgumentError(
    'Could not resolve monorepo root. Pass --root <path> or set '
    'MELOS_ROOT_PATH.',
  );
}

/// Parses `key=value` pairs from a comma-separated CLI value.
abstract final class PreviewVars {
  /// Parses [raw] into a variable map (empty when null or blank).
  static Map<String, dynamic> parse(String? raw) {
    if (raw == null || raw.trim().isEmpty) return {};
    return {
      for (final pair in raw.split(','))
        if (pair.trim().isNotEmpty) ..._parsePair(pair.trim()),
    };
  }

  static Map<String, dynamic> _parsePair(String pair) {
    final separatorIndex = pair.indexOf('=');
    if (separatorIndex <= 0) {
      throw ArgumentError('Invalid --vars entry (expected key=value): $pair');
    }
    final key = pair.substring(0, separatorIndex).trim();
    final rawValue = pair.substring(separatorIndex + 1).trim();
    return {key: _parseValue(rawValue)};
  }

  static dynamic _parseValue(String rawValue) {
    if (rawValue == 'true') return true;
    if (rawValue == 'false') return false;
    final intValue = int.tryParse(rawValue);
    if (intValue != null) return intValue;
    if ((rawValue.startsWith('"') && rawValue.endsWith('"')) ||
        (rawValue.startsWith("'") && rawValue.endsWith("'"))) {
      return rawValue.substring(1, rawValue.length - 1);
    }
    return rawValue;
  }
}

String _readValue(List<String> args, int index, String flag) {
  if (index + 1 >= args.length) {
    throw ArgumentError('Missing value for $flag.');
  }
  return args[index + 1];
}
