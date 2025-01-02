import 'package:flutter/material.dart';
import 'package:plan_your_live/layout/base.dart';
import 'package:plan_your_live/providers/navigation.dart';
import 'package:plan_your_live/shared/widgets/card.dart';
import 'package:provider/provider.dart';

class TodolistsScreen extends StatelessWidget {
  final List<String> items;

  const TodolistsScreen({required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationNotifier>(context);

    return BaseLayout(
      actionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        onPressed: () {
          print("pressed");
        },
        child: const Icon(Icons.add),
      ),
      header: AppBar(title: const Text('Todolists')),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(
                  100,
                  (index) => GestureDetector(
                        onTap: () {
                          navigationProvider.pageController.jumpToPage(2);
                        },
                        child: TodolistCard(
                          title: 'Item$index',
                          description: (index % 2) == 0
                              ? 'Test testbdf f d dfgdfgdfgdge'
                              : null,
                        ),
                      )),
            ),
          ),
        );
      }),
    );
  }
}
