import 'package:{{objects.snakeCase()}}_storage/{{objects.snakeCase()}}_storage.dart';
import 'package:test/fake.dart';
import 'package:test/test.dart';

class Fake{{objects.pascalCase()}}Storage extends Fake implements {{objects.pascalCase()}}Storage {}

void main() {
  test(
    '{{objects.pascalCase()}}Storage can be implemented',
    () {
      expect(Fake{{objects.pascalCase()}}Storage.new, returnsNormally);
    },
  );
}
