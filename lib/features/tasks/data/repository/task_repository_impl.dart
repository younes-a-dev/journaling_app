import 'package:hive_flutter/hive_flutter.dart';
import 'package:trading_journal/core/resources/data_state.dart';
import 'package:trading_journal/features/tasks/domin/entity/task.dart';
import 'package:trading_journal/features/tasks/domin/repository/task_repository.dart';

import '../../../../core/utils/notification_service.dart';

class TaskRepositoryImpl extends TaskRepository {
  final Box<Task> tasksBox;
  TaskRepositoryImpl(this.tasksBox);
  @override
  Future<DataState<Task>> addTask(Task task) async {
    try {
      tasksBox.put(task.createdDate.toString(), task);
      if (task.alarmID != null) {
        NotificationService.scheduledNotification('Trading Journal',
            task.content, task.secendsToRemind, task.alarmID!);
      }
      return DataSuccess(task);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<Task>> deleteTask(Task task) async {
    try {
      await tasksBox.values
          .firstWhere((item) => item.createdDate == task.createdDate)
          .delete();
      NotificationService.deleteSchedule(task.alarmID!);
      return DataSuccess(task);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<List<Task>>> getTasks() async {
    try {
      // taskBox.clear();
      final tasks = tasksBox.values.toList();
      return DataSuccess(tasks);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<Task>> updateTask(Task task) async {
    try {
      final tassk = tasksBox.values.firstWhere(
          (t) => t.createdDate == task.createdDate && t.content == task.content);
      tassk.isChecked = task.isChecked;
      tassk.save();

      return DataSuccess(tassk);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<String>> deleteAllTasks() async {
    try {
      await tasksBox.clear();
      NotificationService.deleteAllSchedule();
      return  const DataSuccess('Deleted Successfully');
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
