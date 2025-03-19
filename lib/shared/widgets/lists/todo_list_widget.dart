import 'package:flutter/material.dart';
import 'package:plan_your_live/models/todolist/recently_removed.dart';
import 'package:plan_your_live/models/todolist/todo_model.dart';
import 'package:plan_your_live/providers/todolist.dart';
import 'package:plan_your_live/shared/utils/dialog.dart';
import 'package:plan_your_live/shared/widgets/card/todo_card.dart';
import 'package:plan_your_live/shared/widgets/dialog/create_todo_dialog.dart';
import 'package:plan_your_live/shared/widgets/lists/base_list_widget.dart';
import 'package:provider/provider.dart';

class TodosListWidget extends StatelessWidget {
  final List<TodoModel> todos;
  final String emptyText;

  const TodosListWidget({
    super.key,
    required this.todos,
    required this.emptyText
  });

  @override
  Widget build(BuildContext context) {
    final todolistProvider = Provider.of<TodolistNotifier>(context);

    return BaseListWidget<TodoModel>(
        items: todos,
        emptyText: emptyText,
        itemBuilder: (context, todo) {
          return TodoCard(
              id: todo.id,
              title: todo.title,
              isChecked: todo.isChecked,
              onTap: () => {
                todolistProvider.checkTodo(todo)
              },
              onPressed: () => {
                DialogUtils.show(context, CreateTodoDialog(todo: todo))
              },
              onDismissed: (DismissDirection direction) async {
                final ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);
                final TextStyle? textTheme = Theme.of(context).textTheme.labelMedium;

                RecentlyRemoved<TodoModel> removed = await todolistProvider.removeTodo(todo);
                scaffoldMessenger.showSnackBar(SnackBar(
                    content: Text('Todo removed', style: textTheme),
                    action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () async {
                          await todolistProvider.undoRemoveTodo(removed);
                        }
                    )
                )
                );
              }
          );
        }
    );
  }
}