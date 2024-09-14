import 'package:flutter/material.dart';

import '../../domin/entity/journal.dart';

@immutable
abstract class DeleteJournalStatus {}

class DeleteJournalLoading extends DeleteJournalStatus {}

class DeleteJournalCompleted extends DeleteJournalStatus {
  final Journal journal;
  DeleteJournalCompleted(this.journal);
}

class DeleteJournalError extends DeleteJournalStatus {
  final String error;
  DeleteJournalError(this.error);
}
