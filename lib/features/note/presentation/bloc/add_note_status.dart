import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:trading_journal/features/note/domin/entity/note.dart';

@immutable
abstract class AddNoteStatus extends Equatable {}

class AddNoteLoading extends AddNoteStatus {
  @override
  List<Object?> get props => [];
}

class AddNoteCompleted extends AddNoteStatus {
  final Note note;
  AddNoteCompleted(this.note);

  @override
  List<Object?> get props => [note];
}

class AddNoteError extends AddNoteStatus {
  final String message;
  AddNoteError(this.message);
  @override
  List<Object?> get props => [message];
}
