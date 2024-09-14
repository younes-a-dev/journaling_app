import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_journal/core/resources/data_state.dart';
import 'package:trading_journal/core/usecase/use_case.dart';
import 'package:trading_journal/features/journal/domin/usecase/add_journal_usecase.dart';
import 'package:trading_journal/features/journal/domin/usecase/delete_all_journals_usecase.dart';
import 'package:trading_journal/features/journal/domin/usecase/delete_journal_usecase.dart';
import 'package:trading_journal/features/journal/domin/usecase/get_journals_usecase.dart';
import 'package:trading_journal/features/journal/presentation/bloc/add_journal_status.dart';
import 'package:trading_journal/features/journal/presentation/bloc/delete_all_journals_status.dart';
import 'package:trading_journal/features/journal/presentation/bloc/delete_journal_status.dart';
import 'package:trading_journal/features/journal/presentation/bloc/get_journals_status.dart';

import '../../domin/entity/journal.dart';

part 'journal_event.dart';
part 'journal_state.dart';

class JournalBloc extends Bloc<JournalEvent, JournalState> {
  final AddJournalUseCase _addJournalUseCase;
  final DeleteJournalUsecase _deleteJournalUsecase;
  final GetJournalsUsecase _getJournalsUsecase;
  final DeleteAllJournalsUsecase _deleteAllJournalsUsecase;

  JournalBloc(this._addJournalUseCase, this._deleteJournalUsecase,
      this._getJournalsUsecase, this._deleteAllJournalsUsecase)
      : super(JournalState(
            addJournalStatus: AddJournalLoading(),
            deleteJournalStatus: DeleteJournalLoading(),
            getJournalsStatus: GetJournalsLoading(),
            deleteAllJournalsStatus: DeleteAllJournalsLoading())) {
    on<AddJournalEvent>((event, emit) async {
      emit(state.copyWith(newAddJournalStatus: AddJournalLoading()));

      DataState dataState = await _addJournalUseCase(event.journal);

      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newAddJournalStatus: AddJournalCompleted(dataState.data)));
      }

      if (dataState is DataFailed) {
        emit(state.copyWith(
            newAddJournalStatus: AddJournalError(dataState.error!)));
      }
    });

    on<GetJournalsEvent>((event, emit) async {
      emit(state.copyWith(newGetJournalsStatus: GetJournalsLoading()));

      DataState dataState = await _getJournalsUsecase(NoParams());

      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newGetJournalsStatus: GetJournalsCompleted(dataState.data)));
      }

      if (dataState is DataFailed) {
        emit(state.copyWith(
            newGetJournalsStatus: GetJournalsError(dataState.error!)));
      }
    });

    on<DeleteJournalEvent>((event, emit) async {
      emit(state.copyWith(newDeleteJournalStatus: DeleteJournalLoading()));

      DataState dataState = await _deleteJournalUsecase(event.journal);

      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newDeleteJournalStatus: DeleteJournalCompleted(dataState.data)));
      }

      if (dataState is DataFailed) {
        emit(state.copyWith(
            newDeleteJournalStatus: DeleteJournalError(dataState.error!)));
      }
    });

    // delete all journals
    on<DeleteAllJournalsEvent>((event, emit) async {
      emit(state.copyWith(
          newDeleteAllJournalsStatus: DeleteAllJournalsLoading()));

      DataState dataState = await _deleteAllJournalsUsecase(NoParams());

      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newDeleteAllJournalsStatus: DeleteAllJournalsCompleted()));
        add(GetJournalsEvent());
      }

      if (dataState is DataFailed) {
        emit(state.copyWith(
            newDeleteAllJournalsStatus:
                DeleteAllJournalsError(dataState.error!)));
      }
    });
  }
}
