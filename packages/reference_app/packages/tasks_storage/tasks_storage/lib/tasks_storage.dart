/// An interface for a storage system for tasks.
library tasks_storage;

export 'src/failures/create_task.failure.dart'
    show CreateTaskFailure, CreateTaskFailureEmptyTitle;
export 'src/failures/update_task.failure.dart'
    show UpdateTaskFailure, UpdateTaskFailureEmptyTitle;
export 'src/tasks_storage.dart' show TasksStorage;
