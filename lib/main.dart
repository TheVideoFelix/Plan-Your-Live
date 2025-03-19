import 'package:flutter/material.dart';
import 'package:plan_your_live/app/app.dart';
import 'package:plan_your_live/app/providers.dart';
import 'package:plan_your_live/shared/db/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService().database;
  runApp(const AppProvider(child: MyApp()));
}