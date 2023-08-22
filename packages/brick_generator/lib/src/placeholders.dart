enum Placeholder {
  appPackageName(
    'altoke_app',
    '{{project_name.snakeCase()}}',
  ),
  appDescription(
    'An Altoke App.',
    '{{{project_description}}}',
  ),
  appName(
    'Altoke App',
    '{{project_name.titleCase()}}',
  ),
  ;

  const Placeholder(this.literal, this.parameter);

  final String literal;
  final String parameter;
}
