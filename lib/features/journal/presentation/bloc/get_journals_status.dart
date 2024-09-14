import 'package:flutter/material.dart';
import 'package:trading_journal/features/journal/domin/entity/journal.dart';

@immutable
abstract class GetJournalsStatus {}

class GetJournalsLoading extends GetJournalsStatus {}

class GetJournalsCompleted extends GetJournalsStatus {
  final List<Journal> journals;
  GetJournalsCompleted(this.journals);
}

class GetJournalsError extends GetJournalsStatus {
  final String error;
  GetJournalsError(this.error);
}
