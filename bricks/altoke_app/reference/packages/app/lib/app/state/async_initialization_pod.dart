import 'package:altoke_app/external/external.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'async_initialization_pod.g.dart';

@Riverpod(
  dependencies: [
    /*{{#use_drift}}*/
    asyncApplicationDocumentsDirectory,
    asyncDriftLocalDatabase,
    /*{{/use_drift}}*/
    /*{{#use_isar}}*/
    asyncApplicationDocumentsDirectory,
    asyncIsar,
    /*{{/use_isar}}*/
  ],
)
Future<void> asyncInitialization(Ref ref) async {
  // Run async initialization.
  /*{{#use_drift}}*/
  await ref.watch(asyncApplicationDocumentsDirectoryPod.future);
  await ref.watch(asyncDriftLocalDatabasePod.future);
  /*{{/use_drift}}*/
  /*{{#use_isar}}*/
  await ref.watch(asyncApplicationDocumentsDirectoryPod.future);
  await ref.watch(asyncIsarPod.future);
  /*{{/use_isar}}*/
  /*w 1v w*/
}
