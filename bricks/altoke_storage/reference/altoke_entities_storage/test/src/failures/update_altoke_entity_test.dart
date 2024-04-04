import 'package:altoke_entities_storage/altoke_entities_storage.dart';
import 'package:test/test.dart';

void main() {
  test(
    'exports UpdateAltokeEntityFailureEmptyName',
    () {
      expect(
        UpdateAltokeEntityFailureEmptyName.new,
        returnsNormally,
      );
    },
  );
}
