import 'package:flutter/material.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            title: const Text("My Tasks"),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              IconButton(
                  onPressed:(){},
                  icon: const Icon(Icons.info_outline)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
            ],
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "To-do",
                ),
                Tab(
                  text: "Tasks Lists",
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed:  () =>{},
            tooltip: 'Create New List',
            child: const Icon(Icons.add),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child:
                Text("Open", style: Theme.of(context).textTheme.labelLarge),
              ),
              ListTile(
                leading: Checkbox(
                  value: false,
                  onChanged: (bool? value) {},
                ),
                title: const Text('Headline'),
                trailing: const Icon(Icons.edit),
              ),
              ListTile(
                leading: Checkbox(
                  value: false,
                  onChanged: (bool? value) {},
                ),
                title: const Text('Headline'),
                trailing: const Icon(Icons.edit),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Text("Completed",
                    style: Theme.of(context).textTheme.labelLarge),
              ),
              ListTile(
                leading: Checkbox(
                  value: true,
                  onChanged: (bool? value) {},
                ),
                title: const Text(
                  'Headline',
                  style: TextStyle(decoration: TextDecoration.lineThrough),
                ),
                trailing: const Icon(Icons.edit),
              ),
              ListTile(
                leading: Checkbox(
                  value: true,
                  onChanged: (bool? value) {},
                ),
                title: const Text(
                  'Headline',
                  style: TextStyle(decoration: TextDecoration.lineThrough),
                ),
                trailing: const Icon(Icons.edit),
              ),
            ],
          )),
    );
  }
}
