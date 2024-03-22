import 'package:altoke_objects_storage/altoke_objects_storage.dart';
import 'package:test/test.dart';

void main() {
  test(
    'exports UpdateAltokeObjectFailureEmptyName',
    () {
      expect(
        UpdateAltokeObjectFailureEmptyName.new,
        returnsNormally,
      );
    },
  );
}
