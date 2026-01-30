import 'package:todoapp/domain/entities/category.dart';
import 'package:todoapp/domain/entities/task.dart';

class TaskDisplay {
  final Task task;
  final Category? category;

  const TaskDisplay({required this.task, this.category});
}
