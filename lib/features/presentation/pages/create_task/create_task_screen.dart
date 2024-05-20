import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/domain/usecases/create_task.dart';
import 'package:task_manager/features/presentation/blocs/create_task/create_task_bloc.dart';
import 'package:task_manager/features/presentation/pages/create_task/create_task_page.dart';
import 'package:task_manager/injection_container.dart' as di;

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateTaskBloc(createTask: di.sl<CreateTask>()),
      child: const CreateTaskPage(),
    );
  }
}
