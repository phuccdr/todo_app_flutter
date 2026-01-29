import 'package:fpdart/fpdart.dart' hide Task;
import 'package:todoapp/core/error/failure.dart';
import 'package:todoapp/domain/entities/task.dart';

abstract class TaskRepository {
  Future<Either<Failure, void>> fetchTasksFromServer();
  Stream<Either<Failure, List<Task>>> watchTasks();
  Future<Either<Failure, void>> insertTask(Task task);
  Future<Either<Failure, void>> updateTask(Task task);
  Future<Either<Failure, void>> deleteTask(String taskId);
  Future<Either<Failure, Task?>> getTaskById(String taskId);
}
