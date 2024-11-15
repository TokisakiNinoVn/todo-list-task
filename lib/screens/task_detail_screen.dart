import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;
  final Function(Task) onDelete; // Thêm hàm callback để xóa task

  TaskDetailScreen({required this.task, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chi tiết Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Mô tả: ${task.description}'),
            const SizedBox(height: 10),
            Text('Hạn: ${task.dueDate}'),
            const SizedBox(height: 10),
            Text('Trạng thái: ${task.isCompleted ? "✅ Đã hoàn thành" : "❌ Chưa hoàn thành"}'),
            const SizedBox(height: 20),
            Center(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Gọi hàm xóa task
                        onDelete(task);
                        Navigator.pop(context);
                      },
                      label: const Text("Xóa task"),
                      icon: const Icon(Icons.delete_forever),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final updatedTask = await Navigator.pushNamed(
                          context,
                          '/update',
                          arguments: task,
                        ) as Task?;
                        if (updatedTask != null) {
                          // Cập nhật task với thông tin mới
                          task.title = updatedTask.title;
                          task.description = updatedTask.description;
                          task.dueDate = updatedTask.dueDate;
                        }
                      },
                      label: const Text("Cập nhật"),
                      icon: const Icon(Icons.edit),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
