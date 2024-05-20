import 'package:flutter/material.dart';
import 'package:task_manager/core/dialogs/filter_dialog.dart';
import 'package:task_manager/features/presentation/blocs/tasks/tasks_bloc.dart';
import 'package:task_manager/features/presentation/blocs/tasks/tasks_event.dart';
import 'package:task_manager/features/presentation/pages/create_task/create_task_screen.dart';
import 'tasks/tasks_screen.dart';
import 'package:task_manager/injection_container.dart' as di;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Manager'), actions: [
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => FilterDialog(
                tags: di.sl<TasksBloc>().getTags(),
                onApply: (selectedDate, tag, selectedPriority) {
                  di.sl<TasksBloc>().add(
                        FilterTasksEvent(
                          date: selectedDate,
                          tag: tag,
                          priority: selectedPriority,
                        ),
                      );
                },
              ),
            );
          },
        ),
      ]),
      body: const TasksScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result =
              await Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CreateTaskScreen()));

          if (result != null) {
            di.sl<TasksBloc>().add(LoadTasksEvent());
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
