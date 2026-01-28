import 'dart:async';
import 'dart:core';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/domain/entities/task.dart';
import 'package:todoapp/domain/usecase/get_tasks_usecase.dart';
import 'package:todoapp/domain/usecase/watch_task_usecase.dart';
import 'package:todoapp/presentation/cubit/task/task_list/task_list_state.dart';

@injectable
class TaskListCubit extends Cubit<TaskListState> {
  final GetTasksUsecase _getTasksUsecase;
  final WatchTaskUsecase _watchTaskUsecase;
  StreamSubscription? _subscription;

  TaskListCubit(this._getTasksUsecase, this._watchTaskUsecase)
    : super(const TaskListState());

  Future<void> loadTasks() async {
    emit(state.copyWith(status: TaskListStatus.loading));
    _subscription = _getTasksUsecase.execute().listen((either) {
      either.fold(
        (failure) {
          emit(state.copyWith(status: TaskListStatus.failure));
        },
        (tasks) {
          emit(state.copyWith(tasks: tasks, status: TaskListStatus.success));
        },
      );
    });
  }

  Future<void> addTask(Task task) async {
    emit(state.copyWith(status: TaskListStatus.syncing));
  }

  Future<void> updateTask(Task task) async {
    emit(state.copyWith(status: TaskListStatus.syncing));
  }

  Future<void> deleteTask(String taskId) async {
    emit(state.copyWith(status: TaskListStatus.syncing));
  }

  Future<void> toggleTaskStatus(String taskId) async {
    final task = state.tasks.firstWhere((task) => task.id == taskId);
    updateTask(task.copyWith(isCompleted: !task.isCompleted));
  }
}
