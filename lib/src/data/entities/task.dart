import 'package:floor/floor.dart';

@entity
class Task {
  @primaryKey
  final int id;
  final String? title;
  final String? description;

  // ref: https://stackoverflow.com/questions/57165310/create-a-datetime-column-in-sqlite-flutter-database
  // for storing dates as int (milliseconds)
  final int? startDate;
  final int? endDate;
  final int? reopenDate;
  final bool? isOpen;
  final bool? isFollowUp;
  final int followUpId;
  final int priority;

  Task(
      this.id,
      this.title,
      this.description,
      this.startDate,
      this.endDate,
      this.reopenDate,
      this.isOpen,
      this.isFollowUp,
      this.followUpId,
      this.priority
      );
}
