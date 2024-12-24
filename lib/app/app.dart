import 'package:flutter/material.dart';
import 'package:plan_your_live/app/routers.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plan your Live',
      initialRoute: RouteGenerator.routeName(AppRoute.home),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}