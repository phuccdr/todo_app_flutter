import 'package:fpdart/fpdart.dart' hide Task;
import 'package:todoapp/core/error/failure.dart';
import 'package:todoapp/domain/entities/task.dart';
import 'package:todoapp/domain/repositories/task_repository/task_repository.dart';

class WatchTaskUsecase {
  final TaskRepository _taskRepository;
  WatchTaskUsecase(this._taskRepository);
  Stream<Either<Failure, List<Task>>> execute() {
    return _taskRepository.watchTasks();
  }
}
