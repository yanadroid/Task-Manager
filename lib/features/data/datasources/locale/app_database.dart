import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager/core/adapters/task_priority_adapter.dart';
import 'package:task_manager/features/data/models/task_model.dart';

class AppDatabase {

  Future<void> initialize() async {
    await Hive.initFlutter();
    Hive
      ..registerAdapter(TaskPriorityAdapter())
      ..registerAdapter(TaskModelAdapter());
  }
}