import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/app/app.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/bootstrap/bootstrap.dart';
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/counter/counter.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([
  asyncInitialization,
  Counter,
])
Future<void> main() async {
  await bootstrap();
}
