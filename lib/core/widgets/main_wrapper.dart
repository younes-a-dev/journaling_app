import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trading_journal/features/journal/presentation/screens/journal_screen.dart';
import 'package:trading_journal/features/note/presentation/screen/note_screen.dart';

import '../../features/tasks/presentation/screens/tasks_screen.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  final List _pages = [
    const JournalScreen(),
    const NoteScreen(),
    // const ArticlesScreen(),
    // const CalculatorScreen(),
    const TasksScreen(),
  ];

  void changeScreen(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          systemNavigationBarColor: Color(0xff000000), // navigation bar color
        ),
        child: Scaffold(
          body: _pages[_currentIndex],
          bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
                indicatorColor: Colors.transparent,
                elevation: 0,
                labelTextStyle: MaterialStateProperty.all(const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xffbdbdbd),
                ))),
            child: NavigationBar(
              backgroundColor: const Color(0xff000000),
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              selectedIndex: _currentIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(
                    FluentIcons.document_page_top_left_24_regular,
                    color: Color(0xff616161),
                  ),
                  selectedIcon: Icon(
                      FluentIcons.document_page_top_left_24_filled,
                      color: Color(0xffbdbdbd)),
                  label: 'Journals',
                ),
                NavigationDestination(
                  icon: Icon(
                    FluentIcons.notepad_32_regular,
                    color: Color(0xff616161),
                  ),
                  selectedIcon: Icon(
                    FluentIcons.notepad_32_filled,
                    color: Color(0xffbdbdbd),
                  ),
                  label: 'Notes',
                ),
                // NavigationDestination(
                //   icon: Icon(
                //     Icons.menu_book_rounded,
                //     color: Color(0xff616161),
                //   ),
                //   selectedIcon: Icon(
                //     Icons.menu_book_rounded,
                //     color: Color(0xffbdbdbd),
                //   ),
                //   label: 'Articles',
                // ),
                // NavigationDestination(
                //   icon: Icon(
                //     Icons.calculate_rounded,
                //     color: Color(0xff616161),
                //   ),
                //   selectedIcon: Icon(
                //     Icons.calculate_rounded,
                //     color: Color(0xffbdbdbd),
                //   ),
                //   label: 'Calculator',
                // ),
                NavigationDestination(
                  icon: Icon(
                    FluentIcons.clipboard_task_24_regular,
                    color: Color(0xff616161),
                  ),
                  selectedIcon: Icon(
                    FluentIcons.clipboard_task_24_filled,
                    color: Color(0xffbdbdbd),
                  ),
                  label: 'Tasks',
                ),
              ],
            ),
          ),
        ));
  }
}
