import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/app/app.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/bootstrap/bootstrap.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/routing/routing.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([
  routerConfig,
  asyncInitialization,
])
Future<void> main() async {
  await bootstrap();
}
