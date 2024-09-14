import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trading_journal/features/note/domin/entity/note.dart';


@immutable
abstract class GetNotesStatus extends Equatable {}

class GetNotesLoading extends GetNotesStatus {
  @override
  List<Object?> get props => [];
}

class GetNotesCompleted extends GetNotesStatus {
  final List<Note> notes;
  GetNotesCompleted(this.notes);
  @override
  List<Object?> get props => [notes];
}

class GetNotesError extends GetNotesStatus {
  final String message;
  GetNotesError(this.message);

  @override
  List<Object?> get props => [message];
}
