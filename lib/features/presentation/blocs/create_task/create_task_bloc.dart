import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/enums/task_priority.dart';
import 'package:task_manager/core/notifications/flutter_local_notifications.dart';
import 'package:task_manager/features/domain/usecases/create_task.dart';

import 'create_task_event.dart';
import 'create_task_state.dart';

class CreateTaskBloc extends Bloc<CreateTaskEvent, CreateTaskState> {
  final CreateTask createTask;

  final List<File> _attachments = [];
  TaskPriority _priority = TaskPriority.Low;
  DateTime? _dueDate;

  DateTime? get dueDate => _dueDate;
  TaskPriority get priority => _priority;
  List<File> get attachments => _attachments;


  CreateTaskBloc({
    required this.createTask,
  }) : super(CreateTaskInitial()) {
    on<CreateTaskEvent>((event, emit) async {
      emit(CreateTaskLoadingState());
      try {
        await createTask(param: event.task);
        if (event.task.dueDate != null) {
          scheduleNotification(
            event.task.id,
            'Task Reminder',
            'You have a task due: ${event.task.title}',
            event.task.dueDate!,
          );
        }
        emit(CreateTaskSuccessState());
      } catch (e) {
        emit(CreateTaskFailureState(error: e.toString()));
      }
    });
  }

  void addAttachment(File file) {
    _attachments.add(file);
  }

  void setDueDate(DateTime time) {
    _dueDate = time;
  }

  void setPriority(TaskPriority priority) {
    _priority = priority;
  }

  void clear() {
    _dueDate = null;
    _attachments.clear();
    _priority = TaskPriority.Low;
  }
}
