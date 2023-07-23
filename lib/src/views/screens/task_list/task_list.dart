import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:my_tasks/src/views/screens/task_list/new_task_dialog.dart';

class TaskList extends StatefulWidget {
  const TaskList( {super.key});


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
          // backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          appBar: AppBar(
            title: const Text("My Tasks"),
            backgroundColor: Theme
                .of(context)
                .colorScheme
                .inversePrimary,
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.event)),
              // IconButton(
              //   onPressed: () {
              //                 if (controller.isOpen) {
              //                   controller.close();
              //                 } else {
              //                   controller.open();
              //                 }
              //               },
              //   icon: const Icon(Icons.more_vert),
              // ),
              MenuAnchor(
                alignmentOffset:const Offset(-40,0),
                menuChildren:  [
                  MenuItemButton(
                    child: Text("Tutorial", style: Theme.of(context).textTheme.titleMedium,),
                  ),
                ],
                builder: (BuildContext context, MenuController controller,
                    Widget? child) {
                  return IconButton(
                    onPressed: () {
                      if (controller.isOpen) {
                        controller.close();
                      } else {
                        controller.open();
                      }
                    },
                    icon: const Icon(Icons.more_vert),
                  );
                },
              ),
            ],
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "To-do",
                ),
                Tab(
                  text: "Place Holder",
                ),
              ],
            ),
          ),
          floatingActionButton: SpeedDial(
            spaceBetweenChildren: 6,
            animatedIcon: AnimatedIcons.add_event,
            children: [
              SpeedDialChild(
                child: const Icon(Icons.add_task),
                label: 'For Today',
                onTap: () {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) =>
                          const NewTaskDialog());
                },
              ),
              SpeedDialChild(
                  child: const Icon(Icons.date_range),
                  label: 'For Future Date',
                  shape: const CircleBorder()),
              SpeedDialChild(
                child: const Icon(Icons.schedule),
                label: 'Schedule Task',
                shape: const CircleBorder(),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child:
                Text("Open", style: Theme
                    .of(context)
                    .textTheme
                    .labelLarge),
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
                    style: Theme
                        .of(context)
                        .textTheme
                        .labelLarge),
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
