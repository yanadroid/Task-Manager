

import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager/core/constants/database_tables_fields.dart';
import 'package:task_manager/features/data/datasources/locale/task_local_data_source.dart';
import 'package:task_manager/features/data/models/task_model.dart';
import 'package:task_manager/features/data/repositories/task_repository_impl.dart';
import 'package:task_manager/features/domain/repositories/task_repository.dart';
import 'package:task_manager/features/domain/usecases/create_task.dart';
import 'package:task_manager/features/domain/usecases/get_tasks.dart';
import 'package:task_manager/features/presentation/blocs/create_task/create_task_bloc.dart';
import 'package:task_manager/features/presentation/blocs/tasks/tasks_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final taskBox = await Hive.openBox<TaskModel>(DatabaseTablesFields.tableTasksBox);

  // Data sources
  sl.registerLazySingleton<TaskLocalDataSource>(() => TaskLocalDataSourceImpl(taskBox));

  // Repositories
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(sl()));

  // Use cases
  sl.registerLazySingleton(() => CreateTask(sl()));
  sl.registerLazySingleton(() => GetTasks(sl()));

  // Blocs
  sl.registerLazySingleton(() => TasksBloc(getTasks: sl()));
  sl.registerLazySingleton(() => CreateTaskBloc(createTask: sl()));
}