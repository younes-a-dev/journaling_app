import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart' as ts;

class ToggleSwitchWidget extends StatelessWidget {
  const ToggleSwitchWidget(
      {required this.title,
      required this.initValue,
      required this.labels,
      required this.onToggleFunction,
      key});
  final int? initValue;
  final String title;
  final List<String> labels;
  final Function onToggleFunction;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 40,
        // width: size.width * .7,
        decoration: BoxDecoration(
            color: const Color(0xff212121),
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xffbdbdbd),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: size.width * .3,
              child: Align(
                alignment: Alignment.center,
                child: ts.ToggleSwitch(
                  //minWidth: MediaQuery.of(context).size.width / 2,
                  //minHeight: 60.0,
                  // customHeights: const [30, 30,30],
                  minHeight: 30,
                  fontSize: 14.0,
                  initialLabelIndex: initValue,
                  activeBgColor: const [Color(0xff212121)],
                  activeFgColor: const Color(0xffffca28),
                  inactiveBgColor: const Color(0xff212121),
                  inactiveFgColor: const Color(0xff616161),
                  totalSwitches: 2,
                  labels: labels,
                  onToggle: (index) {
                    onToggleFunction(index);
                  },

                  // (index) {
                  //   //print('switched to: $index');
                  //   // _currencyValue = index!;
                  //   // setState(() {
                  //   //   setPrefix(index);
                  //   // });
                  // },
                ),
              ),
            ),
          ],
        ));
  }
}
