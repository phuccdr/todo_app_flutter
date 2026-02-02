import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/data/models/task_model.dart';

@LazySingleton()
class TaskRemoteDatasource {
  final Dio _dio;
  TaskRemoteDatasource(this._dio);
  Future<List<TaskModel>> getTasks() async {
    final response = await _dio.get('/tasks');
    return (response.data as List)
        .map((json) => TaskModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> updateTask(TaskModel task) {
    return _dio.put('/tasks/${task.remoteId}', data: task.toJson());
  }

  Future<void> deleteTask(String taskId) {
    return _dio.delete('/tasks/$taskId');
  }

  Future<void> insertTask(TaskModel task) {
    return _dio.post('/tasks', data: task.toJson());
  }
}
