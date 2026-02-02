import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/core/utils/validator/not_null_validator.dart';
import 'package:todoapp/core/utils/validator/text_input_validator.dart';
import 'package:todoapp/domain/entities/category.dart';
import 'package:todoapp/domain/entities/priority.dart';
import 'package:todoapp/domain/entities/task.dart';
import 'package:todoapp/domain/usecase/delete_task_usecase.dart';
import 'package:todoapp/domain/usecase/get_category_by_id_usecase.dart';
import 'package:todoapp/domain/usecase/get_task_by_id_usecase.dart';
import 'package:todoapp/domain/usecase/insert_task_usecase.dart';
import 'package:todoapp/domain/usecase/update_task_usecase.dart';
import 'package:todoapp/presentation/cubit/task/add_task/add_task_state.dart';
import 'package:todoapp/presentation/model/task_display.dart';

@injectable
class AddTaskCubit extends Cubit<AddTaskState> {
  final InsertTaskUsecase _insertTaskUsecase;
  final GetTaskByIdUsecase _getTaskByIdUsecase;
  final GetCategoryByIdUsecase _getCategoryByIdUsecase;
  final DeleteTaskUsecase _deleteTaskUsecase;
  final UpdateTaskUsecase _updateTaskUsecase;

  AddTaskCubit(
    this._insertTaskUsecase,
    this._getTaskByIdUsecase,
    this._getCategoryByIdUsecase,
    this._deleteTaskUsecase,
    this._updateTaskUsecase,
  ) : super(const AddTaskState());

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

  void onUpdateTimeTask(DateTime value) {
    final updatedTask = state.initialTask?.task.copyWith(taskTime: value);
    emit(
      state.copyWith(initial: state.initialTask?.copyWith(task: updatedTask)),
    );
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

  Future<void> getTaskById(String taskId) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    final result = await _getTaskByIdUsecase.excute(taskId);
    final task = result.fold((_) => null, (t) => t);
    if (task == null) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
      return;
    }

    Category? category;
    final categoryId = task.categoryId;
    if (categoryId != null && categoryId.isNotEmpty) {
      final categoryResult = await _getCategoryByIdUsecase.excute(categoryId);
      category = categoryResult.fold((_) => null, (c) => c);
    }

    final taskDisplay = TaskDisplay(task: task, category: category);
    emit(
      state.copyWith(
        status: FormzSubmissionStatus.initial,
        initial: taskDisplay,
        initialTaskSnapshot: taskDisplay,
      ),
    );
  }

  void onUpdateTileTask(String title, String description) {
    final updatedTask = state.initialTask?.task.copyWith(
      title: title,
      description: description,
    );
    final updatedDisplayTask = state.initialTask?.copyWith(task: updatedTask);
    emit(state.copyWith(initial: updatedDisplayTask));
  }

  void onUpdateCategoryTask(Category? category) {
    final updatedTask = state.initialTask?.task.copyWith(
      categoryId: category?.id,
    );
    final updatedTaskDisplay = state.initialTask?.copyWith(
      category: category,
      task: updatedTask,
    );
    emit(state.copyWith(initial: updatedTaskDisplay));
  }

  void onUpdatePriorityTask(Priority? priority) {
    final updatedTask = state.initialTask?.task.copyWith(priority: priority);
    final updatedDisplayTask = state.initialTask?.copyWith(task: updatedTask);
    emit(state.copyWith(initial: updatedDisplayTask));
  }

  Future<void> onEditTask() async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final task = state.initialTask?.task;
    if (task == null || task.id.isEmpty) return;

    final currentDisplay = state.initialTask;
    final initialSnapshot = state.initialTaskSnapshot;
    if (currentDisplay == initialSnapshot) {
      emit(state.copyWith(status: FormzSubmissionStatus.success));
      return;
    }

    final result = await _updateTaskUsecase.execute(task);
    result.fold(
      (_) => emit(state.copyWith(status: FormzSubmissionStatus.failure)),
      (_) => emit(state.copyWith(status: FormzSubmissionStatus.success)),
    );
  }

  Future<void> deleteTask(String taskId) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final result = await _deleteTaskUsecase.execute(taskId);
    result.fold(
      (_) => emit(state.copyWith(status: FormzSubmissionStatus.failure)),
      (_) => emit(state.copyWith(status: FormzSubmissionStatus.success)),
    );
  }

  void reset() async {}
}
