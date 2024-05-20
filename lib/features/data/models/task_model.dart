
// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';
import 'package:task_manager/core/enums/task_priority.dart';
import 'package:task_manager/features/domain/entities/task.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends Task {
  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String title;
  @override
  @HiveField(2)
  final String description;
  @override
  @HiveField(3)
  final DateTime? dueDate;
  @override
  @HiveField(4)
  final List<String> tags;
  @override
  @HiveField(5)
  final TaskPriority priority;
  @override
  @HiveField(6)
  final List<String?> attachments;

  const TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.tags,
    required this.priority,
    required this.attachments
  }) : super(
    id: id,
    title: title,
    description: description,
    dueDate: dueDate,
    tags: tags,
    priority: priority,
    attachments: attachments
  );

  factory TaskModel.fromTask(Task task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      dueDate: task.dueDate,
      tags: task.tags,
      priority: task.priority,
      attachments: task.attachments
    );
  }
}
