import 'package:trading_journal/core/resources/data_state.dart';
import 'package:trading_journal/core/usecase/use_case.dart';
import 'package:trading_journal/features/journal/domin/entity/journal.dart';
import 'package:trading_journal/features/journal/domin/repository/journal_repository.dart';

class GetJournalsUsecase extends UseCase<DataState<List<Journal>>, NoParams> {
  final JournalRepository _journalRepository;
  GetJournalsUsecase(this._journalRepository);

  @override
  Future<DataState<List<Journal>>> call(NoParams param) {
    return _journalRepository.getJournals();
  }
}
