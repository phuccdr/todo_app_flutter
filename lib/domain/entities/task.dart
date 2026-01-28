import 'package:todoapp/domain/entities/category.dart';
import 'package:todoapp/domain/entities/priority.dart';
import 'package:todoapp/domain/entities/sync_status.dart';

class Task {
  final String id;
  final String title;
  final String? description;
  final DateTime? taskTime;
  final Category? category;
  final Priority? priority;
  final bool isCompleted;
  final DateTime? createAt;
  final SyncStatus? syncStatus;

  const Task({
    this.id = '',
    this.title = '',
    this.description = '',
    this.taskTime,
    this.category,
    this.priority = Priority.one,
    this.isCompleted = false,
    this.createAt,
    this.syncStatus,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? taskTime,
    Category? category,
    Priority? priority,
    bool? isCompleted,
    SyncStatus? syncStatus,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      taskTime: taskTime ?? this.taskTime,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }
}
