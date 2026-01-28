import 'package:drift/drift.dart';
import 'package:todoapp/data/datasource/local/tables/categories.dart';
import 'package:todoapp/domain/entities/sync_status.dart';

class Tasks extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  DateTimeColumn get taskTime => dateTime()();
  TextColumn get categoryId => text().references(Categories, #id)();
  IntColumn get priority => integer().withDefault(const Constant(1))();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createAt => dateTime().withDefault(currentDate)();
  DateTimeColumn get updateAt => dateTime().withDefault(currentDate)();
  IntColumn get syncStatus =>
      intEnum<SyncStatus>().withDefault(const Constant(2))();

  @override
  Set<Column> get primaryKey => {id};
}
