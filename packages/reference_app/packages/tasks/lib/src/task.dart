import 'package:common/common.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';

/// {@template task}
/// A task.
/// {@endtemplate}
@freezed
class Task with _$Task {
  /// {@macro task}
  const factory Task({
    /// The task ID.
    required String id,

    /// The task title.
    required String title,

    /// Whether the task is completed.
    required bool isCompleted,

    /// The task creation date.
    required DateTime createdAt,

    /// The task description.
    String? description,
  }) = _Task;
}

/// {@template new_task}
/// A new task.
/// {@endtemplate}
@freezed
class NewTask with _$NewTask {
  /// {@macro new_task}
  const factory NewTask({
    /// The new task title.
    required String title,

    /// Whether the new task is completed.
    @Default(false) bool isCompleted,

    /// The new task description.
    String? description,
  }) = _NewTask;
}

/// {@template partial_task}
/// A partial task.
/// {@endtemplate}
@freezed
class PartialTask with _$PartialTask {
  /// {@macro partial_task}
  const factory PartialTask({
    /// The optional task title setter.
    PartialSetter<String>? title,

    /// The optional task completed setter.
    PartialSetter<bool>? isCompleted,

    /// The optional task description setter.
    PartialSetter<String?>? description,
  }) = _PartialTask;
}
