import 'package:altoke_objects_storage/altoke_objects_storage.dart';
import 'package:test/fake.dart';
import 'package:test/test.dart';

class FakeAltokeObjectsStorage extends Fake implements AltokeObjectsStorage {}

void main() {
  test(
    'AltokeObjectsStorage can be implemented',
    () {
      expect(FakeAltokeObjectsStorage.new, returnsNormally);
    },
  );
}
