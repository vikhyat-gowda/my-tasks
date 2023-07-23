import 'package:floor/floor.dart';
import 'package:my_tasks/src/data/entities/task.dart';

@dao
abstract class Dao {

  // Task Table Queries
  @Query('Select * FROM Task')
  Future<List<Task>> getAllTask();

  // @Query('SELECT * FROM Task WHERE startDate <= :currDate AND (endDate IS NULL OR endDate = :currDate) ')
  // Stream<List<Task?>> getRelevantTaskForToday(int currDate);

  @Query('SELECT * FROM Task WHERE date(datetime(startDate, "unixepoch")) <= date(datetime(:currDate, "unixepoch")) AND (endDate IS NULL OR date(datetime(endDate, "unixepoch")) = date(datetime(:currDate, "unixepoch"))) ')
  Stream<List<Task?>> getRelevantTaskForToday(int currDate);

  @Query('Select * From Task WHERE id = :id')
  Stream<Task?> getTaskById(int id);

  @insert
  Future<void> insertTask(Task task);

  // @delete
  // Future<void> deleteTask(int id);
}