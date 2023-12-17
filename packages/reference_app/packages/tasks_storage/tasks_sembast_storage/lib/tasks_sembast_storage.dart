/// A persistent storage for tasks built on top of Sembast.
library tasks_sembast_storage;

export 'package:tasks_storage/tasks_storage.dart'
    show
        CreateTaskFailure,
        CreateTaskFailureEmptyTitle,
        TasksStorage,
        UpdateTaskFailure,
        UpdateTaskFailureEmptyTitle;

export 'src/tasks_sembast_storage.dart'
    show MigratingDatabase, MigrationCallback, TasksSembastStorage;
