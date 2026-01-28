import 'package:drift/drift.dart';
import 'package:todoapp/core/database/app_database.dart';
import 'package:todoapp/data/datasource/local/tables/tasks.dart';

part 'task_dao.g.dart';

@DriftAccessor(tables: [Tasks])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  TaskDao(super.db);

  Future<List<Task>> getAllTasks() => select(tasks).get();

  Future<Task?> getTaskById(String taskId) {
    return (select(
      tasks,
    )..where((task) => task.id.equals(taskId))).getSingleOrNull();
  }

  Future<void> upsertTask(TasksCompanion task) {
    return into(tasks).insertOnConflictUpdate(task);
  }

  Future<void> upsertTasks(List<TasksCompanion> taskList) {
    return batch((batch) {
      batch.insertAllOnConflictUpdate(tasks, taskList);
    });
  }

  Future<int> deleteTaskById(String taskId) {
    return (delete(tasks)..where((t) => t.id.equals(taskId))).go();
  }

  Stream<List<Task>> watchTasks() {
    return select(tasks).watch();
  }
}
