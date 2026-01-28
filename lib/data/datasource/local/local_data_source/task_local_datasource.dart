import 'package:injectable/injectable.dart';
import 'package:todoapp/data/datasource/local/dao/task/task_dao.dart';
import 'package:todoapp/data/models/task_model.dart';

@LazySingleton()
class TaskLocalDatasource {
  final TaskDao _taskDao;
  const TaskLocalDatasource(this._taskDao);

  Future<List<TaskModel>> getTasks() async {
    final resultTasks = await _taskDao.getAllTasks();
    return resultTasks.map((t) => TaskModel.fromDrift(t)).toList();
  }

  Future<TaskModel?> getTaskById(String taskId) async {
    final task = await _taskDao.getTaskById(taskId);
    return task != null ? TaskModel.fromDrift(task) : null;
  }

  Future<void> upsertTask(TaskModel taskModel) async {
    await _taskDao.upsertTask(taskModel.toDriftCompanion());
  }

  Future<void> insertTasks(List<TaskModel> tasks) async {
    final companions = tasks.map((t) => t.toDriftCompanion()).toList();
    await _taskDao.upsertTasks(companions);
  }

  Future<void> deleteTask(String taskId) async {
    await _taskDao.deleteTaskById(taskId);
  }

  Stream<List<TaskModel>> watchTasks() {
    return _taskDao.watchTasks().map(
      (driftTasks) => driftTasks.map((t) => TaskModel.fromDrift(t)).toList(),
    );
  }
}
