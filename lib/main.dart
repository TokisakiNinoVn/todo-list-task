import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/add_task_screen.dart';
import 'screens/task_detail_screen.dart';
import 'screens/update_task_screen.dart';
import 'models/task.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/add': (context) => AddTaskScreen(),
        '/detail': (context) {
          final task = ModalRoute.of(context)!.settings.arguments as Task;
          return TaskDetailScreen(
            task: task,
            onDelete: (task) {},
          );
        },
        '/update': (context) {
          final task = ModalRoute.of(context)!.settings.arguments as Task;
          return UpdateTaskScreen(task: task);
        },
      },
    );
  }
}
