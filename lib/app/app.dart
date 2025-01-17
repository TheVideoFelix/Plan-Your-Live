import 'package:flutter/material.dart';
import 'package:plan_your_live/features/home/home_screen.dart';
import 'package:plan_your_live/features/todolist/todolist_screen.dart';
import 'package:plan_your_live/features/todolists/todolsits_screen.dart';
import 'package:plan_your_live/providers/navigation.dart';
import 'package:plan_your_live/shared/utils/const.dart';
import 'package:plan_your_live/shared/widgets/navigation/bottom_navigation.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationNotifier>(context);

    final List pages = [
      const HomeScreen(),
      const TodolistsScreen(),
      const TodolistScreen()
    ];

    return MaterialApp(
      theme: Constants.theme,
      title: Constants.appName,
      home: Scaffold(
        body: PageView(
          controller: navigationProvider.pageController,
          onPageChanged: (int index) {
            navigationProvider.setIndex(index);
          },
          children: List.generate(3, (index) => pages[index]),
        ),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }
}