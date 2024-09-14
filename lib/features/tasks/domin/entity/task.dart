import 'package:hive_flutter/hive_flutter.dart';

part 'task.g.dart';

@HiveType(typeId: 3)
class Task extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String content;
  @HiveField(2)
  final DateTime dateTime;
  @HiveField(3)
  bool isChecked;
  @HiveField(4)
  final int? alarmID;
  @HiveField(5)
  final int? secendsToRemind;
  @HiveField(6)
  final String? timeOfRemider;
  @HiveField(7)
  final DateTime createdDate;

  Task({
    required this.id,
    required this.content,
    required this.dateTime,
    this.isChecked = false,
    this.alarmID,
    this.secendsToRemind,
    this.timeOfRemider,
    required this.createdDate,
  });
}
