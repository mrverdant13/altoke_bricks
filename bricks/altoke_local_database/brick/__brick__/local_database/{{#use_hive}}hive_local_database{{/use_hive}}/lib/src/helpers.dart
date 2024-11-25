import 'package:hive/hive.dart';

/// The box for tasks.
typedef TasksBox = Box<Map<dynamic, dynamic>>;

/// The JSON metadata for the JSON representation of a task.
abstract class Task {
  /// JSON key for the title of a Hive Task.
  static const titleJsonKey = 'title';

  /// JSON key for the priority of a Hive Task.
  static const priorityJsonKey = 'priority';

  /// JSON key for the completed status of a Hive Task.
  static const completedJsonKey = 'completed';

  /// JSON key for the description of a Hive Task.
  static const descriptionJsonKey = 'description';
}
