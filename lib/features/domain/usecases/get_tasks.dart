import 'package:task_manager/core/usecase/usecase.dart';
import 'package:task_manager/features/domain/entities/task.dart';
import 'package:task_manager/features/domain/repositories/task_repository.dart';

class GetTasks implements UseCase<List<Task>, void> {
  final TaskRepository repository;

  GetTasks(this.repository);

  @override
  Future<List<Task>> call({void param}) async {
    return await repository.getTasks();
  }
}
