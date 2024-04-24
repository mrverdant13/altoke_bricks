import 'package:{{objects.snakeCase()}}_storage/{{objects.snakeCase()}}_storage.dart';
import 'package:test/test.dart';

void main() {
  test(
    'exports Update{{object.pascalCase()}}FailureEmptyName',
    () {
      expect(
        Update{{object.pascalCase()}}FailureEmptyName.new,
        returnsNormally,
      );
    },
  );
}
