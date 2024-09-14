import 'package:trading_journal/core/resources/data_state.dart';
import 'package:trading_journal/core/usecase/use_case.dart';
import 'package:trading_journal/features/note/domin/repository/note_repository.dart';

class DeleteAllNotesUsecase extends UseCase<DataState<String>, NoParams> {
  final NoteRepository _noteRepository;
  DeleteAllNotesUsecase(this._noteRepository);


  @override
  Future<DataState<String>> call(NoParams param) {
    return _noteRepository.deleteAllNotes();
  }
}
