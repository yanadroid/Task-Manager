
import 'package:hive/hive.dart';
import 'package:task_manager/core/enums/task_priority.dart';

class TaskPriorityAdapter extends TypeAdapter<TaskPriority> {
  @override
  final typeId = 1;

  @override
  TaskPriority read(BinaryReader reader) {
    return TaskPriority.fromValue(reader.readInt());
  }

  @override
  void write(BinaryWriter writer, TaskPriority obj) {
    writer.writeInt(obj.value);
  }
}
