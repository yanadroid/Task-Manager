import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/presentation/blocs/tasks/tasks_bloc.dart';
import 'package:task_manager/features/presentation/blocs/tasks/tasks_state.dart';
import 'package:task_manager/features/presentation/widgets/task_item.dart';


class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        if (state is TasksLoadedState) {
          return ListView.builder(
            itemCount: state.tasks.length,
            itemBuilder: (context, index) {
              return TaskItem(task: state.tasks[index]);
            },
          );
        } else if (state is TasksLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text('Something went wrong!'));
        }
      },
    );
  }
}
