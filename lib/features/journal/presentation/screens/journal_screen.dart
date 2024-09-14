import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_journal/core/utils/constants/app_size.dart';
import 'package:trading_journal/features/journal/domin/entity/journal.dart';
import 'package:trading_journal/features/journal/presentation/bloc/get_journals_status.dart';
import 'package:trading_journal/features/journal/presentation/screens/journal_add_up_screen.dart';
import 'package:trading_journal/features/journal/presentation/screens/journal_detail_screen.dart';

import '../bloc/journal_bloc.dart';
import '../widgets/journal_item.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<JournalBloc>(context).add(GetJournalsEvent());
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff000000),
        appBar: AppBar(
          backgroundColor: Color(0xff000000),
          title: const Text(
            'Journals',
            style: TextStyle(
              color: Color(0xffbdbdbd),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_outline_rounded,
                          color: Color(0xffbdbdbd),
                        ),
                        gapW12,
                        Text(
                          'Delete all  journals',
                          style: TextStyle(color: Color(0xffbdbdbd)),
                        ),
                      ],
                    ),
                  ),
                ],
                color: const Color(0xff212121),
                elevation: 2,
                child: const Icon(
                  FluentIcons.more_vertical_48_regular,
                  color: Color(0xffbdbdbd),
                ),
                // on selected we show the dialog box
                onSelected: (value) {
                  if (value == "delete") {
                    _showDialog(context).then((_) {
                      setState(() {});
                    });
                  }
                },
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gapH16,
              BlocBuilder<JournalBloc, JournalState>(builder: (context, state) {
                if (state.getJournalsStatus is GetJournalsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.getJournalsStatus is GetJournalsCompleted) {
                  final GetJournalsCompleted getJournalsCompleted =
                      state.getJournalsStatus as GetJournalsCompleted;
                  List<Journal> journals =
                      getJournalsCompleted.journals.reversed.toList();
                  if (journals.isNotEmpty) {
                    return Expanded(
                      child: GridView.builder(
                        itemCount: journals.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 2 / 3,
                          mainAxisExtent: size.height * .29,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => JournalDetailScreen(
                                            journal: journals[index],
                                          )),
                                ).then((value) {
                                  setState(() {});
                                });
                              },
                              child: JournalItem(journal: journals[index]));
                        },
                      ),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.only(top: size.height / 3),
                    child: const Center(
                      child: Column(
                        children: [
                          Icon(FluentIcons.document_page_top_left_24_regular,
                              color: Colors.white38, size: 28),
                          gapH16,
                          Text(
                            'No journals here yet',
                            style:
                                TextStyle(color: Colors.white38, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (state.getJournalsStatus is GetJournalsError) {
                  return const Center(
                    child: Text(
                      'Error',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                return Container();
              }),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 20, bottom: 20),
          child: FloatingActionButton(
            backgroundColor: const Color(0xffffca28),
            elevation: 0,
            foregroundColor: const Color(0xff212121),
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(
                JournalAddUpScreen.routeName,
              )
                  .then((value) {
                setState(() {});
              });
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  Future<void> _showDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff212121),
          title: const Text(
            "Delete",
            style: TextStyle(color: Color(0xffbdbdbd), fontSize: 18),
          ),
          content: const Text(
            "Are you sure you want to delete all journals?",
            style: TextStyle(
              color: Color(0xffbdbdbd),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child:
                    const Text('No', style: TextStyle(color: Colors.white30))),
            TextButton(
                onPressed: () {
                  BlocProvider.of<JournalBloc>(context)
                      .add(DeleteAllJournalsEvent());
                  Navigator.of(context).pop();
                },
                child: const Text('Yes', style: TextStyle(color: Colors.red))),
          ],
        );
      },
    );
  }
}
