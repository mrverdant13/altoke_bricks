import 'package:drift_local_database/drift_local_database.dart';
import 'package:isar/isar.dart';
import 'package:mocktail/mocktail.dart';

class MockIsar extends Mock implements Isar {}

class MockLocalDatabase extends Mock implements LocalDatabase {}

class MockTasksDrift extends Mock implements TasksDrift {}
