import 'package:fpdart/fpdart.dart' hide Task;
import 'package:injectable/injectable.dart';
import 'package:todoapp/core/error/failure.dart';
import 'package:todoapp/domain/repositories/task_repository/task_repository.dart';

@injectable
class FetchTasksUsecase {
  final TaskRepository _taskRepository;
  FetchTasksUsecase(this._taskRepository);
  Future<Either<Failure, void>> execute() {
    return _taskRepository.fetchTasksFromServer();
  }
}
