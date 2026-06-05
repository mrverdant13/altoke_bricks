import 'dart:io';

import 'package:brick_generator/src/annotation_issue.dart';
import 'package:path/path.dart' as p;

/// Validates brick-generator annotation markers in reference file contents.
class AnnotationValidator {
  /// Validates [content] and returns any issues found.
  List<AnnotationIssue> validateContent(String content) {
    final issues = <AnnotationIssue>[
      ..._validatePairedMarkers(content, _removeMarkerSets),
      ..._validatePairedMarkers(content, _insertMarkerSets),
      ..._validateReplaceBlocks(content),
      ..._validatePartialBlocks(content),
    ];
    return issues;
  }

  /// Validates a single [file] and returns issues with its path attached.
  List<AnnotationIssue> validateFile(File file, {String? displayPath}) {
    final path = displayPath ?? file.path;
    if (_shouldSkipFile(path)) {
      return const [];
    }
    late final String content;
    try {
      content = file.readAsStringSync();
    } on FileSystemException {
      return const [];
    }
    return validateContent(content)
        .map(
          (issue) => AnnotationIssue(
            filePath: path,
            line: issue.line,
            column: issue.column,
            message: issue.message,
          ),
        )
        .toList();
  }

  /// Walks [referenceDir] recursively and validates every file.
  List<AnnotationIssue> validateDirectory(Directory referenceDir) {
    if (!referenceDir.existsSync()) {
      throw ArgumentError(
        'Reference directory not found (${referenceDir.path}).',
      );
    }
    final issues = <AnnotationIssue>[];
    for (final entity in referenceDir.listSync(recursive: true)) {
      if (entity is! File) continue;
      final relativePath = p.relative(entity.path, from: referenceDir.path);
      issues.addAll(validateFile(entity, displayPath: relativePath));
    }
    return issues;
  }

  static const _ignoredExtensions = {
    '.png',
    '.webp',
    '.jpg',
    '.jpeg',
    '.gif',
    '.ico',
    '.jar',
    '.keystore',
    '.p12',
    '.jks',
  };

  static const _ignoredBasenames = {'.DS_Store'};

  static bool _shouldSkipFile(String path) {
    if (_ignoredExtensions.contains(p.extension(path))) return true;
    if (_ignoredBasenames.contains(p.basename(path))) return true;
    return false;
  }

  static final _removeMarkerSets = [
    _MarkerSet(
      flavor: '/* */',
      start: RegExp(r'/\*(?:x-)?remove-start\*/'),
      end: RegExp(r'/\*remove-end(?:-x)?\*/'),
      blockName: 'remove',
    ),
    _MarkerSet(
      flavor: '# #',
      start: RegExp('#(?:x-)?remove-start#'),
      end: RegExp('#remove-end(?:-x)?#'),
      blockName: 'remove',
    ),
    _MarkerSet(
      flavor: '<!-- -->',
      start: RegExp('<!--(?:x-)?remove-start-->'),
      end: RegExp('<!--remove-end(?:-x)?-->'),
      blockName: 'remove',
    ),
  ];

  static final _insertMarkerSets = [
    _MarkerSet(
      flavor: '/* */',
      start: RegExp(r'/\*insert-start\*/'),
      end: RegExp(r'/\*insert-end\*/'),
      blockName: 'insert',
    ),
    _MarkerSet(
      flavor: '# #',
      start: RegExp('#insert-start#'),
      end: RegExp('#insert-end#'),
      blockName: 'insert',
    ),
    _MarkerSet(
      flavor: '<!-- -->',
      start: RegExp('<!--insert-start-->'),
      end: RegExp('<!--insert-end-->'),
      blockName: 'insert',
    ),
  ];

  List<AnnotationIssue> _validatePairedMarkers(
    String content,
    List<_MarkerSet> markerSets,
  ) {
    final issues = <AnnotationIssue>[];
    for (final markerSet in markerSets) {
      final markers = <_Marker>[];
      for (final match in markerSet.start.allMatches(content)) {
        markers.add(
          _Marker(
            kind: _MarkerKind.start,
            offset: match.start,
            blockName: markerSet.blockName,
            flavor: markerSet.flavor,
          ),
        );
      }
      for (final match in markerSet.end.allMatches(content)) {
        markers.add(
          _Marker(
            kind: _MarkerKind.end,
            offset: match.start,
            blockName: markerSet.blockName,
            flavor: markerSet.flavor,
          ),
        );
      }
      markers.sort((a, b) => a.offset.compareTo(b.offset));
      final stack = <_Marker>[];
      for (final marker in markers) {
        switch (marker.kind) {
          case _MarkerKind.start:
            stack.add(marker);
          case _MarkerKind.end:
            if (stack.isEmpty) {
              issues.add(
                _issue(
                  content,
                  marker.offset,
                  'Unmatched ${markerSet.blockName}-end marker '
                  '(${markerSet.flavor})',
                ),
              );
            } else {
              stack.removeLast();
            }
        }
      }
      for (final unmatched in stack) {
        issues.add(
          _issue(
            content,
            unmatched.offset,
            'Unmatched ${markerSet.blockName}-start marker '
            '(${markerSet.flavor})',
          ),
        );
      }
    }
    return issues;
  }

  List<AnnotationIssue> _validateReplaceBlocks(String content) {
    final issues = <AnnotationIssue>[];
    for (final markerSet in _replaceMarkerSets) {
      final markers = <_ReplaceMarker>[];
      for (final match in markerSet.start.allMatches(content)) {
        markers.add(
          _ReplaceMarker(_ReplaceMarkerKind.start, match.start, markerSet),
        );
      }
      for (final match in markerSet.withMarker.allMatches(content)) {
        markers.add(
          _ReplaceMarker(_ReplaceMarkerKind.withMarker, match.start, markerSet),
        );
      }
      for (final match in markerSet.end.allMatches(content)) {
        markers.add(
          _ReplaceMarker(_ReplaceMarkerKind.end, match.start, markerSet),
        );
      }
      markers.sort((a, b) => a.offset.compareTo(b.offset));
      var expecting = _ReplaceMarkerKind.start;
      final stack = <int>[];
      for (final marker in markers) {
        switch (expecting) {
          case _ReplaceMarkerKind.start:
            if (marker.kind == _ReplaceMarkerKind.start) {
              stack.add(marker.offset);
              expecting = _ReplaceMarkerKind.withMarker;
            } else {
              issues.add(
                _issue(
                  content,
                  marker.offset,
                  'Unexpected ${marker.kind.label} before replace-start '
                  '(${markerSet.flavor})',
                ),
              );
            }
          case _ReplaceMarkerKind.withMarker:
            if (marker.kind == _ReplaceMarkerKind.withMarker) {
              expecting = _ReplaceMarkerKind.end;
            } else if (marker.kind == _ReplaceMarkerKind.start) {
              issues.add(
                _issue(
                  content,
                  marker.offset,
                  'Nested replace-start is not supported '
                  '(${markerSet.flavor})',
                ),
              );
            } else {
              issues.add(
                _issue(
                  content,
                  marker.offset,
                  'replace-end without a matching with marker '
                  '(${markerSet.flavor})',
                ),
              );
              expecting = _ReplaceMarkerKind.start;
              stack.clear();
            }
          case _ReplaceMarkerKind.end:
            if (marker.kind == _ReplaceMarkerKind.end) {
              if (stack.isEmpty) {
                issues.add( // coverage:ignore-line
                  _issue( // coverage:ignore-line
                    content, // coverage:ignore-line
                    marker.offset, // coverage:ignore-line
                    'Unmatched replace-end marker ' // coverage:ignore-line
                    '(${markerSet.flavor})', // coverage:ignore-line
                  ), // coverage:ignore-line
                ); // coverage:ignore-line
              } else {
                stack.removeLast();
              }
              expecting = _ReplaceMarkerKind.start;
            } else if (marker.kind == _ReplaceMarkerKind.withMarker) {
              issues.add(
                _issue(
                  content,
                  marker.offset,
                  'Duplicate with marker in replace block '
                  '(${markerSet.flavor})',
                ),
              );
              expecting = _ReplaceMarkerKind.end;
            } else {
              issues.add(
                _issue(
                  content,
                  marker.offset,
                  'replace-start block is missing replace-end '
                  '(${markerSet.flavor})',
                ),
              );
              stack.add(marker.offset);
              expecting = _ReplaceMarkerKind.withMarker;
            }
        }
      }
      for (final startOffset in stack) {
        issues.add(
          _issue(
            content,
            startOffset,
            'Unmatched replace-start marker '
            '(${markerSet.flavor})',
          ),
        );
      }
    }
    return issues;
  }

  static final _replaceMarkerSets = [
    _ReplaceMarkerSet(
      flavor: '/* */',
      start: RegExp(r'/\*replace-start\*/'),
      withMarker: RegExp(r'/\*with(?: +i\d+)?\*/'),
      end: RegExp(r'/\*replace-end\*/'),
    ),
    _ReplaceMarkerSet(
      flavor: '# #',
      start: RegExp('#replace-start#'),
      withMarker: RegExp(r'#with(?: +i\d+)?#'),
      end: RegExp('#replace-end#'),
    ),
    _ReplaceMarkerSet(
      flavor: '<!-- -->',
      start: RegExp('<!--replace-start-->'),
      withMarker: RegExp(r'<!--with(?: +i\d+)?-->'),
      end: RegExp('<!--replace-end-->'),
    ),
  ];

  List<AnnotationIssue> _validatePartialBlocks(String content) {
    final issues = <AnnotationIssue>[];
    for (final markerSet in _partialMarkerSets) {
      final markers = <_PartialMarker>[];
      for (final match in markerSet.start.allMatches(content)) {
        final name = match.namedGroup('name') ?? '';
        markers.add(
          _PartialMarker(
            kind: _PartialMarkerKind.start,
            offset: match.start,
            name: name,
            flavor: markerSet.flavor,
          ),
        );
      }
      for (final match in markerSet.end.allMatches(content)) {
        final name = match.namedGroup('name') ?? '';
        markers.add(
          _PartialMarker(
            kind: _PartialMarkerKind.end,
            offset: match.start,
            name: name,
            flavor: markerSet.flavor,
          ),
        );
      }
      markers.sort((a, b) => a.offset.compareTo(b.offset));
      final stack = <_PartialMarker>[];
      for (final marker in markers) {
        switch (marker.kind) {
          case _PartialMarkerKind.start:
            stack.add(marker);
          case _PartialMarkerKind.end:
            if (stack.isEmpty) {
              issues.add(
                _issue(
                  content,
                  marker.offset,
                  'Unmatched partial ^ marker for "${marker.name}" '
                  '(${markerSet.flavor})',
                ),
              );
            } else {
              final start = stack.removeLast();
              if (start.name != marker.name) {
                issues.add(
                  _issue(
                    content,
                    marker.offset,
                    'partial ^ name "${marker.name}" does not match '
                    'partial v name "${start.name}" '
                    '(${markerSet.flavor})',
                  ),
                );
              }
            }
        }
      }
      for (final unmatched in stack) {
        issues.add(
          _issue(
            content,
            unmatched.offset,
            'Unmatched partial v marker for "${unmatched.name}" '
            '(${markerSet.flavor})',
          ),
        );
      }
    }
    return issues;
  }

  static final _partialMarkerSets = [
    _PartialMarkerSet(
      flavor: '/* */',
      start: RegExp(r'/\*partial v (?<name>.*?)\*/'),
      end: RegExp(r'/\*partial \^ (?<name>.*?)\*/'),
    ),
    _PartialMarkerSet(
      flavor: '# #',
      start: RegExp('#partial v (?<name>.*?)#'),
      end: RegExp(r'#partial \^ (?<name>.*?)#'),
    ),
    _PartialMarkerSet(
      flavor: '<!-- -->',
      start: RegExp('<!--partial v (?<name>.*?)-->'),
      end: RegExp(r'<!--partial \^ (?<name>.*?)-->'),
    ),
  ];

  AnnotationIssue _issue(String content, int offset, String message) {
    return AnnotationIssue(
      filePath: '',
      line: _lineAt(content, offset),
      column: _columnAt(content, offset),
      message: message,
    );
  }

  static int _lineAt(String content, int offset) {
    return '\n'.allMatches(content.substring(0, offset)).length + 1;
  }

  static int _columnAt(String content, int offset) {
    final lastNewline = content.lastIndexOf('\n', offset == 0 ? 0 : offset - 1);
    return offset - lastNewline;
  }
}

class _MarkerSet {
  const _MarkerSet({
    required this.flavor,
    required this.start,
    required this.end,
    required this.blockName,
  });

  final String flavor;
  final RegExp start;
  final RegExp end;
  final String blockName;
}

enum _MarkerKind { start, end }

class _Marker {
  const _Marker({
    required this.kind,
    required this.offset,
    required this.blockName,
    required this.flavor,
  });

  final _MarkerKind kind;
  final int offset;
  final String blockName;
  final String flavor;
}

enum _ReplaceMarkerKind {
  start,
  withMarker,
  end,
  ;

  String get label => switch (this) {
    _ReplaceMarkerKind.start => 'replace-start',
    _ReplaceMarkerKind.withMarker => 'with',
    _ReplaceMarkerKind.end => 'replace-end',
  };
}

class _ReplaceMarkerSet {
  const _ReplaceMarkerSet({
    required this.flavor,
    required this.start,
    required this.withMarker,
    required this.end,
  });

  final String flavor;
  final RegExp start;
  final RegExp withMarker;
  final RegExp end;
}

class _ReplaceMarker {
  const _ReplaceMarker(this.kind, this.offset, this.markerSet);

  final _ReplaceMarkerKind kind;
  final int offset;
  final _ReplaceMarkerSet markerSet;
}

enum _PartialMarkerKind { start, end }

class _PartialMarkerSet {
  const _PartialMarkerSet({
    required this.flavor,
    required this.start,
    required this.end,
  });

  final String flavor;
  final RegExp start;
  final RegExp end;
}

class _PartialMarker {
  const _PartialMarker({
    required this.kind,
    required this.offset,
    required this.name,
    required this.flavor,
  });

  final _PartialMarkerKind kind;
  final int offset;
  final String name;
  final String flavor;
}
