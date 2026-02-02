import 'package:fpdart/fpdart.dart' hide Task;
import 'package:injectable/injectable.dart';
import 'package:todoapp/core/error/failure.dart';
import 'package:todoapp/domain/entities/task.dart';
import 'package:todoapp/domain/repositories/task_repository/task_repository.dart';

@injectable
class DeleteTaskUsecase {
  final TaskRepository _taskRepo;
  const DeleteTaskUsecase(this._taskRepo);
  Future<Either<Failure, void>> execute(Task task) {
    return _taskRepo
        .deleteTask(task)
        .run()
        .then((either) => either.map((_) {}));
  }
}
