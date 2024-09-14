import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import '../../domin/entity/task.dart';

@immutable
abstract class GetTasksStatus extends Equatable {}

class GetTasksLoading extends GetTasksStatus {
  @override
  List<Object?> get props => [];
}

class GetTasksCompleted extends GetTasksStatus {
  final List<Task> tasks;
  GetTasksCompleted(this.tasks);
  
  @override
  List<Object?> get props => [tasks];
}

class GetTasksError extends GetTasksStatus {
  final String error;
  GetTasksError(this.error);

  @override
  List<Object?> get props => [error];
}
