import 'package:trading_journal/core/resources/data_state.dart';
import 'package:trading_journal/core/usecase/use_case.dart';
import 'package:trading_journal/features/note/domin/entity/note.dart';
import 'package:trading_journal/features/note/domin/repository/note_repository.dart';

class DeleteNoteUsecase extends UseCase<DataState<Note>, Note> {
  final NoteRepository _noteRepository;
  DeleteNoteUsecase(this._noteRepository);
  @override
  Future<DataState<Note>> call(Note param) {
    return _noteRepository.deleteNote(param);
  }
}
