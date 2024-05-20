import 'package:task_manager/core/usecase/usecase.dart';
import 'package:task_manager/features/domain/entities/task.dart';
import 'package:task_manager/features/domain/repositories/task_repository.dart';

class CreateTask implements UseCase<void, Task> {
  final TaskRepository repository;

  CreateTask(this.repository);

  @override
  Future<void> call({Task? param}) async {
    if (param != null) {
      await repository.createTask(param);
    }
  }
}
