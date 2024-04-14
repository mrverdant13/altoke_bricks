const fakeCommonPackageFiles = {
  'common/pubspec.yaml': '''
name: common
version: 0.0.1
environment:
  sdk: '>=3.0.0 <4.0.0'
''',
  'common/lib/common.dart': '''
typedef UpdateCallback<T> = T Function(T element);
typedef WhereCallback<T> = bool Function(T element);
typedef WhereIndexedCallback<T> = bool Function(int index, T element);

bool noFilter(_) => true;
bool noIndexedFilter(_, __) => true;

typedef IndexedIterable<E> = Iterable<(int, E)>;
''',
};
