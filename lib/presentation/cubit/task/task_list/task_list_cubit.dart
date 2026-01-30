import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/domain/entities/category.dart';
import 'package:todoapp/domain/entities/task.dart';
import 'package:todoapp/domain/usecase/fetch_categories_usecase.dart';
import 'package:todoapp/domain/usecase/fetch_tasks_usecase.dart';
import 'package:todoapp/domain/usecase/watch_categories_usecase.dart';
import 'package:todoapp/domain/usecase/watch_task_usecase.dart';
import 'package:todoapp/presentation/cubit/task/task_list/task_list_state.dart';
import 'package:todoapp/presentation/model/task_display.dart';

@injectable
class TaskListCubit extends Cubit<TaskListState> {
  final FetchTasksUsecase _fetchTasksUsecase;
  final FetchCategoriesUseCase _fetchCategoriesUseCase;
  final WatchTaskUsecase _watchTaskUsecase;
  final WatchCategoriesUsecase _watchCategoriesUsecase;
  StreamSubscription? _tasksSubscription;
  StreamSubscription? _categoriesSubscription;

  List<Task> _latestTasks = [];
  List<Category> _latestCategories = [];

  TaskListCubit(
    this._fetchTasksUsecase,
    this._fetchCategoriesUseCase,
    this._watchTaskUsecase,
    this._watchCategoriesUsecase,
  ) : super(const TaskListState());

  void init() {
    _tasksSubscription = _watchTaskUsecase.execute().listen(
      (either) => either.fold(
        (failure) => emit(state.copyWith(status: TaskListStatus.failure)),
        (tasks) {
          _latestTasks = tasks;
          _emitTaskDisplays();
        },
      ),
    );
    _categoriesSubscription = _watchCategoriesUsecase.execute().listen(
      (either) => either.fold(
        (failure) => emit(state.copyWith(status: TaskListStatus.failure)),
        (categories) {
          _latestCategories = categories;
          _emitTaskDisplays();
        },
      ),
    );
    _fecthCategories();
    _fetchTasks();
  }

  void _emitTaskDisplays() {
    final displays = _latestTasks.map((task) {
      Category? category;
      if (task.categoryId != null && task.categoryId!.isNotEmpty) {
        final found = _latestCategories
            .where((c) => c.id == task.categoryId)
            .toList();
        category = found.isNotEmpty ? found.first : null;
      }
      return TaskDisplay(task: task, category: category);
    }).toList();
    emit(
      state.copyWith(taskDisplays: displays, status: TaskListStatus.success),
    );
  }

  Future<void> _fetchTasks() async {
    emit(state.copyWith(status: TaskListStatus.syncing));
    final result = await _fetchTasksUsecase.execute();
    result.fold((failure) {
      emit(
        state.copyWith(
          status: TaskListStatus.initial,
          errorMessage: 'Dữ liệu chưa được sync!',
        ),
      );
    }, (_) {});
  }

  Future<void> _fecthCategories() async {
    emit(state.copyWith(status: TaskListStatus.syncing));
    final result = await _fetchCategoriesUseCase.execute();
    result.fold((faliure) {
      emit(
        state.copyWith(
          status: TaskListStatus.initial,
          errorMessage: 'Dữ liệu chưa được sync!',
        ),
      );
    }, (_) {});
  }

  Future<void> addTask(Task task) async {
    emit(state.copyWith(status: TaskListStatus.syncing));
  }

  Future<void> updateTask(Task task) async {
    //emit(state.copyWith(status: TaskListStatus.syncing));
  }

  Future<void> deleteTask(String taskId) async {
    emit(state.copyWith(status: TaskListStatus.syncing));
  }

  Future<void> toggleTaskStatus(String taskId) async {
    final display = state.tasks.firstWhere((d) => d.task.id == taskId);
    updateTask(display.task.copyWith(isCompleted: !display.task.isCompleted));
  }

  void updateSearchQuery(String? query) {
    emit(state.copyWith(searchQuery: query ?? ''));
  }

  @override
  Future<void> close() {
    _tasksSubscription?.cancel();
    _categoriesSubscription?.cancel();
    return super.close();
  }
}
