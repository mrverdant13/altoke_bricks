/*x-remove-start*/
import 'package:altoke_app/external/external.dart';
/*remove-end-x*/
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'async_initialization_pod.g.dart';

/*replace-start*/
// coverage:ignore-start
@Riverpod(
  dependencies: [
    asyncApplicationDocumentsDirectory,
    asyncTemporaryDirectory,
    asyncDriftLocalDatabase,
    asyncHiveInitialization,
  ],
)
// coverage:ignore-end
/*with*/
// @Riverpod(dependencies: [])
/*replace-end*/
Future<void> asyncInitialization(Ref ref) async {
  // Run async initialization.
  /*x-remove-start*/
  // coverage:ignore-start
  if (!kIsWeb) {
    await ref.watch(asyncApplicationDocumentsDirectoryPod.future);
    await ref.watch(asyncTemporaryDirectoryPod.future);
  }
  await ref.watch(asyncDriftLocalDatabasePod.future);
  await ref.watch(asyncHiveInitializationPod.future);
  // coverage:ignore-end
  /*remove-end*/
}
