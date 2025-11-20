{{#use_riverpod}}
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/app/app.dart';
{{/use_riverpod}}
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/bootstrap/bootstrap.dart';
{{#use_riverpod}}
import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/counter/counter.dart';
{{/use_riverpod}}

{{#use_riverpod}}
import 'package:riverpod_annotation/experimental/scope.dart';{{/use_riverpod}}

{{#use_riverpod}}@Dependencies([
  asyncInitialization,
  Counter,
]){{/use_riverpod}}
Future<void> main() async {
  await bootstrap();
}
