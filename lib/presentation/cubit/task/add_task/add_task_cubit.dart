import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/core/utils/validator/not_null_validator.dart';
import 'package:todoapp/core/utils/validator/text_input_validator.dart';
import 'package:todoapp/domain/entities/category.dart';
import 'package:todoapp/domain/entities/priority.dart';
import 'package:todoapp/domain/entities/task.dart';
import 'package:todoapp/domain/usecase/get_task_by_id_usecase.dart';
import 'package:todoapp/domain/usecase/insert_task_usecase.dart';
import 'package:todoapp/presentation/cubit/task/add_task/add_task_state.dart';

@injectable
class AddTaskCubit extends Cubit<AddTaskState> {
  final InsertTaskUsecase _insertTaskUsecase;
  final GetTaskByIdUsecase _getTaskByIdUsecase;
  AddTaskCubit(this._insertTaskUsecase, this._getTaskByIdUsecase)
    : super(const AddTaskState());

  void onTitleChanged(String value) {
    final titleValidator = TextInputValidator.dirty(value);
    emit(
      state.copyWith(
        titleValidator: titleValidator,
        isValid: Formz.validate([state.titleValidator]),
      ),
    );
  }

  void onDescriptionChanged(String value) {
    final descriptionValidator = TextInputValidator.dirty(value);
    emit(state.copyWith(descriptionValidator: descriptionValidator));
  }

  void onTimeTaskChanged(DateTime value) {
    final timeTaskValidator = NotNullValidator<DateTime>.dirty(value);
    emit(state.copyWith(timeTaskValidator: timeTaskValidator));
  }

  void onPriorityChanged(Priority value) {
    final priorityValidator = NotNullValidator<Priority>.dirty(value);
    emit(state.copyWith(priorityValidator: priorityValidator));
  }

  void onCategoryChanged(Category value) {
    final categoryValidator = NotNullValidator<Category>.dirty(value);
    emit(state.copyWith(categoryValidator: categoryValidator));
  }

  void onSubmit() async {
    if (state.isValid) {
      final newTask = Task(
        title: state.titleValidator.value,
        description: state.descriptionValidator.value,
        taskTime: state.timeTaskValidator.value,
        categoryId: state.categoryValidator.value?.id,
        priority: state.priorityValidator.value,
      );
      emit(const AddTaskState(status: FormzSubmissionStatus.inProgress));
      final result = await _insertTaskUsecase.execute(newTask);
      result.fold(
        (e) {
          emit(state.copyWith(status: FormzSubmissionStatus.failure));
        },
        (_) {
          emit(state.copyWith(status: FormzSubmissionStatus.success));
        },
      );
    }
    return;
  }

  void getTaskById(String taskId) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final result = await _getTaskByIdUsecase.excute(taskId);
    result.fold(
      (e) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      },
      (task) {
        emit(state.copyWith(initial: task));
      },
    );
  }

  void reset() async {}
}
