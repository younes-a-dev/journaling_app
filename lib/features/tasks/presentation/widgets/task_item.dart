import 'package:flutter/material.dart';

import '../../../../core/utils/constants/app_size.dart';
import '../../domin/entity/task.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({this.task, super.key});
  final Task? task;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xff212121),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Checkbox(
          //   value: value,
          //   onChanged: (value) {},
          // ),
          gapW12,
          SizedBox(
            width: size.width * .25,
            child: Text('${task!.content}',
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
    );
  }
}
