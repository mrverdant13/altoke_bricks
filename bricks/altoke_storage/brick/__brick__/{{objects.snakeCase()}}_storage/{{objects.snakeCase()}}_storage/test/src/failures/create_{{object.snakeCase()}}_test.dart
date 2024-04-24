import 'package:{{objects.snakeCase()}}_storage/{{objects.snakeCase()}}_storage.dart';
import 'package:test/test.dart';

void main() {
  test(
    'exports Create{{object.pascalCase()}}FailureEmptyName',
    () {
      expect(
        Create{{object.pascalCase()}}FailureEmptyName.new,
        returnsNormally,
      );
    },
  );
}
