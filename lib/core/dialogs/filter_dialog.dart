import 'package:flutter/material.dart';
import 'package:task_manager/core/enums/task_priority.dart';
import 'package:task_manager/core/utils/get_date_picker.dart';

class FilterDialog extends StatefulWidget {
  final List<String> tags;
  final Function(DateTime?, String? tag, TaskPriority?) onApply;

  const FilterDialog({Key? key, required this.tags, required this.onApply}) : super(key: key);

  @override
  FilterDialogState createState() => FilterDialogState();
}

class FilterDialogState extends State<FilterDialog> {
  DateTime? _selectedDate;
  TaskPriority? _selectedPriority;
  String? _selectedTag;

  void _selectDate(BuildContext context) async {
    final result = await GetDatePicker.pickDate(context,
        initialDate: DateTime.now(), lastDate: DateTime(2101), firstDate: DateTime(2000));

    if (result != null) {
      setState(() {
        _selectedDate = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter Tasks'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: const Text('Due Date'),
              subtitle:
                  Text(_selectedDate == null ? 'No date chosen' : _selectedDate!.toLocal().toString().split(' ')[0]),
              trailing: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context),
              ),
            ),
            ListTile(
              title: const Text('Priority'),
              trailing: DropdownButton<TaskPriority>(
                value: _selectedPriority,
                items: TaskPriority.values.map((priority) {
                  return DropdownMenuItem<TaskPriority>(
                    value: priority,
                    child: Text(priority.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPriority = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Tags'),
              trailing: DropdownButton<String>(
              value: _selectedTag,
              items: widget.tags.map((tag) {
                return DropdownMenuItem<String>(
                  value: tag,
                  child: Text("#$tag"),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedTag = value;
                });
              },
            ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onApply(_selectedDate, _selectedTag, _selectedPriority);
            Navigator.of(context).pop();
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }
}
