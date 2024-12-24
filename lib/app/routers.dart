import 'package:flutter/material.dart';
import 'package:plan_your_live/features/home/home_screen.dart';
import 'package:plan_your_live/features/todolists/todolsits_screen.dart';

enum AppRoute { home, todolists }

class RouteGenerator {
  static String routeName(AppRoute route) {
    switch (route) {
      case AppRoute.home:
        return '/';
      case AppRoute.todolists:
        return 'todolists';
      default:
        return '/';
    }
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/todolists':
        return MaterialPageRoute(builder:  (_) => const TodolistsScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(child: Text('No route was found!')),
                ));
    }
  }
}
