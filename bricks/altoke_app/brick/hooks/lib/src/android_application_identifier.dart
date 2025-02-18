/// {@template altoke_app_hooks.android_application_identifier}
/// Although the application ID looks like a traditional Kotlin or Java package
/// name, the naming rules for the application ID are a bit more restrictive:
///
/// - It must have at least two segments (one or more dots).
/// - Each segment must start with a letter.
/// - All characters must be alphanumeric or an underscore [a-zA-Z0-9_].
///
/// See more: https://developer.android.com/build/configure-app-module#set-application-id
/// {@endtemplate}
extension type AndroidApplicationIdentifier._(String value) {
  /// Creates a new [AndroidApplicationIdentifier] from a [String] [value].
  ///
  /// ---
  ///
  /// {@macro altoke_app_hooks.android_application_identifier}
  factory AndroidApplicationIdentifier(String value) {
    validate(value);
    return AndroidApplicationIdentifier._(value);
  }

  /// The pattern that a valid Android Application Identifier must match.
  static final pattern = RegExp(
    r'^[a-zA-Z][a-zA-Z0-9_]*(?:\.[a-zA-Z][a-zA-Z0-9_]*)+$',
  );

  /// Evaluates if the given [value] is a valid Android Application Identifier.
  ///
  /// Throws an [ArgumentError] if the [value] is not a valid Android
  /// Application Identifier.
  static void validate(String value) {
    if (pattern.hasMatch(value)) return;
    throw ArgumentError.value(
      value,
      'value',
      'Invalid Android Application Identifier. '
          'It must match the pattern: $pattern',
    );
  }

  /// The raw segments of the Android Application Identifier.
  Iterable<String> get rawSegments => value.split('.');
}
