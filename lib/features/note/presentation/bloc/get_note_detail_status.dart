import 'package:equatable/equatable.dart';
import 'package:trading_journal/features/note/domin/entity/note.dart';

abstract class GetNoteDetailStatus extends Equatable {}

class GetNoteDetailLoading extends GetNoteDetailStatus {
  // final String id;
  // GetNoteDetailLoading(this.id);
  @override
  List<Object?> get props => [];
}

class GetNoteDetailCompleted extends GetNoteDetailStatus {
  final Note note;
  GetNoteDetailCompleted(this.note);
  @override
  List<Object?> get props => [note];
}

class GetNoteDetailError extends GetNoteDetailStatus {
  final String message;
  GetNoteDetailError(this.message);
  @override
  List<Object?> get props => [message];
}
