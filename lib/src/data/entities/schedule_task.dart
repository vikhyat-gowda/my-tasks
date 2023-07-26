import 'package:floor/floor.dart';

@entity
class ScheduleTask {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final bool daily;
  final bool dSun;
  final bool dMon;
  final bool dTue;
  final bool dWen;
  final bool dThu;
  final bool dSat;

  final int startDate;
  final int endDate;

  final int reopenDate;
  final int editData;

  const ScheduleTask({
    this.id,
    required this.daily,
    required this.dSun,
    required this.dMon,
    required this.dTue,
    required this.dWen,
    required this.dThu,
    required this.dSat,
    required this.startDate,
    required this.endDate,
    required this.reopenDate,
    required this.editData,
  });
}