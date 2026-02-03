import 'package:fpdart/fpdart.dart' hide Task;
import 'package:injectable/injectable.dart';
import 'package:todoapp/core/error/failure.dart';
import 'package:todoapp/data/datasource/local/local_data_source/task_local_datasource.dart';
import 'package:todoapp/data/datasource/remote/task_remote_datasource.dart';
import 'package:todoapp/data/models/task_model.dart';
import 'package:todoapp/domain/entities/task.dart';
import 'package:todoapp/domain/repositories/task_repository/task_repository.dart';
import 'package:uuid/uuid.dart';

@LazySingleton(as: TaskRepository)
class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDatasource _localDataSource;
  final TaskRemoteDatasource _remoteDatasource;
  final uuid = Uuid();

  TaskRepositoryImpl(this._localDataSource, this._remoteDatasource);

  @override
  TaskEither<Failure, Unit> fetchTasksFromServer() {
    return TaskEither.Do(($) async {
      final remoteTasks = await $(
        TaskEither.tryCatch(
          () => _remoteDatasource.getTasks(),
          (e, _) => Failure(message: e.toString()),
        ),
      );

      await $(
        TaskEither.tryCatch(
          () => _localDataSource.insertTasks(remoteTasks),
          (e, _) => Failure(message: e.toString()),
        ),
      );

      return unit;
    });
  }

  @override
  Stream<Either<Failure, List<Task>>> watchTasks() {
    return _localDataSource.watchTasks().map(
      (tasks) => Right(tasks.map((t) => t.toEntity()).toList()),
    );
  }

  @override
  TaskEither<Failure, Unit> insertTask(Task task) {
    return TaskEither.Do(($) async {
      final taskId = uuid.v4();
      final taskModel = TaskModel.fromEntity(
        task.copyWith(id: taskId.toString()),
      );
      await $(
        TaskEither.tryCatch(
          () => _localDataSource.upsertTask(taskModel),
          (e, _) => Failure(message: e.toString()),
        ),
      );
      await $(
        TaskEither.tryCatch(
          () => _remoteDatasource.insertTask(taskModel),
          (e, _) => Failure(message: e.toString()),
        ),
      );
      return unit;
    });
  }

  @override
  TaskEither<Failure, Unit> updateTask(Task task) {
    final taskModel = TaskModel.fromEntity(task);

    return TaskEither.Do(($) async {
      await $(
        TaskEither.tryCatch(
          () => _localDataSource.upsertTask(taskModel),
          (e, _) => Failure(message: e.toString()),
        ),
      );

      await $(
        TaskEither.tryCatch(
          () => _remoteDatasource.updateTask(taskModel),
          (e, _) => Failure(message: e.toString()),
        ),
      );
      return unit;
    });
  }

  @override
  TaskEither<Failure, Unit> deleteTask(Task task) {
    return TaskEither.Do(($) async {
      await $(
        TaskEither.tryCatch(
          () => _localDataSource.deleteTask(task.id),
          (e, _) => Failure(message: e.toString()),
        ),
      );
      final remoteId = task.remoteId;
      if (remoteId != null) {
        await $(
          TaskEither.tryCatch(
            () => _remoteDatasource.deleteTask(remoteId),
            (e, _) => Failure(message: e.toString()),
          ),
        );
      }
      return unit;
    });
  }

  @override
  TaskEither<Failure, Task?> getTaskById(String taskId) {
    return TaskEither.tryCatch(() async {
      final taskModel = await _localDataSource.getTaskById(taskId);
      return taskModel?.toEntity();
    }, (e, _) => Failure(message: e.toString()));
  }
}
