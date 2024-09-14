import 'package:trading_journal/core/usecase/use_case.dart';
import 'package:trading_journal/features/note/domin/entity/note.dart';
import 'package:trading_journal/features/note/domin/repository/note_repository.dart';

import '../../../../core/resources/data_state.dart';

class GetNotesUsecase extends UseCase<DataState<List<Note>>, NoParams> {
  final NoteRepository _noteRepository;

  GetNotesUsecase(this._noteRepository);

  @override
  Future<DataState<List<Note>>> call(NoParams param) {
    return _noteRepository.getNotes();
  }
}
