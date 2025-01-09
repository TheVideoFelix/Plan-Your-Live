import 'package:flutter/material.dart';
import 'package:plan_your_live/layout/base.dart';
import 'package:plan_your_live/models/todolist/todo_model.dart';
import 'package:plan_your_live/providers/navigation.dart';
import 'package:plan_your_live/shared/widgets/card/todo_card.dart';
import 'package:provider/provider.dart';

class TodolistScreen extends StatelessWidget {
  const TodolistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationNotifier>(context);

    return BaseLayout(
      actionButton: FloatingActionButton(onPressed: () {
        print("pressed");
      }, child: const Icon(Icons.add),
      backgroundColor: Theme.of(context).colorScheme.onPrimary,),
      header: AppBar(
        automaticallyImplyLeading: true,
      leading: IconButton(onPressed: () {
        navigationProvider.pageController.jumpToPage(1);
      }, icon: const Icon(Icons.arrow_back), iconSize: 25,)),
      body: LayoutBuilder(builder: (context, constraints) {
        return  Column(
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  child: Padding(padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Todolist Name', style: TextStyle(fontSize: 28.0)),
                      Text('discrption of todolist', style: TextStyle(fontSize: 15))
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
                      children: List.generate(20, (index) => GestureDetector(
                        onTap: () {
                          const snackBar = SnackBar(
                            content: Text('Tapped'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        onLongPress: () {
                          const snackBar = SnackBar(
                            content: Text('Pressed'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: Dismissible(key: const Key('ds'),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (direction) {
                              const snackBar = SnackBar(
                                content: Text('Dismissed'),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                            },
                            child: TodoCard(
                                id: '$index',
                                title: 'Title $index',
                                isChecked: (index % 3 == 0),
                                onTap: () => {
                                  print("tap")
                                },
                                onPressed: () => {
                                  print("pressed")
                                },
                                onDismissed: (DismissDirection direction) => {
                                  print("pressed")
                                }
                            )


                          //TodoCard(title: 'Todo test $index.', isChecked: (index % 3) == 0)
                         ),
                      )),
                    ),
                  ),
                )),

          ],
          );
      }),
    );
  }

}