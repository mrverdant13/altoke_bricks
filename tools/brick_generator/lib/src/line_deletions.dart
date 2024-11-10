import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;

/// {@template brick_generator.line_deletions}
/// A set of lines to be dropped from a file.
/// {@endtemplate}
@immutable
class LinesDeletion {
  /// {@macro brick_generator.line_deletions}
  const LinesDeletion({
    required this.filePath,
    required this.ranges,
  });

  /// Creates a [LinesDeletion] from a [json] map.
  factory LinesDeletion.fromJson(Map<String, dynamic> json) {
    final filePath = json['filePath'] as String;
    final ranges = (json['ranges'] as List<dynamic>).map(
      (e) => LinesRange.fromJson(
        e as Map<String, dynamic>,
      ),
    );
    return LinesDeletion(
      filePath: filePath,
      ranges: ranges,
    );
  }

  /// The path to the file to be dropped from.
  final String filePath;

  /// The line ranges to be dropped.
  final Iterable<LinesRange> ranges;
}

/// {@template brick_generator.lines_range}
/// A range of lines.
/// {@endtemplate}
@immutable
class LinesRange {
  /// {@macro brick_generator.lines_range}
  const LinesRange({
    required this.start,
    required this.end,
  });

  /// Creates a [LinesRange] from a [json] map.
  factory LinesRange.fromJson(Map<String, dynamic> json) {
    final start = json['start'] as int;
    final end = json['end'] as int;
    return LinesRange(
      start: start,
      end: end,
    );
  }

  /// The beginning of the range (inclusive).
  final int start;

  /// The end of the range (inclusive).
  final int end;

  /// Returns whether the [lineNumber] is within the range.
  bool contains(int lineNumber) => start <= lineNumber && lineNumber <= end;
}

/// An [Iterable] of [LinesDeletion]s.
extension type LineDeletionsIterable(Iterable<LinesDeletion> _root)
    implements Iterable<LinesDeletion> {
  /// Creates a [LineDeletionsIterable] from a [json] list.
  factory LineDeletionsIterable.fromJson(List<dynamic> json) {
    return LineDeletionsIterable(
      json.map(
        (e) => LinesDeletion.fromJson(
          e as Map<String, dynamic>,
        ),
      ),
    );
  }

  /// Applies the lines deletion to the [input], given the [filePath].
  String apply({
    required String filePath,
    required String input,
  }) {
    final lines = LineSplitter.split(input);
    final deletableRanges = _root
        .singleWhere(
          (deletion) => path.equals(deletion.filePath, filePath),
          orElse: () => const LinesDeletion(filePath: '', ranges: []),
        )
        .ranges;
    if (deletableRanges.isEmpty) return input;
    final buf = StringBuffer();
    for (final (lineIndex, lineContent) in lines.indexed) {
      final shouldBeDropped = deletableRanges.any(
        (range) => range.contains(lineIndex),
      );
      if (!shouldBeDropped) {
        buf.writeln(lineContent);
      }
    }
    return buf.toString();
  }
}

/// An extension to apply [LineDeletionsIterable] to a file content.
extension FileContentsWithDeletableLines on String {
  /// Applies the [lineDeletions], given the [filePath].
  String applyLineDeletions({
    required String filePath,
    required LineDeletionsIterable lineDeletions,
  }) =>
      lineDeletions.apply(
        filePath: filePath,
        input: this,
      );
}
