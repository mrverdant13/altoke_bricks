/*remove-start*/
import 'package:altoke_app/external/external.dart';
/*remove-end*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'async_initialization_pod.g.dart';

@Riverpod(
  dependencies: [
    /*remove-start*/
    asyncApplicationDocumentsDirectory,
    asyncDriftLocalDatabase,
    asyncIsar,
    /*remove-end*/
  ],
)
Future<void> asyncInitialization(Ref ref) async {
  // Run async initialization.
  /*remove-start*/
  await ref.watch(asyncApplicationDocumentsDirectoryPod.future);
  await ref.watch(asyncDriftLocalDatabasePod.future);
  await ref.watch(asyncApplicationDocumentsDirectoryPod.future);
  await ref.watch(asyncIsarPod.future);
  /*remove-end*/
  /*w 1v w*/
}
