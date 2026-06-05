import 'package:altoke_app/routing/routing.dart';

class FakeSelectedRouterPackage extends SelectedRouterPackage {
  FakeSelectedRouterPackage({
    required this._initialValue,
  });

  final RouterPackage _initialValue;

  @override
  RouterPackage build() {
    return _initialValue;
  }
}
