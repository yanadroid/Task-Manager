import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/presentation/blocs/tasks/tasks_bloc.dart';
import 'package:task_manager/features/presentation/blocs/tasks/tasks_event.dart';
import 'package:task_manager/features/presentation/pages/tasks/tasks_page.dart';
import 'package:task_manager/injection_container.dart' as di;

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<TasksBloc>()..add(LoadTasksEvent()),
      child: const TasksPage(),
    );
  }
}
