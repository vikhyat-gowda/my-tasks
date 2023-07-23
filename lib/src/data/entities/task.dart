import 'package:floor/floor.dart';

@entity
class Task {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String title;
  final String? description;

  // ref: https://stackoverflow.com/questions/57165310/create-a-datetime-column-in-sqlite-flutter-database
  // for storing dates as int (milliseconds)
  final int startDate;
  final int? endDate;
  final int? reopenDate;
  final bool? isOpen;
  final bool? isFollowUp;
  final int? followUpId;
  final int priority;

  const Task({
    this.id,
    required this.title,
    this.description,
    required this.startDate,
    this.endDate,
    this.reopenDate,
    this.isOpen = true,
    this.isFollowUp,
    this.followUpId,
    required this.priority,
  });
}
