import 'package:todoapp/domain/entities/category.dart';
import 'package:todoapp/domain/entities/priority.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final DateTime? taskTime;
  final Category? category;
  final Priority? priority;
  final bool isCompleted;

  const Task({
    this.id = '',
    this.title = '',
    this.description = '',
    this.taskTime,
    this.category,
    this.priority = Priority.one,
    this.isCompleted = false,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? taskTime,
    Category? category,
    Priority? priority,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      taskTime: taskTime ?? this.taskTime,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
