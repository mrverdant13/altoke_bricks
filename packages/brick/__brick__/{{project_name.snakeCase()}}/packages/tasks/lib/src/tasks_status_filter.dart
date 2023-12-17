/// A filter for tasks based on their status.
enum TasksStatusFilter {
  /// All tasks.
  ///
  /// No filtering is applied.
  all,

  /// Uncompleted tasks.
  ///
  /// Completed tasks are filtered out.
  uncompleted,

  /// Completed tasks.
  ///
  /// Uncompleted tasks are filtered out.
  completed,
  ;
}
