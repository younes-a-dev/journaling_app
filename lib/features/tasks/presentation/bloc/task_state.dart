part of 'task_bloc.dart';

class TaskState {
  final AddTaskStatus addTaskStatus;
  final DeleteTaskStatus deleteStaskStatus;
  final GetTasksStatus getTasksStatus;
  final UpdateTaskStatus updateTaskStatus;
  final DeleteAllTasksStatus deleteAllTasksStatus;

  TaskState({
    required this.addTaskStatus,
    required this.deleteStaskStatus,
    required this.getTasksStatus,
    required this.updateTaskStatus,
    required this.deleteAllTasksStatus,
  });

  TaskState copyWith({
    AddTaskStatus? newAddTaskStatus,
    DeleteTaskStatus? newDeleteTaskStatus,
    GetTasksStatus? newGetTasksStatus,
    UpdateTaskStatus? newUpdateTaskStatus,
    DeleteAllTasksStatus? newDeleteAllTasksStatus,
  }) {
    return TaskState(
      addTaskStatus: newAddTaskStatus ?? addTaskStatus,
      deleteStaskStatus: newDeleteTaskStatus ?? deleteStaskStatus,
      getTasksStatus: newGetTasksStatus ?? getTasksStatus,
      updateTaskStatus: newUpdateTaskStatus ?? updateTaskStatus,
      deleteAllTasksStatus: newDeleteAllTasksStatus ?? deleteAllTasksStatus,
    );
  }
}
