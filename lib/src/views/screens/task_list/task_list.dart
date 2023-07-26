import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_it/get_it.dart';
import 'package:my_tasks/src/data/dao.dart';
import 'package:my_tasks/src/data/entities/task.dart';

import 'package:my_tasks/src/views/screens/task_list/new_task_dialog.dart';
import 'package:my_tasks/src/views/screens/task_list/schedule_task_dialog.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  late final Dao dao;
  final DateTime now = DateTime.now();

  @override
  void initState() {

    super.initState();
    dao = GetIt.I.get<Dao>();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Tasks"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.event)),
            MenuAnchor(
              alignmentOffset: const Offset(-40, 0),
              menuChildren: [
                MenuItemButton(
                  child: Text(
                    "Tutorial",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                MenuItemButton(
                  child: Text(
                    "Delete Completed Tasks",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
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
                      const NewTaskDialog(isEdit: false),
                );
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
              onTap: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => const ScheduleTaskDialog(),
                );
              },
            ),
          ],
        ),
        body: StreamBuilder(
          stream: dao.getRelevantTaskForToday(
            DateTime(now.year, now.month, now.day).microsecondsSinceEpoch,
          ),
          // stream: dao.getAllTask(),
          builder: (BuildContext context, AsyncSnapshot<List<Task?>> snapshot) {
            if (snapshot.hasError) {
              return const Column(
                children: [Text("Error")],
              );
            }
            if (snapshot.hasData) {
              List<ListTile> openTasks = [], closedTasks = [];
              DateTime now = DateTime.now();
              for (int i = 0; i < snapshot.data!.length; i++) {
                Task element = snapshot.data![i]!;
                if (element.endDate == null) {
                  openTasks.add(
                    ListTile(
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Delete Task?"),
                              content: const Text(
                                  "This will permanently delete the task."),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    dao.deleteTaskById(element.id!);
                                    Navigator.pop(context, 'OK');
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      leading: Checkbox(
                        value: false,
                        onChanged: (bool? value) {
                          dao.updateTask(
                            Task(
                              id: element.id,
                              endDate: DateTime(now.year, now.month, now.day)
                                  .microsecondsSinceEpoch,
                              title: element.title,
                              startDate: element.startDate,
                              priority: element.priority,
                            ),
                          );
                        },
                      ),
                      title: Text(element.title),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => NewTaskDialog(
                              isEdit: true,
                              taskId: element.id,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  closedTasks.add(
                    ListTile(
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Delete Task?"),
                              content: const Text(
                                  "This will permanently delete the task."),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    dao.deleteTaskById(element.id!);
                                    Navigator.pop(context, 'OK');
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      leading: Checkbox(
                        value: true,
                        onChanged: (bool? value) {
                          dao.updateTask(
                            Task(
                              id: element.id,
                              endDate: null,
                              title: element.title,
                              startDate: element.startDate,
                              priority: element.priority,
                            ),
                          );
                        },
                      ),
                      title: Text(
                        element.title,
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => NewTaskDialog(
                              isEdit: true,
                              taskId: element.id,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Text("Open",
                          style: Theme.of(context).textTheme.labelLarge),
                    ),
                    ...openTasks,
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Text("Completed",
                          style: Theme.of(context).textTheme.labelLarge),
                    ),
                    ...closedTasks
                  ],
                ),
              );
            }
            return const Column(
              children: [Text("Loading")],
            );
          },
        ),
      ),
    );
  }
}
