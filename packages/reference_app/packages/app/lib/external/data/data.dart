import 'package:common/common.dart';
/*remove-start*/
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
/*remove-end*/
import 'package:json_annotation/json_annotation.dart';

/*{{#use_hive_database}}*/
export '_condition_._use_hive_database_._hive_._.dart'; /*{{/use_hive_database}}*/
/*{{#use_realm_database}}*/
export '_condition_._use_realm_database_._realm_._.dart'; /*{{/use_realm_database}}*/
/*{{#use_sembast_database}}*/
export '_condition_._use_sembast_database_._sembast_._.dart'; /*{{/use_sembast_database}}*/

part 'data.g.dart';

// coverage:ignore-start
@JsonLiteral('task.fakes.json')
Iterable<Json> get rawFakeTasks => _$rawFakeTasksJsonLiteral;
// coverage:ignore-end

/*drop*/
// coverage:ignore-start
enum DatabasePackage {
  hive('hive'),
  realm('realm'),
  sembast('sembast'),
  ;

  const DatabasePackage(this.identifier);

  final String identifier;

  static final fromEnv = DatabasePackage.values.firstWhere(
    (routerPackage) => routerPackage.identifier == databaseIdentifier,
  );
}

@visibleForTesting
const databaseIdentifier = String.fromEnvironment('REF_ALTOKE_DATABASE');

final databasePod = Provider<DatabasePackage>(
  (_) => throw UnimplementedError(
    'No database package has been provided. ',
  ),
  name: 'databasePod',
  dependencies: const [],
);
// coverage:ignore-end
