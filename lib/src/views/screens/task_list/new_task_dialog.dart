import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_tasks/src/constants/task_priority.dart';
import 'package:my_tasks/src/data/dao.dart';
import 'package:my_tasks/src/data/entities/task.dart';

class NewTaskDialog extends StatefulWidget {
  const NewTaskDialog({super.key});


  @override
  State<NewTaskDialog> createState() => _NewTaskDialogState();
}

class _NewTaskDialogState extends State<NewTaskDialog> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  int selectedPriorityIndex = 0;
  late final Dao dao;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    dao = GetIt.I.get<Dao>();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Create new task for today',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 20),
              TextFormField(
                autofocus: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title*',
                ),
                controller: titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter the title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
                controller: descriptionController,
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              Text("Priority", style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List<Widget>.generate(
                  priorityList.length,
                  (int index) {
                    return ChoiceChip(
                      label: Text(priorityList[index].name),
                      selected: index == selectedPriorityIndex,
                      onSelected: (bool selected) {
                        setState(() {
                          selectedPriorityIndex = selected ? index : 0;
                        });
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel")),
                  const SizedBox(width: 10),
                  FilledButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                         dao.insertTask(
                            Task(
                              title: titleController.text,
                              description: descriptionController.text,
                              priority: priorityList[selectedPriorityIndex].val,
                              startDate: DateTime.now().microsecondsSinceEpoch,
                            ),
                          );
                        }
                      },
                      child: const Text("ADD")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
