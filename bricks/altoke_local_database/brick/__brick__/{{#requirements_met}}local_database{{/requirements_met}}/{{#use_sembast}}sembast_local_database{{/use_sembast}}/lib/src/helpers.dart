import 'package:sembast/sembast.dart';

/// A reference to a tasks store.
typedef TasksStoreRef = StoreRef<int, Map<String, Object?>>;

/// The JSON metadata for the JSON representation of a task.
abstract class Task {
  /// JSON key for the title of a task.
  static const titleJsonKey = 'title';

  /// JSON key for the priority of a task.
  static const priorityJsonKey = 'priority';

  /// JSON key for the completed status of a task.
  static const completedJsonKey = 'completed';

  /// JSON key for the description of a task.
  static const descriptionJsonKey = 'description';
}
