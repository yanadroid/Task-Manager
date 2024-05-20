import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task_manager/features/domain/entities/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            task.description,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            task.dueDate != null ? 'Due: ${task.dueDate?.toLocal().toString().split(' ')[0]}' : "∞",
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8.0),
          if (task.tags.isNotEmpty) ...[
            Wrap(
              spacing: 8.0,
              children: task.tags.map((tag) => Chip(label: Text("#$tag"))).toList(),
            ),
            const SizedBox(height: 8.0),
          ],
          if (task.attachments.isNotEmpty) ...[
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: task.attachments.map((attachment) {
                File file = File(attachment!);
                return Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    image: file.path.endsWith('.jpg') || file.path.endsWith('.png')
                        ? DecorationImage(
                            image: FileImage(file),
                            fit: BoxFit.cover,
                          )
                        : null,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: file.path.endsWith('.jpg') || file.path.endsWith('.png')
                      ? const SizedBox()
                      : const Icon(Icons.insert_drive_file, size: 30),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
