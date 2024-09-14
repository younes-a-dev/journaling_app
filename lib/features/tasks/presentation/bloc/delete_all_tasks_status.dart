import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';


@immutable
abstract class DeleteAllTasksStatus extends Equatable {}

class DeleteAllTasksLoading extends DeleteAllTasksStatus {
  @override
  List<Object?> get props => [];
}

class DeleteAllTasksCompleted extends DeleteAllTasksStatus {
 
  @override
  List<Object?> get props => [];
}

class DeleteAllTasksError extends DeleteAllTasksStatus {
  final String error;
  DeleteAllTasksError(this.error);

  @override
  List<Object?> get props => [error];
}
