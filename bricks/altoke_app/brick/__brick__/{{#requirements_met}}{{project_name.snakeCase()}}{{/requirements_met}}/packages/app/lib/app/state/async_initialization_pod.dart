import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'async_initialization_pod.g.dart';

@Riverpod(
  dependencies: [],
)
Future<void> asyncInitialization(Ref ref) async {
  // Run async initialization.
}
