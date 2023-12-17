import 'package:tasks/tasks.dart';
import 'package:test/test.dart';

void main() {
  test(
    '''

exports TasksStatusFilter
''',
    () {
      expect(
        () => TasksStatusFilter.values,
        returnsNormally,
      );
    },
  );
}
