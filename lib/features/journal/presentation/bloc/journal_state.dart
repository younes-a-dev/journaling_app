part of 'journal_bloc.dart';

class JournalState {
  AddJournalStatus addJournalStatus;
  DeleteJournalStatus deleteJournalStatus;
  GetJournalsStatus getJournalsStatus;
  DeleteAllJournalsStatus deleteAllJournalsStatus;

  JournalState(
      {required this.addJournalStatus,
      required this.deleteJournalStatus,
      required this.getJournalsStatus,
      required this.deleteAllJournalsStatus,
      });

  JournalState copyWith({
    AddJournalStatus? newAddJournalStatus,
    DeleteJournalStatus? newDeleteJournalStatus,
    GetJournalsStatus? newGetJournalsStatus,
    DeleteAllJournalsStatus? newDeleteAllJournalsStatus,
  }) {
    return JournalState(
        addJournalStatus: newAddJournalStatus ?? addJournalStatus,
        deleteJournalStatus: newDeleteJournalStatus ?? deleteJournalStatus,
        getJournalsStatus: newGetJournalsStatus ?? getJournalsStatus,
        deleteAllJournalsStatus: newDeleteAllJournalsStatus ?? deleteAllJournalsStatus,
        );
  }
}
