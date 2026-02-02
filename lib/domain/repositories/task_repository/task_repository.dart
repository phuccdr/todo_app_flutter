import 'package:fpdart/fpdart.dart' hide Task;
import 'package:todoapp/core/error/failure.dart';
import 'package:todoapp/domain/entities/task.dart';

abstract class TaskRepository {
  TaskEither<Failure, Unit> fetchTasksFromServer();
  Stream<Either<Failure, List<Task>>> watchTasks();
  TaskEither<Failure, Unit> insertTask(Task task);
  TaskEither<Failure, Unit> updateTask(Task task);
  TaskEither<Failure, Unit> deleteTask(Task task);
  TaskEither<Failure, Task?> getTaskById(String taskId);
}
