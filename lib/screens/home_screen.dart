import 'package:flutter/material.dart';
import '../models/task.dart';
import 'task_detail_screen.dart';
import 'add_task_screen.dart';
import 'update_task_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];

  void _deleteTask(Task task) {
    setState(() {
      tasks.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final newTask = await Navigator.pushNamed(context, '/add');
              if (newTask != null) {
                setState(() {
                  tasks.add(newTask as Task);
                });
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            color: Colors.lightGreenAccent,
            child: ListTile(
              title: Text(task.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              subtitle: Text('Hạn: ${task.dueDate}'),
              trailing: Checkbox(
                value: task.isCompleted,
                onChanged: (value) {
                  setState(() {
                    task.isCompleted = value ?? false;
                  });
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskDetailScreen(
                      task: task,
                      onDelete: _deleteTask, // Truyền callback xóa task
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
