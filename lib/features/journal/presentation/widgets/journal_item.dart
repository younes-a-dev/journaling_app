import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trading_journal/core/utils/constants/app_size.dart';
import 'package:trading_journal/features/journal/domin/entity/journal.dart';

class JournalItem extends StatelessWidget {
  const JournalItem({required this.journal, super.key});
  final Journal journal;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xff212121),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * .15,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(
                journal.imageByte!,
                fit: BoxFit.fill,
              ),
            ),
          ),
          gapH8,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Color(journal.colorValue!),
                  ),
                ),
                gapW8,
                Text('${journal.title}',
                    style: const TextStyle(
                        color: Color(0xffbdbdbd),
                        fontSize: 18,
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
          gapH8,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Direction : ',
                      style: TextStyle(color: Color(0xff616161)),
                    ),
                    Text(
                      'Status : ',
                      style: TextStyle(color: Color(0xff616161)),
                    ),
                  ],
                ),
                // gapW4,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      journal.direction!,
                      style: TextStyle(
                        color: journal.direction == 'Long'
                            ? Colors.green.withOpacity(.6)
                            : Colors.red.withOpacity(.6),
                      ),
                    ),
                    Text(
                      journal.status!,
                      style: TextStyle(
                        color: journal.status == 'Win'
                            ? Colors.green.withOpacity(.6)
                            : Colors.red.withOpacity(.6),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  SizedBox(
                    width: size.width / 3,
                    child: Text(
                      // DateFormat.yMMMMd('en_US')
                      //     .add_jm()
                      //     .format(journal.dateTime!),
                      DateFormat('EEE-MMM d, y HH:mm')
                          .format(journal.selectedDateTime!),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: const TextStyle(color: Color(0xff616161)),
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
