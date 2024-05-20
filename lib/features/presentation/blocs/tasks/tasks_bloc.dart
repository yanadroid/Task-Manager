import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/domain/entities/task.dart';
import 'package:task_manager/features/domain/usecases/get_tasks.dart';
import 'package:task_manager/features/presentation/blocs/tasks/tasks_event.dart';
import 'package:task_manager/features/presentation/blocs/tasks/tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final GetTasks getTasks;

  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  TasksBloc({
    required this.getTasks,
  }) : super(TasksInitial()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<FilterTasksEvent>(_onFilterTasks);
  }

  void _onLoadTasks(LoadTasksEvent event, Emitter<TasksState> emit) async {
    emit(TasksLoadingState());
    try {
      _tasks = await getTasks();
      emit(TasksLoadedState(tasks: _tasks));
    } catch (e) {
      emit(TasksFailureState(error: e.toString()));
    }
  }

  void _onFilterTasks(FilterTasksEvent event, Emitter<TasksState> emit) async {
    emit(TasksLoadingState());
    List<Task> filteredTasks = _tasks;
    if (event.date != null) {
      filteredTasks = filteredTasks.where((task) => task.dueDate == event.date).toList();
    }
    if (event.tag != null) {
      filteredTasks = filteredTasks.where((task) => task.tags.contains(event.tag)).toList();
    }
    if (event.priority != null) {
      filteredTasks = filteredTasks.where((task) => task.priority == event.priority).toList();
    }
    emit(TasksLoadedState(tasks: filteredTasks));
  }

  List<String> getTags() {
    final Set<String> tags = {};

    for (var task in _tasks) {
      for (var tag in task.tags) {
        tags.add(tag);
      }
    }
    return tags.toList();
  }
}
