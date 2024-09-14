import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/constants/app_size.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  static const routeName = '/notification screen';

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor:const Color(0xff000000),
          iconTheme:const IconThemeData(color: Color(0xffbdbdbd)),
          title: const Text(
            'Notifications',
            style: TextStyle(
              color: Color(0xffbdbdbd),
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor:const Color(0xff000000),
        body: const Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FluentIcons.alert_48_regular,
                  color: Colors.white38, size: 28),
              gapH16,
              Text(
                'You have no notifications',
                style: TextStyle(color: Colors.white38, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
