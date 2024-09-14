import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trading_journal/core/utils/constants/app_size.dart';
import 'package:trading_journal/core/widgets/main_wrapper.dart';

class SpashScreen extends StatefulWidget {
  const SpashScreen({super.key});

  @override
  State<SpashScreen> createState() => _SpashScreenState();
}

class _SpashScreenState extends State<SpashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const MainWrapper(),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xff000000),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(120.0),
            child: Image.asset('assets/images/splash Image.png'),
          ),
          gapH64,
          const CircularProgressIndicator(
            color: Color(0xffffca28),
            strokeWidth: 1,
          ),
        ],
      ),
    );
  }
}
