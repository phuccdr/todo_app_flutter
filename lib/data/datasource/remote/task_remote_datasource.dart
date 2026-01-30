import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/core/error/failure.dart';
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

  Future<void> updateTask(TaskModel task) async {
    await _dio.put('/tasks/${task.id}', data: task.toJson());
  }

  Future<Either<Failure, void>> insertTask(TaskModel task) async {
    try {
      await _dio.post('/tasks', data: task.toJson());
      return Right(null);
    } catch (e) {
      return Left(Failure());
    }
  }
}
