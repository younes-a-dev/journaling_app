import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_journal/core/resources/data_state.dart';
import 'package:trading_journal/core/usecase/use_case.dart';
import 'package:trading_journal/features/tasks/domin/entity/task.dart';
import 'package:trading_journal/features/tasks/domin/usecase/add_task_usecase.dart';
import 'package:trading_journal/features/tasks/domin/usecase/delete_all_tasks.dart';
import 'package:trading_journal/features/tasks/domin/usecase/delete_task_usecase.dart';
import 'package:trading_journal/features/tasks/domin/usecase/get_tasks_usecase.dart';
import 'package:trading_journal/features/tasks/domin/usecase/update_task_usecase.dart';
import 'package:trading_journal/features/tasks/presentation/bloc/add_task_status.dart';
import 'package:trading_journal/features/tasks/presentation/bloc/delete_all_tasks_status.dart';
import 'package:trading_journal/features/tasks/presentation/bloc/delete_task_status.dart';
import 'package:trading_journal/features/tasks/presentation/bloc/get_tasks_status.dart';
import 'package:trading_journal/features/tasks/presentation/bloc/update_task_status.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final AddTaskUsecase addTaskUsecase;
  final DeleteTaskUsecase deleteTaskUsecase;
  final GetTasksUsecase getTasksUsecase;
  final UpdateTaskUsecase updateTaskUsecase;
  final DeleteAllTasksUsecase deleteAllTasksUsecase;

  TaskBloc(this.addTaskUsecase, this.deleteTaskUsecase, this.getTasksUsecase,
      this.updateTaskUsecase, this.deleteAllTasksUsecase)
      : super(TaskState(
          addTaskStatus: AddTaskLoading(),
          deleteStaskStatus: DeleteTaskLoading(),
          getTasksStatus: GetTasksLoading(),
          updateTaskStatus: UpdateTaskLoading(),
          deleteAllTasksStatus: DeleteAllTasksLoading(),
        )) {
    on<AddTaskEvent>((event, emit) async {
      emit(state.copyWith(newAddTaskStatus: AddTaskLoading()));

      DataState dataState = await addTaskUsecase(event.task);

      if (dataState is DataSuccess) {
        emit(
            state.copyWith(newAddTaskStatus: AddTaskCompleted(dataState.data)));
      }
      if (dataState is DataFailed) {
        emit(state.copyWith(newAddTaskStatus: AddTaskError(dataState.error!)));
      }
    });

    on<DeleteTaskEvent>((event, emit) async {
      emit(state.copyWith(newDeleteTaskStatus: DeleteTaskLoading()));

      DataState dataState = await deleteTaskUsecase(event.task);

      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newDeleteTaskStatus: DeleteTaskCompleted(dataState.data)));
      }

      if (dataState is DataFailed) {
        emit(state.copyWith(
            newDeleteTaskStatus: DeleteTaskError(dataState.error!)));
      }
    });

    on<GetTasksEvent>((event, emit) async {
      emit(state.copyWith(newGetTasksStatus: GetTasksLoading()));

      DataState dataState = await getTasksUsecase(NoParams());

      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newGetTasksStatus: GetTasksCompleted(dataState.data)));
        print('get task event is called');
      }

      if (dataState is DataFailed) {
        emit(
            state.copyWith(newGetTasksStatus: GetTasksError(dataState.error!)));
      }
    });

    on<UpdateTaskEvent>((event, emit) async {
      emit(state.copyWith(newUpdateTaskStatus: UpdateTaskLoading()));

      DataState dataState = await updateTaskUsecase(event.task);

      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newUpdateTaskStatus: UpdateTaskCompleted(dataState.data)));
      }

      if (dataState is DataFailed) {
        emit(state.copyWith(
            newUpdateTaskStatus: UpdateTaskError(dataState.error!)));
      }
    });

    on<DeleteAllTasksEvent>((event, emit) async {
      emit(state.copyWith(newDeleteAllTasksStatus: DeleteAllTasksLoading()));

      DataState dataState = await deleteAllTasksUsecase(NoParams());

      if (dataState is DataSuccess) {
        emit(
            state.copyWith(newDeleteAllTasksStatus: DeleteAllTasksCompleted()));
        add(GetTasksEvent());
      }

      if (dataState is DataFailed) {
        emit(state.copyWith(
            newDeleteAllTasksStatus: DeleteAllTasksError(dataState.error!)));
      }
    });
  }
}
