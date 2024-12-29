import 'package:{{#requirements_met}}common{{/requirements_met}}/{{#requirements_met}}common{{/requirements_met}}.dart';
import 'package:test/test.dart';

void main() {
  test('noFilter always return true', () {
    expect(noFilter(null), true);
  });

  test('noIndexedFilter always return true', () {
    expect(noIndexedFilter(null, null), true);
  });
}
