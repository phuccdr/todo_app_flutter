import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:todoapp/data/datasource/local/tables/categories.dart';
import 'package:todoapp/data/datasource/local/tables/tasks.dart';
import 'package:todoapp/domain/entities/sync_status.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Categories, Tasks])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        await m.deleteTable('tasks');
        await m.createTable(tasks);
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'todoapp.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
