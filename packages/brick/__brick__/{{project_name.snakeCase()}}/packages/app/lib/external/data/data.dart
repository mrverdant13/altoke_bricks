import 'package:common/common.dart';import 'package:json_annotation/json_annotation.dart';{{#use_hive_database}}export 'hive.dart';{{/use_hive_database}}{{#use_isar_database}}export 'isar.dart';{{/use_isar_database}}{{#use_realm_database}}export 'realm.dart';{{/use_realm_database}}{{#use_sembast_database}}export 'sembast.dart';{{/use_sembast_database}}{{#use_sqlite_database}}export 'sqlite.dart';{{/use_sqlite_database}}part 'data.g.dart';

// coverage:ignore-start
@JsonLiteral('task.fakes.json')
Iterable<Json> get rawFakeTasks => _$rawFakeTasksJsonLiteral;
// coverage:ignore-end

