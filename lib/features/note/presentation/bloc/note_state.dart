part of 'note_bloc.dart';

class NoteState {
  GetNotesStatus getNotesStatus;
  AddNoteStatus addNoteStatus;
  DeleteNoteStatus deleteNoteStatus;
  GetNoteDetailStatus getNoteDetailStatus;
  DeleteAllNoteStatus deleteAllNoteStatus;
  NoteState({
    required this.getNotesStatus,
    required this.addNoteStatus,
    required this.deleteNoteStatus,
    required this.getNoteDetailStatus,
    required this.deleteAllNoteStatus,
  });

  NoteState copyWith({
    GetNotesStatus? newGetNotesStatus,
    AddNoteStatus? newAddNoteStatus,
    DeleteNoteStatus? newDeleteNoteStatus,
    GetNoteDetailStatus? newGetNoteDetailStatus,
    DeleteAllNoteStatus? newDeleteAllNotesStatus,
  }) {
    return NoteState(
      getNotesStatus: newGetNotesStatus ?? getNotesStatus,
      addNoteStatus: newAddNoteStatus ?? addNoteStatus,
      deleteNoteStatus: newDeleteNoteStatus ?? deleteNoteStatus,
      getNoteDetailStatus: newGetNoteDetailStatus ?? getNoteDetailStatus,
      deleteAllNoteStatus: newDeleteAllNotesStatus ?? deleteAllNoteStatus,
    );
  }
}
