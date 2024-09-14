import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_journal/core/usecase/use_case.dart';
import 'package:trading_journal/features/note/domin/entity/note.dart';
import 'package:trading_journal/features/note/domin/usecase/add_note_usecase.dart';
import 'package:trading_journal/features/note/domin/usecase/delete_all_notes_usecase.dart';
import 'package:trading_journal/features/note/domin/usecase/delete_note_usecase.dart';
import 'package:trading_journal/features/note/domin/usecase/get_note_detail_usecase.dart';
import 'package:trading_journal/features/note/domin/usecase/get_notes_usecase.dart';
import 'package:trading_journal/features/note/presentation/bloc/add_note_status.dart';
import 'package:trading_journal/features/note/presentation/bloc/delete_all_note_status.dart';
import 'package:trading_journal/features/note/presentation/bloc/delete_note_status.dart';
import 'package:trading_journal/features/note/presentation/bloc/get_note_detail_status.dart';
import 'package:trading_journal/features/note/presentation/bloc/get_notes_status.dart';

import '../../../../core/resources/data_state.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final GetNotesUsecase _getNotesUsecase;
  final AddNoteUsecase _addNoteUsecase;
  final DeleteNoteUsecase _deleteNoteUsecase;
  final GetNoteDetailUsecase _getNoteDetailUsecase;
  final DeleteAllNotesUsecase _deleteAllNotesUsecase;

  NoteBloc(this._getNotesUsecase, this._addNoteUsecase, this._deleteNoteUsecase,
      this._getNoteDetailUsecase, this._deleteAllNotesUsecase)
      : super(NoteState(
          getNotesStatus: GetNotesLoading(),
          addNoteStatus: AddNoteLoading(),
          deleteNoteStatus: DeleteNoteLoading(),
          getNoteDetailStatus: GetNoteDetailLoading(),
          deleteAllNoteStatus: DeleteAllNotesLoading(),
        )) {
    // Load Notes list
    on<GetNotesEvent>((event, emit) async {
      emit(state.copyWith(newGetNotesStatus: GetNotesLoading()));

      DataState dataState = await _getNotesUsecase(NoParams());

      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newGetNotesStatus: GetNotesCompleted(dataState.data)));
      }

      if (dataState is DataFailed) {
        emit(
            state.copyWith(newGetNotesStatus: GetNotesError(dataState.error!)));
      }
    });

    // Get note detail
    on<GetNoteDetailEvent>((event, emit) async {
      emit(state.copyWith(newGetNoteDetailStatus: GetNoteDetailLoading()));

      DataState dataState = await _getNoteDetailUsecase(event.title);

      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newGetNoteDetailStatus: GetNoteDetailCompleted(dataState.data)));
      }

      if (dataState is DataFailed) {
        emit(state.copyWith(
            newGetNoteDetailStatus: GetNoteDetailError(dataState.error!)));
      }
    });

    // Add new note
    on<AddNotesEvent>((event, emit) async {
      emit(state.copyWith(newAddNoteStatus: AddNoteLoading()));

      DataState dataState = await _addNoteUsecase(event.note);

      if (dataState is DataSuccess) {
        print('success');
        emit(
            state.copyWith(newAddNoteStatus: AddNoteCompleted(dataState.data)));
      }

      if (dataState is DataFailed) {
        print('failed');
        emit(state.copyWith(newAddNoteStatus: AddNoteError(dataState.error!)));
      }
    });

    // Delete Note
    on<DeleteNoteEvent>((event, emit) async {
      emit(state.copyWith(newDeleteNoteStatus: DeleteNoteLoading()));

      DataState dataState = await _deleteNoteUsecase(event.note);

      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newDeleteNoteStatus: DeleteNoteCompleted(dataState.data)));
      }

      if (dataState is DataFailed) {
        emit(state.copyWith(
            newDeleteNoteStatus: DeleteNoteError(dataState.error!)));
      }
    });

    // Delete All Notes
    on<DeleteAllNotesEvent>((event, emit) async {
      emit(state.copyWith(newDeleteAllNotesStatus: DeleteAllNotesLoading()));

      DataState dataState = await _deleteAllNotesUsecase(NoParams());

      if (dataState is DataSuccess) {
        emit(
            state.copyWith(newDeleteAllNotesStatus: DeleteAllNotesCompleted()));
        add(GetNotesEvent());
      }

      if (dataState is DataFailed) {
        emit(state.copyWith(
            newDeleteAllNotesStatus: DeleteAllNotesError(dataState.error!)));
      }
    });
  }
}
