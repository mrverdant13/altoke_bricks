import 'package:local_database/local_database.dart';
import 'package:test/test.dart';

final class FakeLocalTasksDao implements LocalTasksDao {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('$LocalTasksDao', () {
    test('can be implemented', () {
      expect(FakeLocalTasksDao.new, returnsNormally);
    });
  });
}
