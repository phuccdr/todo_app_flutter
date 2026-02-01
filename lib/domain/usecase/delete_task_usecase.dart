import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/core/error/failure.dart';
import 'package:todoapp/domain/repositories/task_repository/task_repository.dart';

@injectable
class DeleteTaskUsecase {
  final TaskRepository _taskRepo;
  const DeleteTaskUsecase(this._taskRepo);
  Future<Either<Failure, void>> execute(String taskId) {
    return _taskRepo.deleteTask(taskId);
  }
}
