import 'package:flutter/material.dart';
import 'package:my_tasks/src/views/screens/task_list/task_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF007964)),
        useMaterial3: true,
      ),
      home: const TaskList(),
      debugShowCheckedModeBanner: false,
    );
  }
}
