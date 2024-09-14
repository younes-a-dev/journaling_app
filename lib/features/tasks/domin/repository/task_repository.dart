import '../../../../core/resources/data_state.dart';
import '../entity/task.dart';

abstract class TaskRepository {
  Future<DataState<List<Task>>> getTasks();
  Future<DataState<Task>> addTask(Task task);
  Future<DataState<Task>> deleteTask(Task task);
  //update task check mark
  Future<DataState<Task>> updateTask(Task task);
  Future<DataState<String>> deleteAllTasks();
}
