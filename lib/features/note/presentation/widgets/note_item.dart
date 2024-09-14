import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trading_journal/features/note/domin/entity/note.dart';

import '../../../../core/utils/constants/app_size.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({required this.note, super.key});

  final Note note;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xff212121),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Color(note.colorValue!),
                ),
              ),
              gapW8,
              SizedBox(
                width: size.width * .25,
                child: Text('${note.title}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: const TextStyle(
                        color: Color(0xffbdbdbd),
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
            child: Text(
              '${note.content}',
              style: const TextStyle(color: Color(0xff616161)),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Text(
                DateFormat.yMMMMd('en_US').add_jm().format(note.dateTime!),
                style: const TextStyle(color: Color(0xff616161), fontSize: 13),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
