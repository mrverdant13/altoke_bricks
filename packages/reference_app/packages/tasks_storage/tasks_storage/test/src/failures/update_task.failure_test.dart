import 'package:tasks_storage/tasks_storage.dart';
import 'package:test/test.dart';

void main() {
  test(
    'exports UpdateTaskFailureEmptyTitle',
    () {
      expect(
        UpdateTaskFailureEmptyTitle.new,
        returnsNormally,
      );
    },
  );
}
