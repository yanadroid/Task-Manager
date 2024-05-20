import 'package:flutter/material.dart';

import 'package:task_manager/features/data/datasources/locale/app_database.dart';
import 'package:task_manager/features/presentation/pages/home_screen.dart';
import 'injection_container.dart' as di;

void main() async {
  AppDatabase database = AppDatabase();
  await database.initialize();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
