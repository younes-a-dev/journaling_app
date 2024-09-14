import 'package:trading_journal/core/resources/data_state.dart';
import 'package:trading_journal/features/note/domin/entity/note.dart';

abstract class NoteRepository {
  Future<DataState<List<Note>>> getNotes();
  Future<DataState<Note>> addNote(Note note);
  Future<DataState<Note>> deleteNote(Note note);
  //TODO:delete get note detail
  Future<DataState<Note>> getNoteDetail(String title);
  // Future<DataState<Note>> updateNote(Note note);
  Future<DataState<String>> deleteAllNotes();
}
