import 'package:drift/drift.dart';
import 'package:todoapp/core/database/app_database.dart';
import 'package:todoapp/domain/entities/sync_status.dart';

import '../../domain/entities/priority.dart';
import '../../domain/entities/task.dart' as entity;

class TaskModel {
  final String id;
  final String? remoteId;
  final String title;
  final String description;
  final DateTime taskTime;
  final String categoryId;
  final int priority;
  final bool isCompleted;
  final DateTime createAt;
  final DateTime updateAt;
  final SyncStatus syncStatus;

  TaskModel({
    required this.id,
    this.remoteId,
    required this.title,
    required this.description,
    required this.taskTime,
    required this.categoryId,
    required this.priority,
    required this.isCompleted,
    required this.createAt,
    required this.updateAt,
    required this.syncStatus,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['localId']?.toString() ?? '',
      remoteId: json['id']?.toString() ?? '',
      title: json['title'] as String,
      description: json['description'] as String,
      taskTime: DateTime.parse(json['taskTime']),
      categoryId: json['categoryId'] as String,
      priority: json['priority'] as int,
      isCompleted: json['isCompleted'] as bool,
      createAt: DateTime.parse(json['createAt']),
      updateAt: DateTime.parse(json['updateAt']),
      syncStatus: syncStatusFromInt(json['syncStatus'] as int? ?? 0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'localId': id,
      'title': title,
      'description': description,
      'taskTime': taskTime.toIso8601String(),
      'categoryId': categoryId,
      'priority': priority,
      'isCompleted': isCompleted,
      'createAt': createAt.toIso8601String(),
      'updateAt': updateAt.toIso8601String(),
      'syncStatus': syncStatus.index,
    };
  }

  entity.Task toEntity() {
    return entity.Task(
      id: id,
      remoteId: remoteId,
      title: title,
      description: description,
      taskTime: taskTime,
      priority: Priority.values.firstWhere(
        (p) => p.value == priority,
        orElse: () => Priority.one,
      ),
      categoryId: categoryId,
      isCompleted: isCompleted,
      createAt: createAt,
      syncStatus: syncStatus,
    );
  }

  factory TaskModel.fromEntity(entity.Task task) {
    return TaskModel(
      id: task.id,
      remoteId: task.remoteId,
      title: task.title,
      description: task.description,
      taskTime: task.taskTime ?? DateTime.now(),
      categoryId: task.categoryId ?? 'cat_008',
      priority: task.priority?.value ?? 1,
      isCompleted: task.isCompleted,
      createAt: task.createAt ?? DateTime.now(),
      updateAt: DateTime.now(),
      syncStatus: task.syncStatus ?? SyncStatus.pending,
    );
  }

  factory TaskModel.fromDrift(Task driftTask) {
    return TaskModel(
      id: driftTask.id,
      remoteId: driftTask.remoteId,
      title: driftTask.title,
      description: driftTask.description,
      taskTime: driftTask.taskTime,
      categoryId: driftTask.categoryId,
      priority: driftTask.priority,
      isCompleted: driftTask.isCompleted,
      createAt: driftTask.createAt,
      updateAt: driftTask.updateAt,
      syncStatus: driftTask.syncStatus,
    );
  }

  TasksCompanion toDriftCompanion() {
    return TasksCompanion(
      id: Value(id),
      remoteId: Value(remoteId),
      title: Value(title),
      description: Value(description),
      taskTime: Value(taskTime),
      categoryId: Value(categoryId),
      priority: Value(priority),
      isCompleted: Value(isCompleted),
      createAt: Value(createAt),
      updateAt: Value(updateAt),
      syncStatus: Value(syncStatus),
    );
  }
}
