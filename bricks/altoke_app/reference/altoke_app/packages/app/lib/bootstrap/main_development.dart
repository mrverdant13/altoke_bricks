import 'package:altoke_app/app/app.dart';
import 'package:altoke_app/bootstrap/bootstrap.dart';
import 'package:altoke_app/routing/routing.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([
  routerConfig,
  asyncInitialization,
  /*x-remove-start*/
  SelectedRouterPackage,
  /*remove-end*/
])
Future<void> main() async {
  await bootstrap();
}
