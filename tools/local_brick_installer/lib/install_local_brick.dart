import 'dart:io';

import 'package:monorepo_elements/monorepo_elements.dart';

Future<void> main(List<String> args) async {
  final brickPath = Vars.brickPath;
  final brickName = Vars.brickName;
  final fullCommand = 'mason add -g $brickName --path $brickPath';
  final [command, ...arguments] = fullCommand.split(' ');
  await Process.run(command, arguments);
}
