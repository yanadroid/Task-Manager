import 'package:equatable/equatable.dart';
import 'package:task_manager/features/domain/entities/task.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

class TasksInitial extends TasksState {}

class TasksLoadingState extends TasksState {}

class TasksLoadedState extends TasksState {
  final List<Task> tasks;

  const TasksLoadedState({required this.tasks});

  @override
  List<Object> get props => [tasks];
}

class TasksFailureState extends TasksState {
  final String error;

  const TasksFailureState({required this.error});

  @override
  List<Object> get props => [error];
}
