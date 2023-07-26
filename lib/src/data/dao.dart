import 'package:floor/floor.dart';
import 'package:my_tasks/src/data/entities/schedule_task.dart';
import 'package:my_tasks/src/data/entities/task.dart';

@dao
abstract class Dao {
  // Task Table Queries
  @Query('Select * FROM Task ORDER BY startDate DESC')
  Stream<List<Task>> getAllTask();

  // @Query('SELECT * FROM Task WHERE startDate <= :currDate AND (endDate IS NULL OR endDate = :currDate) ')
  // Stream<List<Task?>> getRelevantTaskForToday(int currDate);

  // @Query('SELECT * FROM Task WHERE startDate <= :currDate AND (endDate IS NULL OR datetime(endDate, "unixepoch") = datetime(:currDate, "unixepoch")) ')
  // Stream<List<Task?>> getRelevantTaskForToday(int currDate);

  @Query(
      'SELECT * FROM Task WHERE startDate <= :currDate AND ( endDate IS NULL OR endDate = :currDate) ORDER BY startDate DESC')
  Stream<List<Task?>> getRelevantTaskForToday(
      int currDate); //endDate IS NULL AND

  @Query('Select * From Task WHERE id = :id')
  Future<Task?> getTaskById(int id);

  @insert
  Future<void> insertTask(Task task);

  @update
  Future<void> updateTask(
      Task
          task); // This method will update the endDate field in the Task entity

  @transaction
  Future<void> upsertTask(Task task) async {
    if (task.id != null && task.id! > 0) {
      await updateTask(task);
    } else {
      await insertTask(task);
    }
  }

  @Query('UPDATE task SET endDate = :endDate WHERE id = :taskId')
  Future<void> updateTaskEndDateById(int taskId, int endDate);

  @Query('DELETE FROM task WHERE id = :taskId')
  Future<void> deleteTaskById(
      int taskId); // This method will delete the Task entity based on the provided taskId

  @Query('Select * FROM ScheduleTask')
  Stream<List<ScheduleTask>> getAllScheduleTask();

// @delete
// Future<void> deleteTask(int id);
}
