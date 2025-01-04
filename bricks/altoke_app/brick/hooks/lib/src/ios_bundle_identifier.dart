/// {@template altoke_app_hooks.ios_bundle_identifier}
/// **A unique identifier for a bundle.**
///
/// A bundle ID uniquely identifies a single app throughout the system.
///
/// The bundle ID string must contain only alphanumeric characters (A–Z, a–z,
/// and 0–9), hyphens (-), and periods (.).
///
/// _Typically, you use a reverse-DNS format for bundle ID strings. Bundle IDs
/// are case-insensitive._
///
/// See more:
/// https://developer.apple.com/documentation/bundleresources/information-property-list/cfbundleidentifier
/// {@endtemplate}
extension type IosBundleIdentifier._(String value) {
  /// Creates a new [IosBundleIdentifier] from a [String] [value].
  ///
  /// ---
  ///
  /// {@macro altoke_app_hooks.ios_bundle_identifier}
  factory IosBundleIdentifier(String value) {
    validate(value);
    return IosBundleIdentifier._(value);
  }

  /// The pattern that a valid iOS Bundle Identifier must match.
  static final pattern = RegExp(r'^[a-zA-Z0-9-.]*[a-zA-Z0-9-]$');

  /// Evaluates if the given [value] is a valid iOS Bundle Identifier.
  ///
  /// Throws an [ArgumentError] if the [value] is not a valid iOS Bundle
  /// Identifier.
  static void validate(String value) {
    if (pattern.hasMatch(value)) return;
    throw ArgumentError.value(
      value,
      'value',
      'Invalid iOS Bundle Identifier. '
          'It must match the pattern: $pattern',
    );
  }
}
