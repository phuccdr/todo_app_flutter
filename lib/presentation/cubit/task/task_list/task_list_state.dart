import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/presentation/model/task_display.dart';

enum TaskListStatus { initial, loading, success, failure, syncing }

@injectable
class TaskListState extends Equatable {
  final List<TaskDisplay> tasks;
  final TaskListStatus status;
  final String? errorMessage;
  final String? searchQuery;

  List<TaskDisplay> get filteredTasks {
    final query = searchQuery?.trim().toLowerCase();
    if (query == null || query.isEmpty) return tasks;

    return tasks.where((task) {
      return task.task.title.toLowerCase().contains(query) ||
          (task.category?.name.toLowerCase().contains(query) ?? false);
    }).toList();
  }

  const TaskListState({
    this.tasks = const [],
    this.status = TaskListStatus.initial,
    this.errorMessage,
    this.searchQuery,
  });

  TaskListState copyWith({
    List<TaskDisplay>? taskDisplays,
    TaskListStatus? status,
    String? errorMessage,
    String? searchQuery,
  }) {
    return TaskListState(
      tasks: taskDisplays ?? tasks,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [tasks, status, errorMessage, searchQuery];
}
