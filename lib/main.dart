import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trading_journal/core/widgets/splash_screen.dart';
import 'package:trading_journal/features/journal/domin/entity/journal.dart';
import 'package:trading_journal/features/journal/presentation/bloc/journal_bloc.dart';
import 'package:trading_journal/features/journal/presentation/screens/full_screen_image.dart';
import 'package:trading_journal/features/journal/presentation/screens/journal_add_up_screen.dart';
import 'package:trading_journal/features/journal/presentation/screens/journal_detail_screen.dart';
import 'package:trading_journal/features/note/presentation/bloc/note_bloc.dart';
import 'package:trading_journal/features/tasks/domin/entity/task.dart';
import 'package:trading_journal/features/tasks/presentation/screens/notifications_screen.dart';
import 'core/utils/notification_service.dart';
import 'features/note/domin/entity/note.dart';
import 'features/tasks/presentation/bloc/task_bloc.dart';
import 'locator.dart';

import './features/note/presentation/screen/note_detail_screen.dart';

// void main() async {
//   // init locator
//   await Hive.initFlutter();
//   Hive.registerAdapter(NoteModelAdapter());
//   await Hive.openBox<NoteModel>('notes');
//   await setup();
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     title: 'MonMan',
//     theme: ThemeData(
//       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       useMaterial3: true,
//     ),
//     home: MultiBlocProvider(
//       providers: [
//         // BlocProvider(create: (_) => locator<HomeBloc>()),
//         BlocProvider(create: (_) => locator<NoteBloc>()),
//       ],
//       child: const MainWrapper(),
//     ),
//     routes: {
//       NoteDetailScreen.routeName: (ctx) => NoteDetailScreen(),
//     },
//   ));
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService.init();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(JournalAdapter());
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Note>('notes');
  await Hive.openBox<Journal>('journals');
  await Hive.openBox<Task>('tasks');
  await setup();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => locator<NoteBloc>(),
      ),
      BlocProvider(
        create: (_) => locator<JournalBloc>(),
      ),
      BlocProvider(
        create: (_) => locator<TaskBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trading Journal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Raleway',
      ),
      home: const SpashScreen(),
      routes: {
        NoteDetailScreen.routeName: (ctx) => const NoteDetailScreen(),
        JournalAddUpScreen.routeName: (ctx) => const JournalAddUpScreen(),
        JournalDetailScreen.routeName: (ctx) => JournalDetailScreen(),
        FullScreenImage.routeName: (ctx) => const FullScreenImage(),
        NotificationsScreen.routeName: (ctx) => const NotificationsScreen(),
      },
    );
  }
}
