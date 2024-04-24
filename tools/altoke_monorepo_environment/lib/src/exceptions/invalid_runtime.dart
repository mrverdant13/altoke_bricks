/// {@template invalid_runtime_error}
/// Error thrown when the runtime is invalid.
/// {@endtemplate}
class InvalidRuntimeError implements Exception {
  /// {@macro invalid_runtime_error}
  const InvalidRuntimeError();

  @override
  String toString() {
    return 'Invalid environment. '
        'This operation must be run under a mono-repo managed by Melos. ';
  }
}
