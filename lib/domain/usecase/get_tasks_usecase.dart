import 'package:fpdart/fpdart.dart' hide Task;
import 'package:injectable/injectable.dart';
import 'package:todoapp/core/error/failure.dart';
import 'package:todoapp/domain/entities/task.dart';
import 'package:todoapp/domain/repositories/task_repository/task_repository.dart';

@injectable
class GetTasksUsecase {
  final TaskRepository _taskRepository;
  GetTasksUsecase(this._taskRepository);
  Stream<Either<Failure, List<Task>>> execute() {
    return _taskRepository.getTasks();
  }
}
