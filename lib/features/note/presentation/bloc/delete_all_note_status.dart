import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class DeleteAllNoteStatus extends Equatable {}

class DeleteAllNotesLoading extends DeleteAllNoteStatus {
  @override
  List<Object?> get props => [];
}

class DeleteAllNotesCompleted extends DeleteAllNoteStatus {
  @override
  List<Object?> get props => [];
}

class DeleteAllNotesError extends DeleteAllNoteStatus {
  final String error;
  DeleteAllNotesError(this.error);
  
  @override
  List<Object?> get props => [];
}
