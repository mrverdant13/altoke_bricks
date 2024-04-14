import 'package:altoke_common/common.dart';
import 'package:test/test.dart';

void main() {
  test('noFilter always return true', () {
    expect(noFilter(null), true);
  });

  test('noIndexedFilter always return true', () {
    expect(noIndexedFilter(null, null), true);
  });
}
