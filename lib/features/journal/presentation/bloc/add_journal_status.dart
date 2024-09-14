import 'package:flutter/material.dart';
import 'package:trading_journal/features/journal/domin/entity/journal.dart';

@immutable
abstract class AddJournalStatus {}

class AddJournalLoading extends AddJournalStatus {}

class AddJournalCompleted extends AddJournalStatus {
  final Journal journal;
  AddJournalCompleted(this.journal);
}

class AddJournalError extends AddJournalStatus {
  final String error;
  AddJournalError(this.error);
}
