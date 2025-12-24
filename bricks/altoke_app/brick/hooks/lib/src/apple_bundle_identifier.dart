/// {@template altoke_app_hooks.apple_bundle_identifier}
/// **A unique identifier for an Apple bundle.**
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
extension type AppleBundleIdentifier._(String value) {
  /// Creates a new [AppleBundleIdentifier] from a [String] [value].
  ///
  /// ---
  ///
  /// {@macro altoke_app_hooks.apple_bundle_identifier}
  factory AppleBundleIdentifier(String value) {
    validate(value);
    return AppleBundleIdentifier._(value);
  }

  /// The pattern that a valid Apple Bundle Identifier must match.
  static final pattern = RegExp(r'^[a-zA-Z0-9-.]*[a-zA-Z0-9-]$');

  /// Evaluates if the given [value] is a valid Apple Bundle Identifier.
  ///
  /// Throws an [ArgumentError] if the [value] is not a valid Apple Bundle
  /// Identifier.
  static void validate(String value) {
    if (pattern.hasMatch(value)) return;
    throw ArgumentError.value(
      value,
      'value',
      'Invalid Apple Bundle Identifier. '
          'It must match the pattern: $pattern',
    );
  }
}
