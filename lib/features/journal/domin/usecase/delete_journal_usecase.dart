import 'package:trading_journal/core/usecase/use_case.dart';
import 'package:trading_journal/features/journal/domin/entity/journal.dart';
import 'package:trading_journal/features/journal/domin/repository/journal_repository.dart';

import '../../../../core/resources/data_state.dart';

class DeleteJournalUsecase extends UseCase<DataState<Journal>, Journal> {
  final JournalRepository _journalRepository;
  DeleteJournalUsecase(this._journalRepository);
  @override
  Future<DataState<Journal>> call(Journal param) {
    return _journalRepository.deleteJournal(param);
  }
}
