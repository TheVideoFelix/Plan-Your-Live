import 'package:flutter/material.dart';
import 'package:plan_your_live/layout/base.dart';

class TodolistsScreen extends StatelessWidget {
  const TodolistsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
        body: Column(
          children: [
            const Text('Todolists'),
            ElevatedButton(onPressed: () {
              Navigator.pop(context);
            }, child: const Text('Go back'))
          ],
        ),
    );
  }
  
}