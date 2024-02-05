import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_search_term.pod.g.dart';

@Riverpod(dependencies: [])
class TaskSearchTerm extends _$TaskSearchTerm {
  @override
  String build() {
    return '';
  }

  // ignore: avoid_setters_without_getters
  set searchTerm(String value) {
    state = value;
  }
}
