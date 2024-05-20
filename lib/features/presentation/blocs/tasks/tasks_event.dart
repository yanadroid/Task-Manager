
import 'package:flutter/widgets.dart';
import 'package:task_manager/core/enums/task_priority.dart';

@immutable
abstract class TasksEvent {}

class LoadTasksEvent extends TasksEvent {}

class FilterTasksEvent extends TasksEvent {
  final DateTime? date;
  final String? tag;
  final TaskPriority? priority;

  FilterTasksEvent({this.date, required this.tag, this.priority});
}
