import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/enums/task_priority.dart';
import 'package:task_manager/core/utils/get_date_picker.dart';
import 'package:task_manager/core/utils/get_file_picker.dart';
import 'package:task_manager/core/utils/get_image_picker.dart';
import 'package:task_manager/features/domain/entities/task.dart';
import 'package:task_manager/features/presentation/blocs/create_task/create_task_bloc.dart';
import 'package:task_manager/features/presentation/blocs/create_task/create_task_event.dart';
import 'package:task_manager/features/presentation/blocs/create_task/create_task_state.dart';
import 'package:task_manager/injection_container.dart' as di;
import 'package:intl/intl.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  CreateTaskPageState createState() => CreateTaskPageState();
}

class CreateTaskPageState extends State<CreateTaskPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _tagsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTaskBloc, CreateTaskState>(builder: (context, state) {
      if (state is CreateTaskLoadingState) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is CreateTaskFailureState) {
        return const Center(child: Text('Something went wrong!'));
      } else {
        return Scaffold(
          appBar: AppBar(title: const Text('Create Task')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                GestureDetector(
                  onTap: () => _selectDueDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Due Date'),
                      controller: TextEditingController(
                        text: di.sl<CreateTaskBloc>().dueDate != null
                            ? DateFormat.yMd().format(di.sl<CreateTaskBloc>().dueDate!)
                            : "No date",
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  controller: _tagsController,
                  decoration: const InputDecoration(labelText: 'Tags (comma separated)'),
                ),
                _buildPriorityDropdown(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.attach_file),
                      onPressed: _pickFile,
                    ),
                    IconButton(
                      icon: const Icon(Icons.photo),
                      onPressed: _pickImage,
                    ),
                  ],
                ),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: di.sl<CreateTaskBloc>().attachments.map((file) {
                    return Container(
                      width: 100,
                      height: 100,
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
                          : const Icon(Icons.insert_drive_file, size: 50),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_titleController.text.isNotEmpty) {
                      final task = Task(
                          id: DateTime.now().toString(),
                          title: _titleController.text,
                          description: _descriptionController.text,
                          dueDate: di.sl<CreateTaskBloc>().dueDate,
                          tags: _tagsController.text.split(',').map((e) => e.trim()).toList(),
                          priority: di.sl<CreateTaskBloc>().priority,
                          attachments: di.sl<CreateTaskBloc>().attachments.map((file) => file.path).toList());
                      di.sl<CreateTaskBloc>().add(CreateTaskEvent(task));
                      Navigator.of(context).pop(true);
                    }
                  },
                  child: const Text('Create Task'),
                ),
              ],
            ),
          ),
        );
      }
    });
  }

  Widget _buildPriorityDropdown() {
    return GestureDetector(
      onTap: () async {
        final priority = await showDialog<TaskPriority>(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              title: const Text('Select Priority'),
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, TaskPriority.Low);
                  },
                  child: const Text('Low'),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, TaskPriority.Middle);
                  },
                  child: const Text('Middle'),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, TaskPriority.High);
                  },
                  child: const Text('High'),
                ),
              ],
            );
          },
        );
        if (priority != null) {
          setState(() {
            di.sl<CreateTaskBloc>().setPriority(priority);
          });
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          decoration: const InputDecoration(labelText: 'Priority'),
          controller: TextEditingController(text: di.sl<CreateTaskBloc>().priority.toString().split('.').last),
        ),
      ),
    );
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final dueDate = di.sl<CreateTaskBloc>().dueDate;
    final result = await GetDatePicker.pickDate(context,
        initialDate: dueDate, lastDate: DateTime(2101), firstDate: DateTime.now());
    if (result != null && result != dueDate) {
      setState(() {
        di.sl<CreateTaskBloc>().setDueDate(result);
      });
    }
  }

  Future<void> _pickFile() async {
    final result = await GetFilePicker.pickFile();
    if (result != null) {
      setState(() {
        di.sl<CreateTaskBloc>().addAttachment(result);
      });
    }
  }

  Future<void> _pickImage() async {
    final result = await GetImagePicker.pickImage();
    if (result != null) {
      setState(() {
        di.sl<CreateTaskBloc>().addAttachment(result);
      });
    }
  }

  @override
  void dispose() {
    di.sl<CreateTaskBloc>().clear();
    super.dispose();
  }
}
