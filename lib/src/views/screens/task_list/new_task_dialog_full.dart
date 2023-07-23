import 'package:flutter/material.dart';
import 'package:my_tasks/src/constants/task_priority.dart';
import 'package:my_tasks/src/data/dao.dart';

class NewTaskDialogFull extends StatefulWidget {
  const NewTaskDialogFull(this.dao, {super.key});

  final Dao dao;

  @override
  State<NewTaskDialogFull> createState() => _NewTaskDialogFullState();
}

class _NewTaskDialogFullState extends State<NewTaskDialogFull> {
  int selectedPriorityIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Create Task"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
          actions: [
            FilledButton(onPressed: () {}, child: const Text("Save")),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Details", style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 5),
              const TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title*',
                    icon: Icon(Icons.title)),
              ),
              const SizedBox(height: 20),
              const TextField(
                minLines: 2,
                maxLines: 2,
                autofocus: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                    icon: Icon(Icons.description)),
              ),
              // const SizedBox(height: 10),
              // const Divider(),
              // const SizedBox(height: 10),
              const SizedBox(height: 20),
              Text("Priority", style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List<Widget>.generate(
                  priorityList.length,
                  (int index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: ChoiceChip(
                        label: Text(priorityList[index].name),
                        selected: index == selectedPriorityIndex,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedPriorityIndex = selected ? index : 0;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
