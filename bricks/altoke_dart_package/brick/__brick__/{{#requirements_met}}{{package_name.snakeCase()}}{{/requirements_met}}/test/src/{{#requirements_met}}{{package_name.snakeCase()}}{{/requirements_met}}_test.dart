import 'package:{{#requirements_met}}{{package_name.snakeCase()}}{{/requirements_met}}/{{#requirements_met}}{{package_name.snakeCase()}}{{/requirements_met}}.dart';
import 'package:test/test.dart';

void main() {
  group(
    '{{package_name.pascalCase()}}',
    () {
      test(
        'can be instantiated',
        () {
          expect(
            const {{package_name.pascalCase()}}(),
            isA<{{package_name.pascalCase()}}>(),
          );
        },
      );
    },
  );
}
