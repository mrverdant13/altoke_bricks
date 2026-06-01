/// A single annotation validation problem in a reference file.
class AnnotationIssue {
  /// Creates an [AnnotationIssue].
  const AnnotationIssue({
    required this.filePath,
    required this.line,
    required this.message,
    this.column,
  });

  /// Path to the file relative to the reference root, or absolute.
  final String filePath;

  /// One-based line number.
  final int line;

  /// Optional one-based column number.
  final int? column;

  /// Human-readable description of the problem.
  final String message;

  @override
  String toString() {
    final location = column == null
        ? '$filePath:$line'
        : '$filePath:$line:$column';
    return '$location: $message';
  }
}
