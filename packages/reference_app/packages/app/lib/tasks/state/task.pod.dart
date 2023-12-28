import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tasks/tasks.dart';

part 'task.pod.g.dart';

@Riverpod(dependencies: [])
Task task(TaskRef ref) {
  throw UnimplementedError(
    '`taskPod` was not initialized.',
  );
}
