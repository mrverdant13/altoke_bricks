import 'package:common/common.dart';
/*remove-start*/
import 'package:flutter/foundation.dart';
/*remove-end*/
import 'package:json_annotation/json_annotation.dart';
/*remove-start*/
import 'package:riverpod_annotation/riverpod_annotation.dart';

/*remove-end*/

/*{{#use_hive_database}}*/
export '_condition___use_hive_database___hive___.dart'; /*{{/use_hive_database}}*/
/*{{#use_realm_database}}*/
export '_condition___use_realm_database___realm___.dart'; /*{{/use_realm_database}}*/
/*{{#use_sembast_database}}*/
export '_condition___use_sembast_database___sembast___.dart'; /*{{/use_sembast_database}}*/

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

@Riverpod(dependencies: [])
DatabasePackage database(DatabaseRef ref) {
  throw UnimplementedError(
    'No database package has been provided. ',
  );
}
// coverage:ignore-end
