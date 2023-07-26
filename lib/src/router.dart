import 'package:go_router/go_router.dart';
import 'package:my_tasks/src/views/screens/task_list/task_list.dart';

final router = GoRouter(
  initialLocation: '/tasks',
  routes: [
    GoRoute(
      path: '/tasks',
      builder: (context, state) => const TaskList(),
    ),
  ],
);