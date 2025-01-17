import 'package:flutter/material.dart';
import 'package:plan_your_live/layout/base.dart';
import 'package:plan_your_live/providers/navigation.dart';
import 'package:plan_your_live/shared/utils/dialog.dart';
import 'package:plan_your_live/shared/widgets/card/todo_card.dart';
import 'package:plan_your_live/shared/widgets/dialog/create_todo_dialog.dart';
import 'package:provider/provider.dart';

class TodolistScreen extends StatelessWidget {
  const TodolistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationNotifier>(context);

    return BaseLayout(
      actionButton: FloatingActionButton(
        onPressed: () {
          DialogUtils.show(context, const CreateTodoDialog());
        },
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        child: const Icon(Icons.add),
      ),
      header: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
            onPressed: () {
              navigationProvider.pageController.jumpToPage(1);
            },
            icon: const Icon(Icons.arrow_back),
            iconSize: 25,
          )),
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Todolist Name', style: TextStyle(fontSize: 28.0)),
                        Text('discrption of todolist',
                            style: TextStyle(fontSize: 15))
                      ],
                    ),
                  ),
                )
              ],
            ),
            Expanded(
                child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.generate(
                      20,
                      (index) => TodoCard(
                          id: '$index',
                          title: 'Title $index',
                          isChecked: (index % 3 == 0),
                          onTap: () => {print("tap")},
                          onPressed: () => {print("pressed")},
                          onDismissed: (DismissDirection direction) =>
                              {print("pressed")})),
                ),
              ),
            )),
          ],
        );
      }),
    );
  }
}
