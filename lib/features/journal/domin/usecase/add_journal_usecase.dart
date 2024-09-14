import 'package:trading_journal/core/resources/data_state.dart';
import 'package:trading_journal/core/usecase/use_case.dart';
import 'package:trading_journal/features/journal/domin/entity/journal.dart';
import 'package:trading_journal/features/journal/domin/repository/journal_repository.dart';


class AddJournalUseCase extends UseCase<DataState<Journal>, Journal> {
  final JournalRepository _journalRepository;
  AddJournalUseCase(this._journalRepository);
  @override
  Future<DataState<Journal>> call(Journal param) {
    return _journalRepository.addJournal(param);
  }
}
