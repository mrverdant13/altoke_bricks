import 'package:altoke_drift_local_database/src/local_database.drift.dart';
import 'package:drift/drift.dart';

/// {@template altoke_drift_local_database.local_database}
/// A local database.
/// {@endtemplate}
@DriftDatabase(
  include: {
    'tasks.drift',
  },
)
class LocalDatabase extends $LocalDatabase {
  /// {@macro altoke_drift_local_database.local_database}
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
