import 'package:todoapp/domain/entities/category.dart';
import 'package:todoapp/domain/entities/task.dart';

class TaskDisplay {
  final Task task;
  final Category? category;

  const TaskDisplay({required this.task, this.category});
  TaskDisplay copyWith({Task? task, Category? category}) {
    return TaskDisplay(
      task: task ?? this.task,
      category: category ?? this.category,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskDisplay &&
          task == other.task &&
          category == other.category;

  @override
  int get hashCode => Object.hash(task, category);
}
