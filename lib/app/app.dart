import 'package:flutter/material.dart';
import 'package:plan_your_live/features/home/home_screen.dart';
import 'package:plan_your_live/features/settings/setting_screen.dart';
import 'package:plan_your_live/features/todolist/todolist_screen.dart';
import 'package:plan_your_live/features/todolists/todolsits_screen.dart';
import 'package:plan_your_live/providers/navigation.dart';
import 'package:plan_your_live/providers/todolist.dart';
import 'package:plan_your_live/shared/utils/const.dart';
import 'package:plan_your_live/shared/widgets/navigation/bottom_navigation.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<void> _fetchDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = Provider.of<TodolistNotifier>(context, listen: false).fetchAndSetTodolistWithTodos();
  }

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationNotifier>(context);

    final List pages = [
      const HomeScreen(), // 0
      const TodolistsScreen(), // 1
      const TodolistScreen(), // 2
      const SettingScreen(), // 3
    ];

    return MaterialApp(
      theme: Constants.theme,
      title: Constants.appName,
      home: FutureBuilder(
          future:_fetchDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()
                ),
              );
            } else if (snapshot.hasError) {
              return const Scaffold(body: Center(child: Text('An error occurred!')));
            } else {
              return Scaffold(
                body: PageView(
                  controller: navigationProvider.pageController,
                  onPageChanged: (int index) {
                    navigationProvider.setIndex(index);
                  },
                  children: List.generate(pages.length, (index) => pages[index]),
                ),
                bottomNavigationBar: const BottomNavigation(),
              );
            }
          }),
    );
  }
}