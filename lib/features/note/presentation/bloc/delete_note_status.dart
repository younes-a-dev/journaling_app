import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:trading_journal/features/note/domin/entity/note.dart';

@immutable
abstract class DeleteNoteStatus extends Equatable {}

class DeleteNoteLoading extends DeleteNoteStatus {
  @override
  List<Object?> get props => [];
}

class DeleteNoteCompleted extends DeleteNoteStatus {
  final Note note;
  DeleteNoteCompleted(this.note);

  @override
  List<Object?> get props => [note];
}

class DeleteNoteError extends DeleteNoteStatus {
  final String message;
  DeleteNoteError(this.message);

  @override
  List<Object?> get props => [message];
}
