import 'package:flutter/material.dart';
import 'package:plan_your_live/layout/base.dart';
import 'package:plan_your_live/providers/navigation.dart';
import 'package:plan_your_live/providers/todolist.dart';
import 'package:plan_your_live/shared/utils/dialog.dart';
import 'package:plan_your_live/shared/widgets/dialog/create_todo_dialog.dart';
import 'package:plan_your_live/shared/widgets/lists/todo_list_widget.dart';
import 'package:provider/provider.dart';

class TodolistScreen extends StatelessWidget {
  const TodolistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationNotifier>(context);

    return BaseLayout(
      actionButton: FloatingActionButton(
        onPressed: () {
          DialogUtils.show(context, CreateTodoDialog());
        },
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        child: const Icon(Icons.add),
      ),
      header: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
            onPressed: () {
              navigationProvider.jumpToPage(navigationProvider.previousPage);
            },
            icon: const Icon(Icons.arrow_back),
            iconSize: 25,
          )),
      body: Consumer<TodolistNotifier>(builder: (ctx, todolistNotifier, _) {
        if (todolistNotifier.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (todolistNotifier.todolist == null) {
          return Center(
            child: Text('No content of todolist is available.', style: Theme.of(context).textTheme.titleSmall)
          );
        } else {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(todolistNotifier.todolist!.title, style: Theme.of(context).textTheme.displayLarge),
                          Text(todolistNotifier.todolist!.description ?? "",
                              style: Theme.of(context).textTheme.displaySmall)
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                  child: TodosListWidget(todos: todolistNotifier.todolist!.todos, emptyText: "No todos available. Create one!")
              ),
            ],
          );
        }
      })
    );
  }
}
