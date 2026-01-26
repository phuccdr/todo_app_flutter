import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/domain/entities/task.dart';

enum TaskListStatus { initial, loading, success, failure, syncing }

@injectable
class TaskListState extends Equatable {
  final List<Task> tasks;
  final TaskListStatus status;
  final String? errorMessage;

  const TaskListState({
    this.tasks = const [],
    this.status = TaskListStatus.initial,
    this.errorMessage,
  });

  TaskListState copyWith({
    List<Task>? tasks,
    TaskListStatus? status,
    String? errorMessage,
  }) {
    return TaskListState(
      tasks: tasks ?? this.tasks,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [tasks, status, errorMessage];
}
