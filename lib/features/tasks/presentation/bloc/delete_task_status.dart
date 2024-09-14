import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:trading_journal/features/tasks/domin/entity/task.dart';

@immutable
abstract class DeleteTaskStatus extends Equatable {}

class DeleteTaskLoading extends DeleteTaskStatus {
  @override
  List<Object?> get props => [];
}

class DeleteTaskCompleted extends DeleteTaskStatus {
  final Task task;
  DeleteTaskCompleted(this.task);
  @override
  List<Object?> get props => [task];
}

class DeleteTaskError extends DeleteTaskStatus {
  final String error;
  DeleteTaskError(this.error);

  @override
  List<Object?> get props => [error];
}
