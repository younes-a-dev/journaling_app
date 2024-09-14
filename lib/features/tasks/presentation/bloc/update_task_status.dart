import 'package:flutter/material.dart';

import '../../domin/entity/task.dart';

@immutable
abstract class UpdateTaskStatus {}

class UpdateTaskLoading extends UpdateTaskStatus {}

class UpdateTaskCompleted extends UpdateTaskStatus {
  final Task task;
  UpdateTaskCompleted(this.task);
}

class UpdateTaskError extends UpdateTaskStatus {
  final String error;
  UpdateTaskError(this.error);
}
