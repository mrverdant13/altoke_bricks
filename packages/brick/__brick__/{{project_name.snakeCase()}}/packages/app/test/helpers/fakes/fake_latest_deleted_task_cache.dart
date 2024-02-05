import 'package:element_in_memory_cache/element_in_memory_cache.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tasks/tasks.dart';

class FakeLatestDeletedTaskCache extends Fake
    implements ElementInMemoryCache<Task> {}
