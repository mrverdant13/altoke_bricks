import 'dart:convert';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;

part 'line_deletions.mapper.dart';

/// {@template brick_generator.line_deletions}
/// A set of lines to be dropped from a file.
/// {@endtemplate}
@immutable
@MappableClass()
class LinesDeletion with LinesDeletionMappable {
  /// {@macro brick_generator.line_deletions}
  const LinesDeletion({required this.filePath, required this.ranges});

  /// Creates a [LinesDeletion] from a [json] map.
  // ignore: specify_nonobvious_property_types
  static const fromJson = LinesDeletionMapper.fromMap;

  /// The path to the file to be dropped from.
  final String filePath;

  /// The line ranges to be dropped.
  final List<LinesRange> ranges;
}

/// {@template brick_generator.lines_range}
/// A range of lines.
/// {@endtemplate}
@immutable
@MappableClass()
class LinesRange with LinesRangeMappable {
  /// {@macro brick_generator.lines_range}
  const LinesRange({required this.start, required this.end});

  /// Creates a [LinesRange] from a [json] map.
  // ignore: specify_nonobvious_property_types
  static const fromJson = LinesRangeMapper.fromMap;

  /// The beginning of the range (inclusive & zero-based).
  final int start;

  /// The end of the range (inclusive & zero-based).
  final int end;

  /// Returns whether the [lineNumber] is within the range.
  bool contains(int lineNumber) => start <= lineNumber && lineNumber <= end;
}

/// An [List] of [LinesDeletion]s.
extension LineDeletionsList on List<LinesDeletion> {
  /// Creates a [LineDeletionsList] from a [jsonList].
  static List<LinesDeletion> fromJson(List<dynamic> jsonList) {
    return [
      for (final json in jsonList)
        LinesDeletion.fromJson(json as Map<String, dynamic>),
    ];
  }

  /// Applies the lines deletion to the [input], given the [filePath].
  String apply({required String filePath, required String input}) {
    final lines = LineSplitter.split(input);
    final applyableDeletions = where(
      (deletion) => path.equals(deletion.filePath, filePath),
    );
    final deletableRanges = applyableDeletions.expand(
      (deletion) => deletion.ranges,
    );
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

/// An extension to apply [LineDeletionsList] to a file content.
extension FileContentsWithDeletableLines on String {
  /// Applies the [lineDeletions], given the [filePath].
  String applyLineDeletions({
    required String filePath,
    required List<LinesDeletion> lineDeletions,
  }) => lineDeletions.apply(filePath: filePath, input: this);
}
