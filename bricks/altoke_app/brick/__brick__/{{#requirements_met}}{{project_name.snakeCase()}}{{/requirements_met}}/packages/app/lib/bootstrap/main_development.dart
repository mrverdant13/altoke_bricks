import 'package:{{#requirements_met}}{{project_name.snakeCase()}}{{/requirements_met}}/bootstrap/bootstrap.dart';

Future<void> main() async {
  await bootstrap();
}
