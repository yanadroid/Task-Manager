
import 'package:equatable/equatable.dart';
import 'package:task_manager/features/domain/entities/task.dart';


class CreateTaskEvent extends Equatable {
  final Task task;

  const CreateTaskEvent(this.task);

  @override
  List<Object> get props => [task];
}
