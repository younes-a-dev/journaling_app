import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_journal/core/utils/constants/app_size.dart';
import 'package:trading_journal/features/note/domin/entity/note.dart';
import 'package:trading_journal/features/note/presentation/bloc/note_bloc.dart';

import '../../../../core/widgets/popup_menu_button_widget.dart';

class NoteDetailScreen extends StatefulWidget {
  const NoteDetailScreen({this.note, super.key});

  final Note? note;
  static const routeName = '/NoteDetailScreen';

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late TextEditingController titleController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();
  int colorValue = 0xffE4FF1A;

  @override
  void initState() {
    colorValue = widget.note?.colorValue ?? 0xffE4FF1A;
    titleController = TextEditingController(text: widget.note?.title ?? '');
    descriptionController =
        TextEditingController(text: widget.note?.content ?? '');
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  int _descriptionCracter(String value) {
    int cNumers = 0;
    setState(() {
      value.length;
    });
    return cNumers;
  }

  void setColor(int color) {
    colorValue = color;
  }

  Future<dynamic>? _onPop(bool didPop) async {
    Note note = Note(
      title: titleController.text,
      content: descriptionController.text,
      dateTime: widget.note?.dateTime ?? DateTime.now(),
      colorValue: colorValue,
    );

    // If the note exists, update it, otherwise, create a new note
    if (widget.note != null) {
      BlocProvider.of<NoteBloc>(context).add(DeleteNoteEvent(widget.note!));
    }
    BlocProvider.of<NoteBloc>(context).add(AddNotesEvent(note));

    // Allow the pop to proceed
    return true;
  }

  void saveNote() {
    Note note = Note(
        title: titleController.text,
        content: descriptionController.text,
        dateTime: DateTime.now(),
        colorValue: colorValue);

    // add new note
    if (widget.note == null) {
      BlocProvider.of<NoteBloc>(context).add(AddNotesEvent(note));
      Navigator.of(context).pop();
    }
    // update note
    if (widget.note != null) {
      BlocProvider.of<NoteBloc>(context).add(DeleteNoteEvent(widget.note!));
      BlocProvider.of<NoteBloc>(context).add(AddNotesEvent(note));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        if (titleController.text.isNotEmpty ||
            descriptionController.text.isNotEmpty) {
          saveNote();
        }
        if (titleController.text.isEmpty &&
            descriptionController.text.isEmpty) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xff000000),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xff000000),
          iconTheme: const IconThemeData(color: Color(0xffbdbdbd)),
          actions: [
            if (widget.note != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  onPressed: () {
                    BlocProvider.of<NoteBloc>(context)
                        .add(DeleteNoteEvent(widget.note!));
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: Color(0xffbdbdbd),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty ||
                      descriptionController.text.isNotEmpty) {
                    saveNote();
                  }
                  if (titleController.text.isEmpty &&
                      descriptionController.text.isEmpty) {
                    Navigator.of(context).pop();
                  }
                },
                icon: const Icon(Icons.done),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                style: const TextStyle(color: Color(0xff616161)),
                maxLines: 1,
                cursorColor: const Color(0xffbdbdbd),
                decoration: const InputDecoration(
                  hintText: 'Title',
                  hintStyle: TextStyle(color: Color(0xff616161)),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
              Row(
                children: [
                  Text(
                    DateFormat.yMMMMd('en_US').add_jm().format(
                        widget.note == null
                            ? DateTime.now()
                            : widget.note!.dateTime!),
                    style: const TextStyle(color: Color(0xff616161)),
                  ),
                  gapW8,
                  const SizedBox(
                    height: 10,
                    child: VerticalDivider(
                      color: Color(0xff616161),
                    ),
                  ),
                  gapW8,
                  Text(
                    '${descriptionController.text.characters.length} characters',
                    style: const TextStyle(color: Color(0xff616161)),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 50,
                    child: PopUpMenuColorButtonWidget(
                      menuList: [
                        ...MenuItem.colors
                            .map((item) => PopupMenuItem<PopupMenuItemModel>(
                                  // padding:
                                  //     const EdgeInsets.only(left: 2, right: 2),
                                  child: item.widget,

                                  onTap: () {
                                    setState(() {
                                      setColor(item.colorValue!);
                                    });
                                  },
                                ))
                      ],
                      colorValue: colorValue,
                      // title: _timeTitle,
                      // widthSize: size.width * .005,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TextField(
                  controller: descriptionController,
                  maxLines: 100,
                  style: const TextStyle(color: Color(0xff616161)),
                  cursorColor: const Color(0xffbdbdbd),
                  onChanged: (value) {
                    _descriptionCracter(value);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Description',
                    hintStyle: TextStyle(color: Color(0xff616161)),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
