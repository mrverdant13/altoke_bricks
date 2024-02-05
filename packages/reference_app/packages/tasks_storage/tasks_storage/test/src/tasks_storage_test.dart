import 'package:tasks_storage/tasks_storage.dart';
import 'package:test/fake.dart';
import 'package:test/test.dart';

class FakeTasksStorage extends Fake implements TasksStorage {}

void main() {
  test(
    'TasksStorage can be implemented',
    () {
      expect(FakeTasksStorage.new, returnsNormally);
    },
  );
}
