
import 'package:task_manager/features/domain/entities/task.dart';

abstract class TaskRepository {
  Future<void> createTask(Task task);
  Future<List<Task>> getTasks();
}
