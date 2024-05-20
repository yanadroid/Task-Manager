
enum TaskPriority {
  Low(1),
  Middle(2),
  High(3);

  final int value;

  const TaskPriority(this.value);

  static TaskPriority fromValue(int value) {
    switch (value) {
      case 1:
        return TaskPriority.Low;
      case 2:
        return TaskPriority.Middle;
      case 3:
        return TaskPriority.High;
      default:
        return TaskPriority.Low;
    }
  }
}
