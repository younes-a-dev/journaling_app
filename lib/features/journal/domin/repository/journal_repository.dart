import '../../../../core/resources/data_state.dart';
import '../entity/journal.dart';

abstract class JournalRepository {
  Future<DataState<List<Journal>>> getJournals();
  Future<DataState<Journal>> addJournal(Journal journal);
  Future<DataState<Journal>> deleteJournal(Journal journal);
  Future<DataState<String>> deleteAllJournals();
}
