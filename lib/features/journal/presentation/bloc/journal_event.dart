part of 'journal_bloc.dart';

@immutable
abstract class JournalEvent {}

class AddJournalEvent extends JournalEvent {
  final Journal journal;
  AddJournalEvent(this.journal);
}

class DeleteJournalEvent extends JournalEvent {
  final Journal journal;
  DeleteJournalEvent(this.journal);
}

class DeleteAllJournalsEvent extends JournalEvent{}

class GetJournalsEvent extends JournalEvent {}
