import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:plan_your_live/features/home/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Plan your Live',
      home: HomeScreen(),
    );
  }
}