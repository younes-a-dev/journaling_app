import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_journal/features/note/domin/entity/note.dart';
import 'package:trading_journal/features/note/presentation/bloc/get_notes_status.dart';
import 'package:trading_journal/features/note/presentation/screen/note_detail_screen.dart';
import 'package:trading_journal/features/note/presentation/widgets/note_item.dart';

import '../../../../core/utils/constants/app_size.dart';
import '../bloc/note_bloc.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  static const routeName = '/ Note Screen';

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NoteBloc>(context).add(GetNotesEvent());
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff000000),
        appBar: AppBar(
          backgroundColor: const Color(0xff000000),
          title: const Text(
            'Notes',
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
                          'Delete all  notes',
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
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gapH16,
              BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
                if (state.getNotesStatus is GetNotesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }
                if (state.getNotesStatus is GetNotesCompleted) {
                  final GetNotesCompleted getNotesCompleted =
                      state.getNotesStatus as GetNotesCompleted;
                  final List<Note> notes = getNotesCompleted.notes;

                  if (notes.isNotEmpty) {
                    return Expanded(
                      child: GridView.builder(
                        itemCount: notes.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 2 / 3,
                          mainAxisExtent: size.height * .25,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NoteDetailScreen(note: notes[index])),
                                ).then((value) {
                                  setState(() {});
                                });
                              },
                              child: NoteItem(note: notes[index]));
                        },
                      ),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.only(top: size.height / 3),
                    child: const Center(
                      child: Column(
                        children: [
                          Icon(FluentIcons.notepad_32_regular,
                              color: Colors.white38, size: 28),
                          gapH16,
                          Text(
                            'No nots here yet',
                            style:
                                TextStyle(color: Colors.white38, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (state.getNotesStatus is GetNotesError) {
                  return const Center(child: Text('Something went wromg!'));
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
                NoteDetailScreen.routeName,
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
            "Are you sure you want to delete all notes?",
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
                  BlocProvider.of<NoteBloc>(context).add(DeleteAllNotesEvent());
                  Navigator.of(context).pop();
                },
                child: const Text('Yes', style: TextStyle(color: Colors.red))),
          ],
        );
      },
    );
  }
}
