/*remove-start*/
import 'package:altoke_app/external/external.dart';
/*remove-end*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'async_initialization_pod.g.dart';

/*w 2v w*/
/*remove-start*/
// coverage:ignore-start
/*remove-end*/
@Riverpod(
  /*w 1v 2> w*/
  /*remove-start*/
  // coverage:ignore-end
  /*remove-end*/
  dependencies: [
    /*remove-start*/
    asyncApplicationDocumentsDirectory,
    asyncDriftLocalDatabase,
    asyncHiveInitialization,
    asyncIsar,
    /*remove-end*/
  ],
)
Future<void> asyncInitialization(Ref ref) async {
  // Run async initialization.
  /*remove-start*/
  // coverage:ignore-start
  await ref.watch(asyncApplicationDocumentsDirectoryPod.future);
  await ref.watch(asyncDriftLocalDatabasePod.future);
  await ref.watch(asyncApplicationDocumentsDirectoryPod.future);
  await ref.watch(asyncHiveInitializationPod.future);
  await ref.watch(asyncApplicationDocumentsDirectoryPod.future);
  await ref.watch(asyncIsarPod.future);
  // coverage:ignore-end
  /*remove-end*/
  /*w 1v w*/
}
