import 'package:{{#requirements_met}}local_database{{/requirements_met}}/{{#requirements_met}}local_database{{/requirements_met}}.dart';
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
