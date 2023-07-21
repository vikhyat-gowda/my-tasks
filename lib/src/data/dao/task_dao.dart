import 'package:floor/floor.dart';
import 'package:my_tasks/src/data/entities/task.dart';

@dao
abstract class TaskDao {
  @Query('Select * FROM TodoRecord')
  Future<List<Task>> getAllTodo();

  // TODO: get open tasks (ALL TIME)

  // TODO: get closed tasks (present day)

  @Query('Select * From TodoRecord WHERE id = :id')
  Stream<Task?> findTodoById(int id);

}