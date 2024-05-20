import 'package:hive/hive.dart';
import 'package:task_manager/features/data/models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<void> createTask(TaskModel task);
  Future<List<TaskModel>> getTasks();
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final Box<TaskModel> taskBox;

  TaskLocalDataSourceImpl(this.taskBox);

  @override
  Future<void> createTask(TaskModel task) async {
    await taskBox.put(task.id, task);
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    return taskBox.values.toList();
  }
}
