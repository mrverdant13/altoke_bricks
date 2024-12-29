import 'package:{{#preconditions_met}}local_database{{/preconditions_met}}/{{#preconditions_met}}local_database{{/preconditions_met}}.dart';
import 'package:test/test.dart';

final class FakeLocalTasksDao implements LocalTasksDao {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('$LocalTasksDao', () {
    test(
      'can be implemented',
      () {
        expect(FakeLocalTasksDao.new, returnsNormally);
      },
    );
  });
}
