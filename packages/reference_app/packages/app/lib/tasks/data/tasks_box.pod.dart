import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tasks_box.pod.g.dart';

@Riverpod(dependencies: [])
Box<Map<dynamic, dynamic>> tasksBox(TasksBoxRef ref) {
  throw UnimplementedError(
    '`tasksBoxPod` was not initialized.',
  );
}
