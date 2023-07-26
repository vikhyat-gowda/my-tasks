import 'dart:async';
import 'package:floor/floor.dart';
import 'package:my_tasks/src/data/dao.dart';
import 'package:my_tasks/src/data/entities/schedule_task.dart';
import 'package:my_tasks/src/data/entities/task.dart';
import 'package:sqflite/sqflite.dart' as sqflite;


part 'database.g.dart';

@Database(version: 1, entities: [Task, ScheduleTask])
abstract class AppDatabase extends FloorDatabase {
  Dao get dao;
}