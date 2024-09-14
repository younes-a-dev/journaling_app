import 'package:trading_journal/core/usecase/use_case.dart';
import 'package:trading_journal/features/journal/domin/repository/journal_repository.dart';

import '../../../../core/resources/data_state.dart';

class DeleteAllJournalsUsecase extends UseCase<DataState<String>, NoParams> {
  final JournalRepository _journalRepository;
  DeleteAllJournalsUsecase(this._journalRepository);

  @override
  Future<DataState<String>> call(NoParams param) {
    return _journalRepository.deleteAllJournals();
  }
}
