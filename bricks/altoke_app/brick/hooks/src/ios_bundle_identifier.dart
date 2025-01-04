extension type IosBundleIdentifier._(String value) {
  IosBundleIdentifier(this.value) {
    validate(value);
  }

  static final pattern = RegExp(r'^[a-zA-Z0-9-.]*[a-zA-Z0-9-]$');

  static void validate(String value) {
    if (pattern.hasMatch(value)) return;
    throw ArgumentError.value(
      value,
      'value',
      'Invalid iOS Bundle Identifier. It must match the pattern: $pattern',
    );
  }
}
