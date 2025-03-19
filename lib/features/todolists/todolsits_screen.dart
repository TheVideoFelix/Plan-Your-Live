import 'package:flutter/material.dart';
import 'package:plan_your_live/layout/base.dart';
import 'package:plan_your_live/providers/todolist.dart';
import 'package:plan_your_live/shared/utils/dialog.dart';
import 'package:plan_your_live/shared/widgets/dialog/create_todolist_dialog.dart';
import 'package:plan_your_live/shared/widgets/lists/todolist_list_widget.dart';
import 'package:provider/provider.dart';

class TodolistsScreen extends StatelessWidget {
  const TodolistsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
        actionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          onPressed: () {
            DialogUtils.show(context, CreateTodolistDialog());
          },
          child: const Icon(Icons.add),
        ),
        header: AppBar(title: Text('Todolists', style: Theme.of(context).textTheme.displayLarge,)),
        body: Consumer<TodolistNotifier>(builder: (ctx, todolistNotifier, _) {
          if (todolistNotifier.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return TodolistsListWidget(
                todolists: todolistNotifier.todolists,
                emptyText: "No todolists available. Create one!"
            );
          }
        }));
  }
}