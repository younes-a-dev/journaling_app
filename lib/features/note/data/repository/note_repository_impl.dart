import 'package:trading_journal/core/resources/data_state.dart';
import 'package:trading_journal/features/note/domin/entity/note.dart';
import 'package:trading_journal/features/note/domin/repository/note_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NoteRepositoryImpl extends NoteRepository {
  final Box<Note> notesBox;

  NoteRepositoryImpl(this.notesBox);

  @override
  Future<DataState<Note>> addNote(Note note) async {
    try {
      notesBox.put(
          note.dateTime.toString(),
          Note(
            title: note.title,
            content: note.content,
            dateTime: note.dateTime,
            colorValue: note.colorValue,
          ));
      return DataSuccess(note);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<Note>> deleteNote(Note note) async {
    try {
      await notesBox.values
          .firstWhere((model) =>
              model.title == note.title && model.content == note.content)
          .delete();
      // await deletedNote.delete();
      return DataSuccess(note);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<List<Note>>> getNotes() async {
    try {
      final notes = notesBox.values.toList();
      // List<Note> notes =
      //     noteModels.map((model) => model.toEntity()).toList();
      return DataSuccess(notes);
    } catch (e) {
      return const DataFailed('Please check your connection');
    }
  }

  @override
  Future<DataState<Note>> getNoteDetail(String title) async {
    try {
      final note = notesBox.values.toList().firstWhere((e) => title == e.title);
      // Note note = noteModel.toEntity();
      return DataSuccess(note);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<String>> deleteAllNotes() async {
    try {
      await notesBox.clear();
      return const DataSuccess('Deleted successffuly');
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
