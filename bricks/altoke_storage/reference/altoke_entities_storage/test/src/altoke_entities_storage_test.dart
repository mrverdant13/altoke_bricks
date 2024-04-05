import 'package:altoke_entities_storage/altoke_entities_storage.dart';
import 'package:test/fake.dart';
import 'package:test/test.dart';

class FakeAltokeEntitiesStorage extends Fake implements AltokeEntitiesStorage {}

void main() {
  test(
    'AltokeEntitiesStorage can be implemented',
    () {
      expect(FakeAltokeEntitiesStorage.new, returnsNormally);
    },
  );
}
