import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trading_journal/features/journal/data/repository/journal_repository_impl.dart';
import 'package:trading_journal/features/journal/domin/entity/journal.dart';
import 'package:trading_journal/features/journal/domin/repository/journal_repository.dart';
import 'package:trading_journal/features/journal/domin/usecase/add_journal_usecase.dart';
import 'package:trading_journal/features/journal/domin/usecase/delete_all_journals_usecase.dart';
import 'package:trading_journal/features/journal/domin/usecase/delete_journal_usecase.dart';
import 'package:trading_journal/features/journal/domin/usecase/get_journals_usecase.dart';
import 'package:trading_journal/features/journal/presentation/bloc/journal_bloc.dart';
// import 'package:trading_journal/features/note/data/model/note_model.dart';
import 'package:trading_journal/features/note/data/repository/note_repository_impl.dart';
import 'package:trading_journal/features/note/domin/repository/note_repository.dart';
import 'package:trading_journal/features/note/domin/usecase/add_note_usecase.dart';
import 'package:trading_journal/features/note/domin/usecase/delete_all_notes_usecase.dart';
import 'package:trading_journal/features/note/domin/usecase/delete_note_usecase.dart';
import 'package:trading_journal/features/note/domin/usecase/get_note_detail_usecase.dart';
import 'package:trading_journal/features/note/domin/usecase/get_notes_usecase.dart';
import 'package:trading_journal/features/note/presentation/bloc/note_bloc.dart';
import 'package:trading_journal/features/tasks/data/repository/task_repository_impl.dart';
import 'package:trading_journal/features/tasks/domin/repository/task_repository.dart';
import 'package:trading_journal/features/tasks/domin/usecase/add_task_usecase.dart';
import 'package:trading_journal/features/tasks/domin/usecase/delete_task_usecase.dart';
import 'package:trading_journal/features/tasks/domin/usecase/get_tasks_usecase.dart';
import 'package:trading_journal/features/tasks/domin/usecase/update_task_usecase.dart';
import 'package:trading_journal/features/tasks/presentation/bloc/task_bloc.dart';

import 'features/note/domin/entity/note.dart';
import 'features/tasks/domin/entity/task.dart';
import 'features/tasks/domin/usecase/delete_all_tasks.dart';

// import 'package:trading_journal/features/market/presentation/bloc/home_bloc.dart';

GetIt locator = GetIt.instance;

setup() async {
  // locator.registerSingleton<ApiProvider>(ApiProvider());

  // Register Hive box
  // final noteBox = await Hive.openBox<NoteModel>('notes');
  locator.registerLazySingleton(() => Hive.box<Note>('notes'));
  locator.registerLazySingleton(() => Hive.box<Journal>('journals'));
  locator.registerLazySingleton(() => Hive.box<Task>('tasks'));
  // locator.registerLazySingleton(() => noteBox);

  // Register repository
  locator.registerSingleton<NoteRepository>(NoteRepositoryImpl(locator()));
  locator
      .registerSingleton<JournalRepository>(JournalRepositoryImpl(locator()));
  locator.registerSingleton<TaskRepository>(TaskRepositoryImpl(locator()));
  // locator.registerSingleton<CryptoRepository>(CryptoRepositoryImpl(locator()));

  //usecase
  // Note
  locator.registerSingleton<GetNotesUsecase>(GetNotesUsecase(locator()));
  locator.registerSingleton<AddNoteUsecase>(AddNoteUsecase(locator()));
  locator.registerSingleton<DeleteNoteUsecase>(DeleteNoteUsecase(locator()));
  locator
      .registerSingleton<GetNoteDetailUsecase>(GetNoteDetailUsecase(locator()));
  locator.registerSingleton<DeleteAllNotesUsecase>(
      DeleteAllNotesUsecase(locator()));

  // Journal
  locator.registerSingleton<AddJournalUseCase>(AddJournalUseCase(locator()));
  locator.registerSingleton<GetJournalsUsecase>(GetJournalsUsecase(locator()));
  locator
      .registerSingleton<DeleteJournalUsecase>(DeleteJournalUsecase(locator()));
  locator.registerSingleton<DeleteAllJournalsUsecase>(
      DeleteAllJournalsUsecase(locator()));

  // Task usecases
  locator.registerSingleton<AddTaskUsecase>(AddTaskUsecase(locator()));
  locator.registerSingleton<DeleteTaskUsecase>(DeleteTaskUsecase(locator()));
  locator.registerSingleton<GetTasksUsecase>(GetTasksUsecase(locator()));
  locator.registerSingleton<UpdateTaskUsecase>(UpdateTaskUsecase(locator()));
  locator.registerSingleton<DeleteAllTasksUsecase>(
      DeleteAllTasksUsecase(locator()));

  // locator.registerSingleton<GetCoinsUseCase>(GetCoinsUseCase(locator()));
  // locator.registerSingleton<GetGlobalCryptoDataUseCase>(
  //     GetGlobalCryptoDataUseCase(locator()));

  //bloc
  // locator.registerSingleton<HomeBloc>(HomeBloc(locator(), locator()));
  locator.registerSingleton<NoteBloc>(
      NoteBloc(locator(), locator(), locator(), locator(), locator()));
  locator.registerSingleton<JournalBloc>(
      JournalBloc(locator(), locator(), locator(), locator()));
  locator.registerSingleton<TaskBloc>(
      TaskBloc(locator(), locator(), locator(), locator(), locator()));
}
