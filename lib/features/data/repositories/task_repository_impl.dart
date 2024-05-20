import 'package:task_manager/features/data/datasources/locale/task_local_data_source.dart';
import 'package:task_manager/features/data/models/task_model.dart';
import 'package:task_manager/features/domain/entities/task.dart';
import 'package:task_manager/features/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl(this.localDataSource);

  @override
  Future<void> createTask(Task task) async {
    final taskModel = TaskModel.fromTask(task);
    await localDataSource.createTask(taskModel);
  }

  @override
  Future<List<Task>> getTasks() async {
    final tasks = await localDataSource.getTasks();
    return tasks;
  }
}
