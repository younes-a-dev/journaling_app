import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import '../../domin/entity/task.dart';

@immutable
abstract class AddTaskStatus extends Equatable{}

class AddTaskLoading extends AddTaskStatus {
  @override

  List<Object?> get props => [];
}

class AddTaskCompleted extends AddTaskStatus {
  final Task task;
  AddTaskCompleted(this.task);
  
  @override

  List<Object?> get props => [task];
}

class AddTaskError extends AddTaskStatus {
  final String error;
  AddTaskError(this.error);
  
  @override

  List<Object?> get props => [error];
}
