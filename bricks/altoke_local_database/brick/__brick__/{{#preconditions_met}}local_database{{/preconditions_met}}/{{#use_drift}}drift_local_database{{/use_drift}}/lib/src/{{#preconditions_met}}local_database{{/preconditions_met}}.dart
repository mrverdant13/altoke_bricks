import 'package:drift/drift.dart';
import 'package:{{#use_drift}}drift_local_database{{/use_drift}}/src/{{#preconditions_met}}local_database{{/preconditions_met}}.drift.dart';

/// {@template {{#use_drift}}drift_local_database{{/use_drift}}.{{#preconditions_met}}local_database{{/preconditions_met}}}
/// A local database.
/// {@endtemplate}
@DriftDatabase(
  include: {
    'tasks.drift',
  },
)
class LocalDatabase extends $LocalDatabase {
  /// {@macro {{#use_drift}}drift_local_database{{/use_drift}}.{{#preconditions_met}}local_database{{/preconditions_met}}}
  LocalDatabase({
    required QueryExecutor queryExecutor,
    required this.schemaVersion,
    MigrationStrategy? migration,
  })  : migration = migration ?? MigrationStrategy(),
        super(queryExecutor);

  @override
  final int schemaVersion;

  @override
  final MigrationStrategy migration;
}
