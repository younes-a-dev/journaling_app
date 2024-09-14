import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class DeleteAllJournalsStatus extends Equatable {}

class DeleteAllJournalsLoading extends DeleteAllJournalsStatus {
  @override
  List<Object?> get props => [];
}

class DeleteAllJournalsCompleted extends DeleteAllJournalsStatus {
  @override
  List<Object?> get props => [];
}

class DeleteAllJournalsError extends DeleteAllJournalsStatus {
  final String error;
  DeleteAllJournalsError(this.error);

  @override
  List<Object?> get props => [error];
}
