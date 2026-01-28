import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/data/models/task_model.dart';

@LazySingleton()
class TaskRemoteDatasource {
  final Dio _dio;
  TaskRemoteDatasource(this._dio);

  Future<List<TaskModel>> getTasks() async {
    final response = await _dio.get('/task');
    return (response.data as List)
        .map((json) => TaskModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> updateTask(TaskModel task) async {
    await _dio.put('/task/${task.id}', data: task.toJson());
  }

  Future<void> insertTask(TaskModel task) async {
    await _dio.post('/task', data: task.toJson());
  }
}
