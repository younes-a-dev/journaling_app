part of 'note_bloc.dart';

@immutable
abstract class NoteEvent {}

class GetNotesEvent extends NoteEvent {}

class AddNotesEvent extends NoteEvent {
  final Note note;
  AddNotesEvent(this.note);
}

class DeleteNoteEvent extends NoteEvent {
  final Note note;
  DeleteNoteEvent(this.note);
}


class DeleteAllNotesEvent extends NoteEvent{}

class GetNoteDetailEvent extends NoteEvent {
  final String title;
  GetNoteDetailEvent(this.title);
}
