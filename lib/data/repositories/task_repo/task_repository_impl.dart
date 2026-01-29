import 'package:fpdart/fpdart.dart' hide Task;
import 'package:injectable/injectable.dart';
import 'package:todoapp/core/error/failure.dart';
import 'package:todoapp/data/datasource/local/local_data_source/task_local_datasource.dart';
import 'package:todoapp/data/datasource/remote/task_remote_datasource.dart';
import 'package:todoapp/data/models/task_model.dart';
import 'package:todoapp/domain/entities/task.dart';
import 'package:todoapp/domain/repositories/task_repository/task_repository.dart';

@LazySingleton(as: TaskRepository)
class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDatasource _localDataSource;
  final TaskRemoteDatasource _remoteDatasource;

  TaskRepositoryImpl(this._localDataSource, this._remoteDatasource);

  @override
  Future<Either<Failure, void>> fetchTasksFromServer() async {
    try {
      final remoteTasks = await _remoteDatasource.getTasks();
      await _localDataSource.insertTasks(remoteTasks);
      return Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<Task>>> watchTasks() {
    return _localDataSource.watchTasks().map(
      (tasks) => Right(tasks.map((t) => t.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failure, void>> insertTask(Task task) async {
    try {
      final taskModel = TaskModel.fromEntity(task);
      await _localDataSource.upsertTask(taskModel);
      await _remoteDatasource.insertTask(taskModel);
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateTask(Task task) async {
    try {
      final taskModel = TaskModel.fromEntity(task);
      await _localDataSource.upsertTask(taskModel);
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(String taskId) async {
    try {
      await _localDataSource.deleteTask(taskId);
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task?>> getTaskById(String taskId) async {
    try {
      final taskModel = await _localDataSource.getTaskById(taskId);
      return Right(taskModel?.toEntity());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
