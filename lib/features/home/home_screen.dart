import 'package:flutter/material.dart';
import 'package:plan_your_live/layout/base.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      header: AppBar(title: const Text('Home Screen')),
      body: Container(
        constraints: const BoxConstraints.expand(),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              child: const Text('Welcome back', style: TextStyle(
                fontSize: 30
              )),
            ),
          ],
        ),
      ),
    );
  }

}