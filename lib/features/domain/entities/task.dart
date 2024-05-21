
import 'package:equatable/equatable.dart';
import 'package:task_manager/core/enums/task_priority.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime? dueDate;
  final List<String> tags;
  final TaskPriority priority;
  final List<String> attachments;

  const Task(
      {required this.id,
      required this.title,
      required this.description,
      required this.dueDate,
      required this.tags,
      required this.priority,
      required this.attachments});

  @override
  List<Object> get props => [id, title, description, dueDate!, tags, priority, attachments];
}
