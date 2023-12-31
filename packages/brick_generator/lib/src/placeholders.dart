/// Placeholders for the generated code.
enum Placeholder {
  /// The file-system entity name based on the project name.
  appPath(
    'altoke-app',
    '{{project_name.kebabCase()}}',
  ),

  /// The package name of the app.
  appPackageName(
    'altoke_app',
    '{{project_name.snakeCase()}}',
  ),

  /// The description of the app.
  appDescription(
    'An Altoke App.',
    '{{{project_description}}}',
  ),

  /// The readable name of the app.
  appName(
    'Altoke App',
    '{{project_name.titleCase()}}',
  ),
  ;

  const Placeholder(this.literal, this.parameter);

  /// The literal value of the placeholder.
  ///
  /// This is the value that will be replaced in the generated code.
  final String literal;

  /// The parameter value of the placeholder.
  ///
  /// This is the value that will be used to parametrize the template.
  final String parameter;
}
