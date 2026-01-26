import 'dart:core';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/domain/entities/task.dart';
import 'package:todoapp/presentation/cubit/task/task_list/task_list_state.dart';

@injectable
class TaskListCubit extends Cubit<TaskListState> {
  TaskListCubit(super.initialState);
  Future<void> loadTasks() async {
    emit(state.copyWith(status: TaskListStatus.loading));
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
