import 'package:element_in_memory_cache/element_in_memory_cache.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tasks/tasks.dart';

class MockLatestDeletedTaskCache extends Mock
    implements ElementInMemoryCache<Task> {}
