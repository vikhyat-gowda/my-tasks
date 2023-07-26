
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_tasks/src/constants/day_list.dart';
import 'package:my_tasks/src/constants/task_priority.dart';

class ScheduleTaskDialog extends StatefulWidget {
  const ScheduleTaskDialog({super.key});

  @override
  State<ScheduleTaskDialog> createState() => _ScheduleTaskDialogState();
}

class _ScheduleTaskDialogState extends State<ScheduleTaskDialog> {
  int? selectedPriorityIndex = 0;
  List<bool> selectedDays = List.filled(dayList.length, false, growable: false);

  // States

  bool _repeatDaySwitch = false;
  bool _repeatDailySwitch = false;
  DateTime? _startDate, _endDate;

  @override
  Widget build(BuildContext context) {
    final List<MenuItemButton> priorityEntries = <MenuItemButton>[];
    final List<ActionChip> repeatList = <ActionChip>[];

    for (var i = 0; i < dayList.length; i++) {
      String prefix = dayList[i].substring(0, 1);
      repeatList.add(
        ActionChip(
          label: Text(prefix),
          shape: const CircleBorder(),
          onPressed: _repeatDaySwitch
              ? () {
                  setState(
                    () {
                      selectedDays[i] = !selectedDays[i];
                      bool isDaily = selectedDays.every((element) {
                        return element;
                      });
                      _repeatDailySwitch = isDaily;
                    },
                  );
                }
              : null,
          backgroundColor:
              selectedDays[i] == true ? Theme.of(context).primaryColor : null,
          labelStyle: selectedDays[i] == true && _repeatDaySwitch == true
              ? TextStyle(color: Theme.of(context).colorScheme.onPrimary)
              : null,
          elevation: 1,
        ),
      );
    }

    for (var i = 0; i < priorityList.length; i++) {
      priorityEntries.add(
        MenuItemButton(
          onPressed: () {
            setState(() {
              selectedPriorityIndex = i;
            });
          },
          child: Text(priorityList[i].name),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          FilledButton(onPressed: () {}, child: const Text("Save")),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      prefix: SizedBox(width: 55),
                      hintText: "Schedule Task",
                      border: InputBorder.none),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Divider(
                  height: 0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        value: _repeatDaySwitch,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (value) {
                          setState(() {
                            _repeatDaySwitch = value!;
                            if (value == false) {
                              selectedDays.fillRange(0, dayList.length, false);
                            }
                            _repeatDailySwitch = false;

                          });
                        },
                        title: const Text("Repeat Days"),
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        value: _repeatDailySwitch,
                        onChanged: (value) {
                          setState(() {
                            selectedDays.fillRange(0, dayList.length, value);
                            _repeatDailySwitch = value!;
                            _repeatDaySwitch = true;
                            // repeatMonthSwitch = false;
                          });
                        },
                        title: const Text("Repeat Daily"),
                      ),
                    ),
                    // Expanded(
                    //   child: SwitchListTile(
                    //     title: const Text(
                    //       "Repeat Daily",
                    //     ),
                    //     value: _repeatDailySwitch,
                    //     onChanged: (bool value) {
                    //       setState(() {
                    //         selectedDays.fillRange(0, dayList.length, value);
                    //         _repeatDailySwitch = value;
                    //         _repeatDaySwitch = true;
                    //         // repeatMonthSwitch = false;
                    //       });
                    //     },
                    //
                    //   ),
                    // ),
                    // Expanded(
                    //   child: SwitchListTile(
                    //     title: const Text(
                    //       "Repeat Days",
                    //     ),
                    //     value: _repeatDaySwitch,
                    //     onChanged: (bool value) {
                    //       setState(() {
                    //         _repeatDaySwitch = value;
                    //         if (value == false) {
                    //           selectedDays.fillRange(0, dayList.length, false);
                    //         }
                    //         _repeatDailySwitch = false;
                    //         _repeatMonthSwitch = false;
                    //       });
                    //     },
                    //
                    //   ),
                    // )
                  ],
                ),
                // SwitchListTile(
                //   title: const Text(
                //     "Repeat Daily",
                //   ),
                //   value: _repeatDailySwitch,
                //   onChanged: (bool value) {
                //     setState(() {
                //       selectedDays.fillRange(0, dayList.length, value);
                //       _repeatDailySwitch = value;
                //       _repeatDaySwitch = true;
                //       // repeatMonthSwitch = false;
                //     });
                //   },
                //   secondary: const Icon(Icons.calendar_month),
                // ),
                // SwitchListTile(
                //   title: const Text(
                //     "Repeat Days",
                //   ),
                //   value: _repeatDaySwitch,
                //   onChanged: (bool value) {
                //     setState(() {
                //       _repeatDaySwitch = value;
                //       if (value == false) {
                //         selectedDays.fillRange(0, dayList.length, false);
                //       }
                //       _repeatDailySwitch = false;
                //       _repeatMonthSwitch = false;
                //     });
                //   },
                //   secondary: Transform.flip(
                //     flipX: true,
                //     child: const Icon(Icons.replay),
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: repeatList,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  height: 0,
                ),
                InkWell(
                  child: ListTile(
                    leading: const Icon(Icons.start),
                    subtitle: _startDate == null
                        ? null
                        : Text(DateFormat("d MMM yyyy").format(_startDate!)),
                    title: _startDate == null
                        ? const Text("Select Start Date")
                        : const Text("Start Date"),
                    trailing: const Icon(Icons.calendar_month_outlined),
                  ),
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                    ).then(
                      (pickedDate) {
                        if (pickedDate == null) {
                          return;
                        }
                        setState(() {
                          _startDate = pickedDate;
                        });
                      },
                    );
                  },
                ),
                InkWell(
                  child: ListTile(
                    leading: const Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.transparent,
                    ),
                    title: _endDate == null
                        ? const Text("Select End Date")
                        : const Text("End Date"),
                    subtitle: _endDate == null
                        ? null
                        : Text(DateFormat("d MMM yyyy").format(_endDate!)),
                    trailing: const Icon(Icons.calendar_month_outlined),
                  ),
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                    ).then(
                      (pickedDate) {
                        if (pickedDate == null) {
                          return;
                        }
                        setState(() {
                          _endDate = pickedDate;
                        });
                      },
                    );
                  },
                ),

                const Divider(
                  height: 0,
                ),
                ListTile(
                  leading: const Icon(Icons.label_important_outline),
                  title: Text(
                    "Priority",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  subtitle: Wrap(
                    spacing: 20,
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
                ),
                const Divider(
                  height: 0,
                ),
                ListTile(
                  leading: const Icon(Icons.sort),
                  title: TextFormField(
                    minLines: 1,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: "Description",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Divider(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
