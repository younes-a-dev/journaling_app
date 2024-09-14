import 'package:hive_flutter/hive_flutter.dart';
import 'package:trading_journal/core/resources/data_state.dart';
import 'package:trading_journal/features/journal/domin/entity/journal.dart';
import 'package:trading_journal/features/journal/domin/repository/journal_repository.dart';

class JournalRepositoryImpl extends JournalRepository {
  final Box<Journal> journalsBox;
  JournalRepositoryImpl(this.journalsBox);

  @override
  Future<DataState<Journal>> addJournal(Journal journal) async {
    try {
      journalsBox.put(
          journal.date.toString(),
          Journal(
              title: journal.title,
              imageByte: journal.imageByte,
              description: journal.description,
              risk: journal.risk,
              status: journal.status,
              direction: journal.direction,
              selectedDateTime: journal.selectedDateTime,
              riskReward: journal.riskReward,
              colorValue: journal.colorValue,
              date: journal.date));
      return DataSuccess(journal);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<Journal>> deleteJournal(Journal journal) async {
    try {
      await journalsBox.values
          .firstWhere((item) =>
              item.date == journal.date &&
              item.title == journal.title)
          .delete();
      return DataSuccess(journal);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<List<Journal>>> getJournals() async {
    try {
      final journals = journalsBox.values.toList();
      return DataSuccess(journals);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<String>> deleteAllJournals() async {
    try {
      await journalsBox.clear();
      return const DataSuccess('Deleted Successfully');
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
