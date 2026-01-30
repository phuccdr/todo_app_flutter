import 'package:fpdart/fpdart.dart' hide Task;
import 'package:injectable/injectable.dart';
import 'package:todoapp/core/error/failure.dart';
import 'package:todoapp/domain/entities/task.dart';
import 'package:todoapp/domain/repositories/task_repository/task_repository.dart';

@injectable
class GetTaskByIdUsecase {
  final TaskRepository _taskRepo;
  const GetTaskByIdUsecase(this._taskRepo);
  Future<Either<Failure, Task?>> excute(String taskId) async {
    return _taskRepo.getTaskById(taskId);
  }
}
