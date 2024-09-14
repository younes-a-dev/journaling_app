import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class CmAppBar extends StatelessWidget {
  const CmAppBar({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff000000),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xffbdbdbd),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {},
              child: const Icon(
                FluentIcons.more_vertical_48_filled,
                color: Color(0xffbdbdbd),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
