import 'package:flutter/material.dart';
import 'package:plan_your_live/layout/base.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BaseLayout(
      header: AppBar(title: const Text('Home Screen')),
      body: Column(
        children: [
          const Text('Hello World'),
          ElevatedButton(onPressed: () {
            Navigator.pushNamed(context, '/todolists');
          }, child: const Text('Go to Todolists'))
        ],
      ),
    );
  }

}