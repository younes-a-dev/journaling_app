import 'package:trading_journal/core/resources/data_state.dart';
import 'package:trading_journal/core/usecase/use_case.dart';
import 'package:trading_journal/features/note/domin/entity/note.dart';
import 'package:trading_journal/features/note/domin/repository/note_repository.dart';

class GetNoteDetailUsecase extends UseCase<DataState<Note>, String> {
  final NoteRepository _noteRepository;
  GetNoteDetailUsecase(this._noteRepository);
  @override
  Future<DataState<Note>> call(String param) {
    return _noteRepository.getNoteDetail(param);
  }
}
