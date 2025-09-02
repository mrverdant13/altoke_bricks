import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'directories_pods.g.dart';

@Riverpod(dependencies: [])
Future<Directory> asyncApplicationDocumentsDirectory(Ref ref) async {
  return getApplicationDocumentsDirectory();
}

@Riverpod(dependencies: [])
Future<Directory> asyncTemporaryDirectory(Ref ref) async {
  return getTemporaryDirectory();
}
